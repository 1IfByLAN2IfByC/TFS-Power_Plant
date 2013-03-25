function x_i = mass_fract(y_i, M_i)


   Mi = M_i .* y_i;
   M_mix = sum(Mi);
   M_mix = dot(y_i, M_i);
 
   x_i = Mi ./ M_mix; 
    
end
