function P_out = Bisect_entropy_pressure(state_in, T_out, high, low, Y, tolerance) 
    it = 0;
    % arg = X(1);
    % co2 = X(2);
    % nit = X(3);
    % oxy = X(4);
    % h20 = X(5);

    mid = (high + low)/2;
    IN = state_in;

    f_high = propertycalc(T_out, low, Y) - IN(4)
    f_low = propertycalc(T_out, high, Y) - IN(4)
    
    error = abs(f_high - f_low);
    while (error) > tolerance 

%if the large and mid have differnet signs, the true answer lies  
%inbetween the two values
        it = it+1;
        mid = (high + low)/2;
        f_mid = propertycalc(T_out, mid, Y) - IN(4)
       
        if ( sign(f_high(2)) == sign(f_mid(2)) ) %root in [mid, high]
            low = mid;
            f_low(2) = f_mid(2);
                
        else
            high = mid ; 
            f_high(2) = f_mid(2);
          
            end
%reassign the midpoint value and recalculate error        
        
        error = abs(high - low);      
        end 
        
        P_out = mid;  
        
    end 
    
    
        
        
        
        
        
        
        