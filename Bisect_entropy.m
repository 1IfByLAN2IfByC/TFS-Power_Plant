function T_out = Bisect_entropy(state_in, P_out, high, low, Y, tolerance) 
    it = 0;
    % arg = X(1);
    % co2 = X(2);
    % nit = X(3);
    % oxy = X(4);
    % h20 = X(5);

    mid = (high + low)/2;
    IN = state_in;

    f = @(T) propertycalc(T, P_out, Y) - IN(4);
    
    error = abs(high - low);
    
    while (error) > tolerance 

    %if the large and mid have differnet signs, the true answer lies  
    %inbetween the two values
        it = it+1;
        mid = (high + low)/2;
        
        f_mid = f(mid);
        f_high = f(high);
        f_low = f(low);
       
        if ( sign(f_high(2)) ~= sign(f_mid(2)) ) %root in [mid, high]
           
            low = mid;
                
        else
            
            high = mid ;
          
        end
        
    %reassign the midpoint value and recalculate error        
        error = abs(high - low);      
        end 
        
        T_out = mid;  
        
    end 
    
    
        
        
        
        
        
        
        