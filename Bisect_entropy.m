function y = Bisect_entropy(T_in, P_in, P_out, high, low, Y, tolerance) 
    it = 0;
    % arg = X(1);
    % co2 = X(2);
    % nit = X(3);
    % oxy = X(4);
    % h20 = X(5);

    mid = (high + low)/2;
    IN = propertycalc(T_in, P_in, Y);

    f_high = propertycalc(high, P_out, Y) - IN(2);
    f_low = propertycalc(low, P_out, Y) - IN(2);
    
    error = high - low;
    while (error) > tolerance 
%if the large and mid have differnet signs, the true answer lies  
%inbetween the two values
        it = it+1;
        f_mid = propertycalc(mid, P_out, Y) - IN(2);
       
        if ( sign(f_high(2)) ~= sign(f_mid(2)) ) %root in [mid, high]
            low = mid;
            f_low(2) = f_mid(2);
                
        else
            high = mid ; 
            f_high(2) = f_mid(2);
          
        end
%reassign the midpoint value and recalculate error        
    mid = (high + low)/2;
    error = abs(high - low);      
    end 
    
    y = mid;  
        
    end 
    
    
        
        
        
        
        
        
        