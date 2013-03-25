% SCRIPT TO CONVERT MURICAN UNITS TO SI
% TAKES TWO INPUTS, A NUMERIC AND AN ALPHA THAT SPECIFIES WHAT KIND OF UNIT IT IS 

% Created:
% 	Michael Lee
% 	The University of Texas at Austin
% Last Modified:
% 	3/20/13

%%

function SI = toSI(number, unit) 
%FOR PRESSURE UNITS IN PSI
	if strcmpi(unit, 'P') == 1 
		SI = number * 6.894757293168361; 
		
%FOR TEMPERATURE UNITS IN F
	elseif strcmpi(unit, 'T') == 1 
		SI = (number-32) *(5/9) +273;
		
%FOR LENGTH TERMS IN FT
	elseif strcmpi(unit, 'L') == 1 
		SI = number * 0.3048; 	

%FOR MASS FLOW RATES IN LB/S
	elseif strcmpi(unit, 'm_dot') == 1
		SI = number * 0.453592;
		
	%FOR SPECIFIC HEAT TERMS IN BTU/LB
	elseif strcmpi(unit, 'h') == 1  
		SI = number * 2.3260; 
		
	else
		sprintf('error')
		
    end
    