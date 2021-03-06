function P_out = Bisect_entropy_pressure(state_in, T_out, high, low, Y, tolerance) 
    it = 0;
    % arg = X(1);
    % co2 = X(2);
    % nit = X(3);
    % oxy = X(4);
    % h20 = X(5);

  
    IN = state_in;

    f = @(P) propertycalc(T_out, P, Y) - IN(4);
    
%     f_high = propertycalc(T_out, low, Y) - IN(4)
%     f_low = propertycalc(T_out, high, Y) - IN(4)
%     

    error = abs(high - low);
        
    while (error) > tolerance 

    %if the large and mid have differnet signs, the true answer lies  
    %inbetween the two values
      mid = (high + low)/2;
      
        it = it+1;
        
        
        A = f(high);
        B = f(low);
        C = f(mid);
        
        if ( sign(A(2)) ~= sign(C(2) ) ) %root in [mid, high]
            
            low = mid;
                
        else
            
            high = mid ; 
        
          
            end
%reassign the midpoint value and recalculate error       
        error = abs(high - low); 
        end 
        
        P_out = mid;
        
    end 
    
    
        
        
        
        
        
        
        