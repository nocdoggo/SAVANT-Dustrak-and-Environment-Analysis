function [V_tke, TKE, spd_sorted] = Jielun_TKE_simple(u_u, v_v, w_w, spd)
% Calculate turbulence velocity scale
V_tke = [0.5.*(u_u + v_v + w_w)].^0.5;

% Calculate TKE
TKE = V_tke .* V_tke;

% Now sort based on the speed
[a_sorted(:, 1), a_order] = sort(spd);
newB(:, 1) = V_tke(a_order, 1);
newC(:, 1) = TKE(a_order, 1);

% Dump
spd_sorted = a_sorted(:, 1);
V_tke = newB(:, 1);
TKE = newC(:, 1);
end