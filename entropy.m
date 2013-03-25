function s = entropy(T, P, cp)
    syms x 
%     T_ref = 0 ; % Kelvin 
%     P_ref = 101.325; %KPa 
%     v_ref = (R * T_ref) / P_ref;

    s_ref = [3.9254 4.8585 6.8405 6.417 10.423];
    l = length(cp);
    
    for i =[1:l]
      
        F{i} = @(x) s_o(x, cp(i));
        s(i) = quadgk(F{i}, 300, T);
    end
    
   
    %add reference values
    s = s + s_ref; 
    
end 