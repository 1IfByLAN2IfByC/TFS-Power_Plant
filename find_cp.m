% FUNCTION TO SOLVE FOR THE C_P VALUE BASED ON A STARTING TEMP, AND THE FINAL ENTHALPY
% UTILIZES THE POLYNOMIAL C_P FUNCTIONS FOR EACH ELEMENT 
	
% 	INPUTS:
% 		T_in
% 		h_out
%		X 

% 	DEPENDENCICS: 
% 		none

% 	Created:
% 		Michael Lee
% 		The University of Texas at Austin

% 	Last Modified:
% 		3/20/13


%%

function cp_mix = find_cp(T_in, h_out, X)

%IMPORT PROPERTY POLYNOMIAL AND FIND WEIGHTED AVERAGE 

 PROP = [20.7730, 0, 0, 0;
        22.26, (5.981*10^-2), (-3.501*10^-5), (7.469*10^-9);
        28.9, (-.1571*10^-2), (.8081*10^-5), (-2.873*10^-9);
        25.48, (1.52*10^-2), (-.7155*10^-5), (1.312*10^-9);
        32.24, (.1923*10^-2), (1.055*10^-5), (-3.595*10^-9)];

 X = [.01, 0, .78, .21, 0];
 PROP = X * PROP;
 Y = {};
 X = num2str(X, 5)

i=0;
 for i = 1:length(PROP)
 	Y{1,i} = strcat( num2str( PROP(1,i), 10 ), '*x^', int2str(i)); 
 end

polynomial = strjoin(Y, ' + '); 
polynomial = int(polynomial); 











