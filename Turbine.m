% FUNCTION THAT FINDS THE OUTPUT ENTHALPY OF A TURBINE
% ASSUME WORKING FLUID IS AIR 
% INPUTS:
% 	T_in (Kelvin)
% 	P_in (kPa)
% 	eff 
% 	molar fraction (1x5 vector)

% DEPENDENCIES: 
% 	propertycalc.m

% Created:
% 	Michael Lee
% 	The University of Texas at Austin
% Last Modified:
% 	3/20/13

function h_out = turbine(T_in, P_in, r, eff, X)
	
	%FIND IDEAL OUTPUT TEMPERATURE 
	T_out_s = T_in *


