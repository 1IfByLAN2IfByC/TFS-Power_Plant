function Properties = propertycalc(T, P, Y)
%input TEMP in kelvin, PRESURE in kPa
h_ref = [155.94 192.15 283.99 248.80 503.22]; 
u_ref = [93.53 156.57 221.44 194.20 412.05];

R_bar = 8.314 ; 
%sprintf('\tArgon\t C02\t Nit\t Oxygen\t Water')
M = [39.948 44.01 28.013 31.99 18.015]; %kg/kmol
R = [.208, .189, .297, .260 .462]; 
P_part = P * Y;
X = mass_fract(Y, M);

%calculate specific heats and reference values
C_p = cp(T) ./ M;
C_p_ref = cp(300) ./M;
C_v = C_p - R;
C_v_ref = (cp(300) - 8.31441) ./M;
S_o = entropy(T, P, C_p);


%calculate mixture properties
R_mix = dot(X, R);

C_v_mix = dot(X, C_v);
C_p_mix = dot(X, C_p);

H_mix = enthalpy(T);
H_mix_mol = H_mix .* M .* Y;
H_mix = dot(X, H_mix);
U_mix = H_mix - (R_mix * T);

%calculate entropy of mixing
  
S_mix = S_o .* X;    

%replace NaN in entropy with zeros
k = find(isnan(S_mix));
S_mix(k) = 0;
    
%output final misture values 
S_mix = sum(S_mix) - R_mix*log(P/101);
H_mix = sum(H_mix);
U_mix = sum(U_mix);
%sprintf('Internal Energy\t Enthalpy\t Entropy\t Specific Heat')
Properties = [H_mix, S_mix];


end






