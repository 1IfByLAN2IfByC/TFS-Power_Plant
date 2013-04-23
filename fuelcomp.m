function y = fuelcomp( y_fuel,y_air)  %y_fuel = [y_meth,y_eth,y_pro,y_but,y_pent,y_hex,y_co2,y_no2] y_air = [ar, co2,n2,o2,h2o]

form_meth = -74900;
form_eth = -84720;
form_pro = -103900;
form_but = -147240;
form_pent = -146800;
form_hex = -198000;
form_co2 = -393800;
form_h2o = -242000;
form_fuel = [form_meth,form_eth,form_pro,form_but,form_pent,form_hex];

M_fuel = [16.041,30.067,44.092,58.118,72.144,86.169,44.01,28.016];
M_new = [0,0,0,0,0,0,0,0];
for i =1:8
    M_new(i) = y_fuel(i)*M_fuel(i);
end

stoich_oxy = 0;
stoich_h2o = 0;
stoich_co2 = 0;


wat_norm = y_air(5)/y_air(4);
nit_norm = y_air(3)/y_air(4);
ar_norm = y_air(1)/y_air(4);


oxy = [2,3.5,5,6.5,8,9.5];
co2 = [1,2,3,4,5,6];
h2o = [2,3,4,5,6,7];

for i=1:6
   stoich_oxy= stoich_oxy + oxy(i)*y_fuel(i);
   stoich_co2 = stoich_co2 + co2(i)*y_fuel(i);
   stoich_h2o = stoich_h2o + h2o(i)*y_fuel(i);
end

a = stoich_oxy;           %coefficient of air reactant
b = stoich_co2 +y_fuel(7);    %coefficient of CO2 product
c = stoich_h2o +a*wat_norm;           %coefficient of water product
d = a*nit_norm + y_fuel(8);       %coefficient of nitrogen product
e = a*ar_norm;
tot = b+c+d+e; 

exhaust = [e/tot,b/tot,d/tot,0,c/tot]
fuelweight = sum(M_new);
reactant_form = 0;
for i = 1:6
    reactant_form = reactant_form +y_fuel(i)*form_fuel(i);
end
reactant_form = reactant_form + y_fuel(7)*form_co2;
product_form = b*form_co2 + c*form_h2o;
LHV = reactant_form - product_form;

y = zeros(5);
y(1, 1:2) = [LHV,fuelweight];
y(2,:) =  exhaust;





end

