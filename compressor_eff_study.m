clear all

for i = 1:10 
    eff_lp = i/50 + .7
    metrics(i, :) = PP(.6, 65, 2200, eff_lp, .84, .9, 189.7);
end

    csvwrite('LP Eff Study.csv', metrics)
