function [V_tke_sort, TKE_sort, spd_sort, R_Bulk_sort, L_sort, Term_3_sort] = reference_sort(V_tke, TKE, spd, R_Bulk, L, Term_3)

[a_sorted(:, 1), a_order] = sort(spd);
newB(:, 1) = V_tke(a_order, 1);
newC(:, 1) = TKE(a_order, 1);
newD(:, 1) = R_Bulk(a_order, 1);
newE(:, 1) = L(a_order, 1);
newF(:, 1) = Term_3(a_order, 1);

% Dump
spd_sort = a_sorted(:, 1);
V_tke_sort = newB(:, 1);
TKE_sort = newC(:, 1);
R_Bulk_sort = newD(:, 1);
L_sort = newE(:, 1);
Term_3_sort = newF(:, 1);
end