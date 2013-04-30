function state_out = turbine_lp(state_in, turb_eff, Y, P_out)

	% find T_out_s 
	T_out_s = Bisect_entropy(state_in, P_out, state_in(1)*3,...
	 state_in(1)/3, Y, .001);

	% find h_out_s
	state_out_s(1:2) = [T_out_s, P_out];
	state_out_s(3:4) = propertycalc(T_out_s, P_out, Y);

	% find h_out_actual from eff. definition
	h_out_actual = state_in(3) - (state_in(3) - state_out_s(3))* ...
	turb_eff;

	% find T_out_actual from bisection centered on enthalpy
	T_out_actual = Bisect_enthalpy(h_out_actual, P_out, T_out_s*3, ...
		T_out_s/3, Y, .001);

	% fix the outlet state
	state_out(3:4) = propertycalc(T_out_actual, P_out, Y);
	state_out(1:2) = [T_out_actual, P_out];
