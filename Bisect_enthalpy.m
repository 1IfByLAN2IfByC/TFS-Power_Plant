function y = Bisect(h_in, P_out, high, low, Y, tolerance) 
    it = 0;
    % arg = X(1);
    % co2 = X(2);
    % nit = X(3);
    % oxy = X(4);
    % h20 = X(5);

    mid = (high + low)/2;

    f_high = propertycalc(high, P_out, Y) - h_in;
    f_low = propertycalc(low, P_out, Y) - h_in;
    
    error = high - low;
    while (error) > tolerance 
%if the large and mid have differnet signs, the true answer lies  
%inbetween the two values

        it = it+1;
        f_mid = propertycalc(mid, P_out, Y) - h_in;
       
        if ( sign(f_high(1)) ~= sign(f_mid(1)) ) %root in [mid, high]
            low = mid;
            f_low(1) = f_mid(1);
                
        else
            high = mid ; 
            f_high(1) = f_mid(1);
          
        end
%reassign the midpoint value and recalculate error        
    mid = (high + low)/2;
    error = abs(high - low);      
    end 
    
    y = mid;
        
    end 
    
    
        
        
        
        
        
        
        