                % Rel Tower
                upper_height = 20.0;
                lower_height = 15.0;
    %             delta_theta_v = temperatureTable{:, 19} - temperatureTable{:, 18};
                delta_theta_v = windTable{:, 166} - windTable{:, 165};        % tc_high_tower - tc_low_tower
                delta_z = upper_height - lower_height;
    %             theta_v = temperatureTable{:, 18};
                theta_v_low = windTable{:, 165} + 273;           % tc_low_tower + 273
                theta_v_high = windTable{:, 166} + 273;          % tc_high_tower + 273
                delta_u = windTable{:, 121} - windTable{:, 120};    % u_high_tower - u_low_tower
                delta_v = windTable{:, 136} - windTable{:, 135};  % v_high_tower - v_low_height
                u_star_low = (((windTable{:, 195}).*(windTable{:, 195})) + ((windTable{:, 210}).*(windTable{:, 210}))).^(0.25);     % u_w__low_tower * u_w__low_tower   + v_w__low_tower * v_w__low_tower
                u_star_high = (((windTable{:, 196}).*(windTable{:, 196})) + ((windTable{:, 211}).*(windTable{:, 211}))).^(0.25);    % u_w__high_tower * u_w__high_tower + v_w__high_tower * v_w__high_tower
                w_theta_v_low = windTable{:, 180};               % w_tc__low_tower
                w_theta_v_high = windTable{:, 181};              % w_tc__high_tower

                % Relialization for R_Bulk
                R_Bulk_up = [];
                R_Bulk_down = [];
                R_Bulk_Rel_15_20 = [];
                L_up_low = [];
                L_down_low = [];
                L_Rel_15 = [];
                L_up_high = [];
                L_down_high = [];
                L_Rel_20 = [];
                Term_3_Rel_15 = [];
                Term_3_Rel_20 = [];

                % Try to calculate the R_Bulk
                for idx = 1:length(CDT_Time)
                    try
                        R_Bulk_up(idx, 1) = g .* delta_theta_v(idx, 1) * delta_z;
                        R_Bulk_down(idx, 1) = theta_v_low(idx, 1) .* ((delta_u(idx, 1).*delta_u(idx, 1)) + (delta_v(idx, 1).*delta_v(idx, 1)));
                        R_Bulk_Rel_15_20(idx, 1) = R_Bulk_up(idx, 1) ./ R_Bulk_down(idx, 1);
                    catch
                        errmsg('red','bulk Richardson number is not calculatable @: \n');
                        errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                    end

                    % Try to calculate the lower surface Obukhov length
                    try
                        L_up_low(idx, 1) = -theta_v_low(idx, 1) .* ((u_star_low(idx, 1)).^3);
                        L_down_low(idx, 1) = k * g .* w_theta_v_low(idx, 1);
                        L_Rel_15(idx, 1) = L_up_low(idx, 1) ./ L_down_low(idx, 1);
                        Term_3_Rel_15(idx, 1) = lower_height ./ L_Rel_15(idx, 1);
                    catch
                        errmsg('red','Obukhov length for lower surface is not calculatable @: \n');
                        errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                    end

                    % Try to calculate the lower surface Obukhov length
                    try
                        L_up_high(idx, 1) = -theta_v_high(idx, 1) .* ((u_star_high(idx, 1)).^3);
                        L_down_high(idx, 1) = k * g .* w_theta_v_high(idx, 1);
                        L_Rel_20(idx, 1) = L_up_high(idx, 1) ./ L_down_high(idx, 1);
                        Term_3_Rel_20(idx, 1) = upper_height ./ L_Rel_20(idx, 1);
                    catch
                        errmsg('red','Obukhov length for higher surface is not calculatable @: \n');
                        errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                    end
                end

                % Form a csv dump
                tempT_uconv_bulk = table(CDT_Time, bar_fence, R_Bulk_Rel_15_20, L_Rel_15, L_Rel_20, Term_3_Rel_15, Term_3_Rel_20);
                table_name_uconv_bulk = strcat(targetDate, '_calculation_rel_15.0-20.0.csv');
                writetable(tempT_uconv_bulk, table_name_uconv_bulk);
