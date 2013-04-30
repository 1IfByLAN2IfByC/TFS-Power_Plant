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