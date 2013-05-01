clear all

for i = 1:10 
    eff_turb = i/50 + .76
    metrics(i, :) = PP(.6, 65, 2200, .82, .84, eff_turb, 189.7);
end

    csvwrite('Turbine Eff Study.csv',metrics)
