function [V_tke, TKE, spd_sorted, R_Bulk, L, Term_3, Time, Date] = Jielun_TKESingle(u_u, v_v, w_w, spd, R_Bulk, L, Term_3, Time, Date)

% Calculate turbulence velocity scale
V_tke = [0.5.*(u_u + v_v + w_w)].^0.5;

% Calculate TKE
TKE = V_tke .* V_tke;

% Now sort based on the speed
[a_sorted(:, 1), a_order] = sort(spd);
newB(:, 1) = V_tke(a_order, 1);
newC(:, 1) = TKE(a_order, 1);
newD(:, 1) = R_Bulk(a_order, 1);
newE(:, 1) = L(a_order, 1);
newF(:, 1) = Term_3(a_order, 1);
newG(:, 1) = Time(a_order, 1);
newH(:, 1) = Date(a_order, 1);

% Dump
spd_sorted = a_sorted(:, 1);
V_tke = newB(:, 1);
TKE = newC(:, 1);
R_Bulk = newD(:, 1);
L = newE(:, 1);
Term_3 = newF(:, 1);

% Now add in time and date info
Time = newG(:, 1);
Date = newH(:, 1);
end