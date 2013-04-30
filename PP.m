%%
% MAIN FUNCTION FOR  ME 343, THERMOFLUID SYSTEMS AT UT AUSTIN POWER PLANT PROJECT

% DEPENDENCIES:
% 	compressor.m 
% 	toSI.m
% 	turbine.m
%	mass_fract.m

% LAST MODIFIED: 
% 	3/31/13
%
%%
function metrics = PP(RH_0, T_0, T_fire, eff_comp_lp, eff_comp_hp, eff_turb_lp, m_in)

%DEFINE INPUT OPERATING PARAMETERS
tic
P_0 = 14.17; %psi
% T_0 = 65; %F
% T_out = 996; %F
% RH_0 = .6; 
ALT = 530; %ft 
% m_in = 189.7; %lb/s
P_loss_in = 1; %kpa
P_loss_out = 2.5; %kpa
Y = [.01, 0, .78, .21, 0];
M = [39.948 44.01 28.013 31.99 18.015]; %kg/kmol
% LHV = 45806; %kJ/kg
fuel = [.5 0 .5 0 0 0 0 0];
% T_fire = 2200; %F
    
%%

% INPUT DESIGN PARAMETERS 
% compression ratios
	r_lp = 6; 
	r_hp = 4; 

m_by = 0; %bypass mass flow percent
m_bl = 0; %parasitic bleed percent

% efficiencies
	% eff_comp_lp = .82;
	% eff_comp_hp = .84;
	Gen_eff = .977;
	eff_turb_hp = .945;

state4(1,1) = T_fire; %F 


%%

% CONVERT EVERYTHING TO SI UNITS FOR CALCULATIONS 
P_0 = toSI(P_0, 'P'); 
T_0 = toSI(T_0, 'T');
% T_out = toSI(T_out, 'T');
ALT = toSI(ALT, 'L');
m_in = toSI(m_in, 'm_dot');
state4(1,1) = toSI(state4(1,1), 'T'); 

%%

% DECOMPOSE THE COMPOSITION VECTOR TO EACH CONSTITUIENT GAS
Y = wet_air(RH_0, T_0, P_0);

%%

% ADD CHILLING UNIT TO MORE REALISTICALLY MODEL PLANT


% CALCULATE THE PRESSURE LOSS THROUGH STAGE 1
state0(1,1) = T_0;
state0(1,2) = P_0;
state0(1, 3:4) = propertycalc(T_0, P_0, Y); 
state0(1, 3:4) = state0(1, 3:4) ;
%STATE VECTOR DEFINED AS [T, P, H, C_P]

state1(1) = T_0; 
state1(2) = P_0 - P_loss_in;
state1(3:4) = propertycalc(state1(1), state1(2), Y);
state1(3:4) = state1(3:4);

%FIND OUTPUT OF FIRST COMPRESSOR 
state2 = compressor(state1, r_lp, eff_comp_lp, Y);
state2(1, 3:4) = state2(1, 3:4);

%FIND OUTPUT OF SECOND COMPRESSOR
state3 = compressor(state2, r_hp, eff_comp_hp, Y);
state3(1, 3:4) = state3(1, 3:4);

%FIND Q IN 
%state4(1,2) = state3(1,2);
%state4(1, 3:4) = propertycalc(state4(1,1), state4(1,2), Y);
%state4(1, 3:4) = state4(1, 3:4);

combustor_out = fuelcomp(fuel, Y, state3(1,1), T_fire);
exhaust = combustor_out(1,:);
AF = combustor_out(2,2);
LHV = combustor_out(2,1);
s_form = combustor_out(2,3);
state4(2) = state3(2);
state4(3:4) = propertycalc(state4(1), state4(2), exhaust);

%ENERGY BALANACE AROUND THE COMUBSTOR TO FIND RATE OF FUEL IN
% m_fuel = ( m_in*( state4(3) - state3(3) ) ) / (LHV - state4(3) )
m_fuel = m_in / AF;

%FIND STATE 5  (FIRST TURBINE)
% T_eff_lp = Turbine_state_in(state4, state5(1), state5(2), exhaust);
% state5(1, 3:4) = propertycalc(state5(1), state5(2), exhaust);
W_comp = (state2(3)-state1(3)) + (state3(3) - state2(3))
state5 = turbine_hp(state4, W_comp, eff_turb_hp, exhaust );
W_turb_hp = state4(3)-state5(3)

%WORK BACKWARDS FROM EXIT STATE 
%FINAL STATE 
% state7(1,1:2) = [T_out,P_0]; 
% state7(1,3:4) = propertycalc(state7(1), state7(2), exhaust);


% account for pressure loss account VIVG
P_turbine_lp = P_0 + P_loss_out;

%STATE 6 (LEAVING FINAL TURBINE)
% state6(1,1:2) = [T_out, P_0 + P_loss_out];
% state6(1,3:4) = propertycalc(state6(1), state6(2), exhaust);
% T_eff_hp = Turbine_state_in(state5, state6(1), state6(2), exhaust);

state6 = turbine_lp(state5, eff_turb_lp, exhaust, P_turbine_lp);
W_turb_lp = state5(3) - state6(3)
m_fuel 
% find final outlet state
state7(1:2) = [state6(1), P_0];
state7(3:4) = propertycalc(state7(1), state7(2), exhaust);
%FIND ELECTRICAL OUTPUT VIA THE GENERATOR 
elec_gen = m_in * (state5(3) - state6(3)) * Gen_eff;
p_gen = m_in * (state5(3) - state6(3));

%CREATE PROPERTY ARRAY
SYSTEM = [ [state0]; [state1]; [state2]; [state3]; [state4]; [state5]; [state6]; [state7] ];

% therm_eff = ( state5(3) - state6(3) ) / (state4(3) - state3(3));
% therm_eff = ( (m_in+m_fuel)*( state5(3) - state6(3) ) ) / ( (m_in +m_fuel) * state4(3) - m_in*state3(3));
therm_eff = (m_in+m_fuel)*( state5(3) - state6(3) ) / (LHV*m_fuel);
p_gen = m_in * (state5(3) - state6(3));
heat_rate = ( state4(3) - state3(3) ) / ((state5(3) - state6(3)) * Gen_eff) ;

state7(1)

%printmat(SYSTEM)
metrics = [RH_0, elec_gen, heat_rate, therm_eff];

  
 
toc















