% FUNCTION THAT FINDS THE OUTPUT ENTHALPY OF A COMPRESSOR
% ASSUME WORKING FLUID IS AIR 
% INPUTS:
% 	T_in (Kelvin)
% 	P_in (kPa)
% 	eff 
% 	molar fraction (1x5 vector)
%   r_p (pressure ratio)

% DEPENDENCIES: 
% 	propertycalc.m
%	bisect_entropy.m
%	bisect_enthalpy.m

% Created:
% 	Michael Lee
% 	The University of Texas at Austin
% Last Modified:
% 	3/24/13
%%
function state = compressor(state_in, r_p, eff, Y)
	state = [];
	%DECOMPOSE THE COMPOSITION VECTOR TO EACH CONSTITUIENT
 %	  arg = X(1);
 %    co2 = X(2);
 %    nit = X(3);
 %    oxy = X(4);
 %    h20 = X(5);

	%CALCULATE THE ENTHALPY IN
	h_in = state_in(3);

	%CALCULATE THE OUTPUT PROPERTIES BASED ON THE PRESSURE RATIO
	P_out = r_p * state_in(2); 
	T_out = Bisect_entropy(state_in, P_out, state_in(1)*2, state_in(1), Y, .0001); %isentropic Tout

	h_and_s = propertycalc(T_out, P_out, Y); %isentropic enthalpy and entropy

	%USE THE EFFICIENCY RELATIONSHIP TO CALCULATE ACTUAL WORK OUT
	h_out = ( (h_and_s(1) - h_in) / eff ) + h_in; %actual enthalpy
	T_out = Bisect_enthalpy(h_out, P_out, T_out*2, T_out/2, Y, .0001); %actual T_out
	h_and_s = propertycalc(T_out, P_out, Y); 
    
    state = [T_out P_out h_and_s(1) h_and_s(2)];


	


