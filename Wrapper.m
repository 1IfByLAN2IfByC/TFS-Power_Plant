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

%DEFINE INPUT OPERATING PARAMETERS
tic
P_0 = 14.17; %psi
T_0 = 65; %F
T_out = 996; %F
RH_0 = .6; 
ALT = 530; %ft 
m_in = 189.7; %lb/s
P_loss_in = 1; %kpa
P_loss_out = 2.5; %kpa
LHV = 20185; %BTU/lb
Y = [.01, 0, .78, .21, 0];
Y_exh = [.01, .034, .75, .13, .0751 ];
M = [39.948 44.01 28.013 31.99 18.015]; %kg/kmol


%%

% INPUT DESIGN PARAMETERS 
% compression ratios
	r_lp = 6; 
	r_hp = 4; 

m_by = 0; %bypass mass flow percent
m_bl = 0; %parasitic bleed percent

% efficiencies
	eff_comp_lp = .82;
	eff_comp_hp = .84;
	Gen_ef = .977;

state4(1,1) = 2200; %F 
state5(1,1:2) = [1566.95, 71.09]; %F, psia


%%

% CONVERT EVERYTHING TO SI UNITS FOR CALCULATIONS 
P_0 = toSI(P_0, 'P'); 
T_0 = toSI(T_0, 'T');
T_out = toSI(T_out, 'T');
ALT = toSI(ALT, 'L');
m_in = toSI(m_in, 'm_dot');
state5(1,1) = toSI(state5(1,1), 'T');
state5(1,2) = toSI(state5(1,2), 'P');
state4(1,1) = toSI(state4(1,1), 'T'); 
LHV = toSI(LHV, 'h');

%%

% DECOMPOSE THE COMPOSITION VECTOR TO EACH CONSTITUIENT GAS
Y = wet_air(RH_0, T_0, P_0)

%%

% ADD CHILLING UNIT TO MORE REALISTICALLY MODEL PLANT



% CALCULATE THE PRESSURE LOSS THROUGH STAGE 1
state0(1,1) = T_0;
state0(1,2) = P_0;
% Y = wet_air()
state0(1, 3:4) = propertycalc(T_0, P_0, Y); 
state0(1, 3:4) = state0(1, 3:4) ;
%STATE VECTOR DEFINED AS [T, P, H, C_P]

state1(1,1) = T_0; 
state1(1,2) = P_0 - P_loss_in;
state1(1,3:4) = propertycalc(state1(1,1), state1(1,2), Y);
state1(1, 3:4) = state1(1, 3:4);

%FIND OUTPUT OF FIRST COMPRESSOR 
state2 = compressor(state1(1,1), state1(1,2), r_lp, eff_comp_lp, Y); 
state2(1, 3:4) = state2(1, 3:4);

%FIND OUTPUT OF SECOND COMPRESSOR
state3 = compressor(state2(1,1), state2(1,2), r_hp, eff_comp_hp, Y);
state3(1, 3:4) = state3(1, 3:4);

%FIND Q IN 
state4(1,2) = state3(1,2);
state4(1, 3:4) = propertycalc(state4(1,1), state4(1,2), Y);
state4(1, 3:4) = state4(1, 3:4);

%ENERGY BALANACE AROUND THE COMUBSTOR TO FIND RATE OF FUEL IN
m_fuel = ( m_in*( state4(3) - state3(3) ) ) / (LHV - state4(3) )

%FIND STATE 5  (FIRST TURBINE)
T_eff_lp = Turbine( state4(1), state4(2), state5(1), state5(2), Y);
state5(1, 3:4) = propertycalc(state5(1), state5(2), Y);

%WORK BACKWARDS FROM EXIT STATE 
%FINAL STATE 
state7(1,1:2) = [T_out ,P_0]; 
state7(1,3:4) = propertycalc(state7(1), state7(2), Y_exh);

%STATE 6 (LEAVING FINAL TURBINE)
state6(1,1:2) = [T_out, P_0 + P_loss_out];
state6(1,3:4) = propertycalc(state6(1), state6(2), Y_exh);
T_eff_hp = Turbine(state5(1), state5(2), state6(1), state6(2), Y_exh);


%CREATE PROPERTY ARRAY
SYSTEM = [ [state0]; [state1]; [state2]; [state3]; [state4]; [state5]; [state6]; [state7] ];
T_eff_hp
T_eff_lp

printmat(SYSTEM)


toc
















