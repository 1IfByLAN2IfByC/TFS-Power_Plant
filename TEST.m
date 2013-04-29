excess = 1;
T_in = 298; 
T_out = 273+900; 
P = 506;
tol = 1;
m_in = 27.98;

air = [0 0 .79 .21 0]; 
fuel = [.5 0 .5 0 0 0];
h_out = 0;

Prop_in = propertycalc(T_in, P, air) ;
stoich = com_solv(fuel, air, excess); 
co2_h2o = stoich(2,1:2);
AF = stoich(2,4);
LHV = fuelprop_working(fuel, 298, P, T_out, co2_h2o) / (27.98)

exhaust = stoich(1,:)

Prop_out = propertycalc(T_out, P, exhaust)
e_in = ((m_in/AF) * LHV) + (m_in*Prop_in(1));
e_out = (m_in + (m_in/AF)) * Prop_out(1)

error = abs(e_out-e_in)

while tol < error
    
    excess = excess + .2
    Prop_in = propertycalc(T_in, P, air) ;
    stoich = com_solv(fuel, air, excess); 
    co2_h2o = stoich(2,1:2);
    AF = stoich(2,4);
    LHV = fuelprop_working(fuel, 298, P, T_out, co2_h2o)

    exhaust = stoich(1,:)

    Prop_out = propertycalc(T_out, P, exhaust)
    e_in = ((m_in/AF) * LHV) + (m_in*Prop_in(1));
    e_out = (m_in + (m_in/AF)) * Prop_out(1)
    
end
    
