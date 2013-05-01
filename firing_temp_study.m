clear all

for i = 1:10
    T_fire = i*50 + 1950
    metrics(i, :) = PP(.6, 65, T_fire, .82, .84, .9, 189.7);
end

    csvwrite('Firing Temperature Study.csv', metrics)

