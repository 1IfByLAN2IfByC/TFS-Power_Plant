%%
% MAIN FUNCTION FOR  ME 343, THERMOFLUID SYSTEMS AT UT AUSTIN POWER PLANT PROJECT

% DEPENDENCIES:
% 	compressor.m 
% 	toSI.m
% 	turbine.m
%	mass_fract.m

% LAST MODIFIED: 
% 	3/28/13
%
%%

%DEFINE INPUT OPERATING PARAMETERS
P_0 = 14.17; %psi
T_0 = 65; %F
RH_0 = .60; 
ALT = 530; %ft 
m_in = 189.7; %lb/s
P_loss_in = 4; %psi
P_loss_out = 10; %psi
LHV = 20.185; %BTU/lb
Y = [.01, 0, .78, .21, 0];
M = [39.948 44.01 28.013 31.99 18.015]; %kg/kmol

%%

% INPUT DESIGN PARAMETERS 
% compression ratios
	r_lp = 6; 
	r_hp = 4; 

m_by = 0; %bypass mass flow percent
m_bl = 0; %parasitic bleed percent

%compressor efficiencies
	eff_comp_lp = .82;
	eff_comp_hp = .84;
%turbine efficiencies
	% T_lp_ef = ??? T_hp_ef = ???

Gen_ef = .977;
state4(1,1) = 2200; %F 

%%

% CONVERT EVERYTHING TO SI UNITS FOR CALCULATIONS 
P_0 = toSI(P_0, 'P'); 
T_0 = toSI(T_0, 'T');
ALT = toSI(ALT, 'L');
m_in = toSI(m_in, 'm_dot');
P_loss_in = toSI(P_loss_in, 'P');
P_loss_out = toSI(P_loss_out, 'P');

%%

% DECOMPOSE THE COMPOSITION VECTOR TO EACH CONSTITUIENT GAS
arg = Y(1);
co2 = Y(2);
nit = Y(3);
oxy = Y(4);
h20 = Y(5);

%%

%CALCULATE THE PRESSURE LOSS THROUGH STAGE 1
h_0 = propertycalc(T_0, P_0, Y); 

%STATE VECTOR DEFINED AS [T, P, H, C_P]

state1(1,1) = (T_0 / P_0) * (P_0 - P_loss_in); 
state1(1,2) = P_0 - P_loss_in;
state1(1,3:4) = propertycalc(state1(1,1), state1(1,2), Y);

%FIND OUTPUT OF FIRST COMPRESSOR 
state2 = compressor(state1(1,1), state1(1,2), r_lp, eff_comp_lp, Y); 

%FIND OUTPUT OF SECOND COMPRESSOR
state3 = compressor(state2(1,1), state2(1,2), r_hp, eff_comp_hp, Y);


















