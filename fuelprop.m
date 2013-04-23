
% COMBUSTOR MODEL

% This script models the combustor of the GE LM2500 gas turbine. 

% Inputs:

	% Y = Wet air composition [1x5]
	% P_a = Airressure (kpa)
	% T_a = Air inlet temperature (K)
	% X = Fuel composition 
	% P_f = Fuel pressure (kpa)
	% T_f = Fuel temperature (K)
	% T_exit = Exhuast temperature (K)

% Outputs: 
	% M_f = Fuel molecular weight (kg/kmol)
	% Exh = Exhuast composition 
	% AF_mol = Fuel Air Ratio in molar basis
	% AF_mass = Fuel Air Ratio in mass basis



function Fuel = fuelprop(Fuel_Composition, Fuel_Temp, Fuel_Pressure, T_out)

syms x

% METHANE PROPANE
% PROPANE
h_form = [(-74.9*1000), (-103.9*1000)]; 
s_form = [186.3, 270.09]; 
M = [16.043 44.094]; 

[rows, columns] = size(Fuel_Composition);
cp_fuel = { 

	'19.89 + (5.024*10^-2) .* x + (1.269*10^-5) .* x.^2 + (-11.01*10^-9) .* x.^3'
	'-4.04 + (30.48*10^-2) .* x + (-15.72*10^-5) .* x.^2 + (31.74*10^-9) .* x.^3'

	}; 


% create matrix with the amount of carbon in each hydrocarbon
% C H 
stoich = [
1, 4;
2, 6];
% 3, 8; 
% 4, 10;
% 5, 12;
% 6, 14;
% ];

% calculate the amount of carbon and hydrogen in the fuel inputs and the amount
% of oxygen required
C = sum( stoich(:, 1) .* Fuel_Composition') ;
H = sum( stoich(:, 2) .* Fuel_Composition') ; 
O_req = sum( (H/4) + C) ; 

% create inline functions for integration
meth = inline(cp_fuel{1});
prop = inline(cp_fuel{2});

% preform numeric integration. REQUIRE SYMBOLIC TOOLKIT 
Fuel = zeros(columns, 2);
Fuel(1,1) = quad(meth, 273, T_out);
Fuel (2,1) = quad(prop, 273, T_out);
% h out fuel known 

% find the entropy of the mixture
% for i = 1 : length(cp_fuel); 
% 
% 	F{i} = @(x) s_o(x, cp(i));
% 	Fuel(i, 2 ) = quadgk( F{i}, 198.15, T_out);
% 
% end

% add in formation values to total
for m = 1: columns

		Fuel(m, 1) = Fuel(m , 1) + h_form(m);
		Fuel(m, 2) = Fuel(m, 2) + s_form(m);

	end




for i = 1 : length(Fuel_Composition) 
    
    Fuel(i, :) = Fuel(i, :) .* Fuel_Composition(i);
    
    end

% output vector 




	