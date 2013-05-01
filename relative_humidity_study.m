clear all

for i = 1:10
    RH_o = i/10 
    metrics(i, :) = PP(RH_o, 65, 2200, .82, .84, .9, 189.7);
    
end

    csvwrite('Relative Humidity Study.csv', metrics)
