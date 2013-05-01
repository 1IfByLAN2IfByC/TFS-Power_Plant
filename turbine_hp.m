% FUNCTION THAT FINDS THE OUTPUT ENTHALPY OF A TURBINE BASED ON INLET CONDITIONS
% ASSUME WORKING FLUID IS AIR 
% INPUTS:
% 	T_in (Kelvin)
% 	P_in (kPa)
% 	eff 
% 	molar fraction (1x5 vector)

% DEPENDENCIES: 
% 	propertycalc.m
%	bisect_entropy.m
%	bisect_enthalpy.m

% Created:
% 	Michael Lee
% 	The University of Texas at Austin
% Last Modified:
% 	3/25/13

function state_out = turbine_hp(state_in, W_comp, eff_turb, Y)
	state_out = [];

	%DECOMPOSE THE COMPOSITION VECTOR TO EACH CONSTITUIENT
 %	  arg = X(1);
 %    co2 = X(2);
 %    nit = X(3);
 %    oxy = X(4);
 %    h20 = X(5);

	%CALCULATE THE ENTHALPY IN
	h_in = state_in(3);
 
	% find isentropic enthalpy from enthalpy in and eff. 
	h_s = h_in - (W_comp / eff_turb); 

	% find isentropic temp from guessing temps until h_out = h_s
	T_s = Bisect_enthalpy(h_s, state_in(2), state_in(1)*3,...
	 state_in(1)/3, Y, .0001);

	state_ise = [T_s, state_in(2), h_s, state_in(4)];

	% find pressure out from guessing P until s = s_in | P_s = P_a
	P_out = Bisect_entropy_pressure(state_ise, T_s, 1000, ...
	 100, Y, .001);
 
    P_in = state_in(2);
    P_out; 
	
	% frist turbine is backwork only
	h_find = h_in - W_comp;

	% find T_out_actual guessing until h_out = W_comp
	T_out = Bisect_enthalpy(h_find, P_out, state_in(1)*2, ...
	 state_in(1)/2, Y, .0001); %actual T_out

	% fix outlet state 
	state_out(1:2) = [T_out, P_out];
	state_out(3:4) = propertycalc(T_out, P_out, Y);

   

