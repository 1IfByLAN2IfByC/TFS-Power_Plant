

function stoich = com_solv(Fuel_composition, Air_composition, Excess)
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
C = sum( stoich(:, 1) .* Fuel_composition') ;
H = sum( stoich(:, 2) .* Fuel_composition') ; 
O_req = sum( (H/4) + C) ; 

% find the scaling factor needed to get required oxygen
Scale = O_req / Air_composition(4);
Air_composition = Air_composition * Scale * Excess;
stoich = [Air_composition(1), (Air_composition(2) + C ), Air_composition(3)...
    (Air_composition(4) - O_req), (Air_composition(5) + H/2)]; 

% normalize the final output to get exhaust composition in volumetric fraction
stoich = stoich ./ sum(stoich)