

function C_p = cp(T)
% function to take a constant T value in, and output a vector containing the
% specific heat values 
%input in the form
            %a, b, c, d 
  %argon     #  #  #  # 
  %co2
  %nit
  %oxygen
  %water
  M = [39.948, 44.01, 28.013, 31.99, 18.015];
  
 PROP = [20.7730, 0, 0, 0;
        22.26, (5.981*10^-2), (-3.501*10^-5), (7.469*10^-9);
        28.9, (-.1571*10^-2), (.8081*10^-5), (-2.873*10^-9);
        25.48, (1.52*10^-2), (-.7155*10^-5), (1.312*10^-9);
        32.24, (.1923*10^-2), (1.055*10^-5), (-3.595*10^-9)];
   
 Temp = [1; T; T^2; T^3];
 
 C_p = PROP*Temp;
 C_p = C_p';
 

    
    
    %output in form 
    % [ argon, co2, nit, oxy ] 
    
end
