% FUNCTION THAT FINDS THE OUTPUT ENTHALPY OF A TURBINE
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

function eff = turbine(T_in, P_in, T_out, P_out, Y)
	
	state_in = [];
	state_out = [];
	state_out_s = [];

	state_in(1,1:2) = [T_in, P_in];
	state_in(1,3:4) = propertycalc(T_in, P_in, Y); 

	state_out(1,1:2) = [T_out, P_out];
	state_out(1,3:4) = propertycalc(T_out, P_out, Y); 

	%RUN A BISECTION AROUND THE STATE IN ENTROPY TO FIND T_OUT_S
	state_out_s(1,1) = Bisect_entropy(state_in(1,1), state_in(1,2), state_out(1,2), 2*T_out, .5*T_out, Y, .0000001 );
	state_out_s(1,2) = P_out;
	state_out_s(1,3:4) = propertycalc(state_out_s(1,1), state_out(1,2), Y); 
	
	state_in;
	state_out;
	state_out_s;
	%CALCULATE EFF.

	eff = ( state_in(1,3) - state_out(1,3) ) / ( state_in(1,3) - state_out_s(1,3)); 


	




