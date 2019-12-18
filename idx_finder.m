function [R_Bulk_A, R_Bulk_B, R_Bulk_C] = idx_finder(R_Bulk_sort)
flag_init_1_5 = 0;

for idx = 1:length(R_Bulk_sort)
    
    if (R_Bulk_sort(idx, 1) > 0) && (flag_init_1_5 == 0)
        R_Bulk_A = idx;
        flag_init_1_5 = 1;
    elseif (R_Bulk_sort(idx, 1) > 0.25) && (flag_init_1_5 == 1)
        R_Bulk_B = idx;
        flag_init_1_5 = 2;
    elseif (R_Bulk_sort(idx, 1) > 1) && (flag_init_1_5 == 2)
        R_Bulk_C = idx;
        flag_init_1_5 = 3;
    end
end