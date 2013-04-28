% Created:
%   Michael Lee
%   The University of Texas at Austin
% Last Modified:
%   3/20/13

%%

function h = enthalpy(T) 

    syms x 
    h_ref = [155.94 192.15 283.99 248.80 503.22];
    M = [39.948 44.01 28.013 31.99 18.015]; %kg/kmol
    
    Y = {
        '20.7730+ 0 + 0+ 0';
        '22.26 + x*5.981*10^-2 + -x.^2 * 3.501*10^-5 + x.^3 .* 7.469*10^-9';
        '28.9 + (-.1571*10^-2).*x + (.8081*10^-5).*x.^2 + (-2.873*10^-9).*x.^3';
        '25.48 + (1.52*10^-2).*x + (-.7155*10^-5).*x.^2 + (1.312*10^-9).*x.^3';
        '32.24 + (.1923*10^-2).*x + (1.055*10^-5).*x.^2 + (-3.595*10^-9).*x.^3';
        };
    
  %use cell array to pull functions as strings
   co = Y{2};
   nit = Y{3};
   oxy = Y{4};
   wat = Y{5}; 
   
  %create inline function for integration
   co = inline(co);
   nit = inline(nit);
   oxy = inline(oxy);
   wat = inline(wat); 
   
  %use numeric integration to solve using reference temp of 300K
   ar = .52 * (T- 300);
   co = quad(co, 273, T);
   nit = quad(nit, 273, T);
   oxy = quad(oxy, 273, T);
   wat = quad(wat, 273, T);
   
  %create vector, divide by molar mass, add tabulated reference values
   H = [ar co nit oxy wat];
   h = H ./ M ;
   h= h + h_ref;

end
    
   