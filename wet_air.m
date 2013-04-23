function y_wet = wet_air(rel_humid, t_mix, p_mix) 
%accept t_mix in kelvin, convert to celsius
%accept p_mix in kpa

	t_in = t_mix-273.15;
	%given rel_humid=0.6

	y_ar = 0.01;
	y_co2 = 0.0;
	y_n2 = 0.78;
	y_o2 = 0.21;
	y_wv = 0.0;


	t_sat_vector = [5:5:370,373]; %celsius
	p_sat_vector = [.8726,1.2281,1.7056,2.3388,3.1690,4.2455,5.6267,7.3814,9.5898,12.344,15.752,19.932,25.022,31.176,38.563,47.373,57.815,70.117,84.529,101.32,120.79,143.24,169.02,198.48,232.01,270.02,312.93,361.19,415.29,475.72,542.99,617.66,700.29,791.47,891.80,1001.9,1122.5,1254.2,1397.6,1553.6,1722.9,1906.2,2104.2,2317.8,2547.9,2795.1,3060.4,3344.7,3648.8,3973.6,4320.2,4689.4,5082.3,5499.9,5943.1,6413.2,6911.1,7438.0,7995.2 ,8583.8 ,9205.1,9860.5,10550.,11280.,12050.,12850.,13700.,14590.,15530.,16520.,17560.,18660., 19810., 21030., 22055.];

	p_wv_sat= spline(t_sat_vector,p_sat_vector,t_in);
	p_wv = rel_humid*p_wv_sat;
	p_da = p_mix-p_wv;
	y_da = p_da/p_mix;
	y_wv=1-y_da;

	if y_wv > 1
	    error('CANNOT BE MORE THAN 100% WATER')
	end

	y_ar = y_da*y_ar;
	y_co2 = y_da*y_co2;
	y_n2 = y_da*y_n2;
	y_o2 = y_da*y_o2;


y_wet = [y_ar,y_co2,y_n2,y_o2,y_wv];

