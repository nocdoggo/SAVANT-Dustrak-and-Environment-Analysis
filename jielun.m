function [V_tke, TKE, spd_unsorted] = jielun(u_u, v_v, w_w, spd)

% Calculate turbulence velocity scale
V_tke = [0.5.*(u_u + v_v + w_w)].^0.5;

% Calculate TKE
TKE = V_tke .* V_tke;

% Speed is not sorted
spd_unsorted = spd;


end