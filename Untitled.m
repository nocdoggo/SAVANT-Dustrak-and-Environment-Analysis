% Lconv Tower
            upper_height = 6.0;
            lower_height = 4.5;
            %             delta_theta_v = temperatureTable{:, 19} - temperatureTable{:, 18};
            delta_theta_v = windTable{:, 57} - windTable{:, 56};        % tc_high_tower - tc_low_tower
            delta_z = upper_height - lower_height;
            %             theta_v = temperatureTable{:, 18};
            theta_v_low = windTable{:, 56} + 273;           % tc_low_tower + 273
            theta_v_high = windTable{:, 57} + 273;          % tc_high_tower + 273
            delta_u = windTable{:, 12} - windTable{:, 11};    % u_high_tower - u_low_tower
            delta_v = windTable{:, 27} - windTable{:, 26};  % v_high_tower - v_low_height
            u_star_low = (((windTable{:, 191}).*(windTable{:, 191})) + ((windTable{:, 206}).*(windTable{:, 206}))).^(0.25);     % u_w__low_tower * u_w__low_tower   + v_w__low_tower * v_w__low_tower
            u_star_high = (((windTable{:, 192}).*(windTable{:, 192})) + ((windTable{:, 207}).*(windTable{:, 207}))).^(0.25);    % u_w__high_tower * u_w__high_tower + v_w__high_tower * v_w__high_tower
            w_theta_v_low = windTable{:, 176};               % w_tc__low_tower
            w_theta_v_high = windTable{:, 177};              % w_tc__high_tower
            
            % Lconvialization for R_Bulk
            R_Bulk_up = [];
            R_Bulk_down = [];
            R_Bulk_Lconv_4_5_6 = [];
            L_up_low = [];
            L_down_low = [];
            L_Lconv_4_5 = [];
            L_up_high = [];
            L_down_high = [];
            L_Lconv_6 = [];
            Term_3_Lconv_4_5 = [];
            Term_3_Lconv_6 = [];
            
            % Try to calculate the R_Bulk
            for idx = 1:length(CDT_Time)
                try
                    R_Bulk_up(idx, 1) = g .* delta_theta_v(idx, 1) * delta_z;
                    R_Bulk_down(idx, 1) = theta_v_low(idx, 1) .* ((delta_u(idx, 1).*delta_u(idx, 1)) + (delta_v(idx, 1).*delta_v(idx, 1)));
                    R_Bulk_Lconv_4_5_6(idx, 1) = R_Bulk_up(idx, 1) ./ R_Bulk_down(idx, 1);
                catch
                    errmsg('red','bulk Richardson number is not calculatable @: \n');
                    errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                end
                
                % Try to calculate the lower surface Obukhov length
                try
                    L_up_low(idx, 1) = -theta_v_low(idx, 1) .* ((u_star_low(idx, 1)).^3);
                    L_down_low(idx, 1) = k * g .* w_theta_v_low(idx, 1);
                    L_Lconv_4_5(idx, 1) = L_up_low(idx, 1) ./ L_down_low(idx, 1);
                    Term_3_Lconv_4_5(idx, 1) = lower_height ./ L_Lconv_4_5(idx, 1);
                catch
                    errmsg('red','Obukhov length for lower surface is not calculatable @: \n');
                    errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                end
                
                % Try to calculate the lower surface Obukhov length
                try
                    L_up_high(idx, 1) = -theta_v_high(idx, 1) .* ((u_star_high(idx, 1)).^3);
                    L_down_high(idx, 1) = k * g .* w_theta_v_high(idx, 1);
                    L_Lconv_6(idx, 1) = L_up_high(idx, 1) ./ L_down_high(idx, 1);
                    Term_3_Lconv_6(idx, 1) = upper_height ./ L_Lconv_6(idx, 1);
                catch
                    errmsg('red','Obukhov length for higher surface is not calculatable @: \n');
                    errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                end
            end
            
            % Form a csv dump
            tempT_uconv_bulk = table(CDT_Time, bar_fence, R_Bulk_Lconv_4_5_6, L_Lconv_4_5, L_Lconv_6, Term_3_Lconv_4_5, Term_3_Lconv_6);
            table_name_uconv_bulk = strcat(targetDate, '_calculation_Lconv_4.5-6.0.csv');
            writetable(tempT_uconv_bulk, table_name_uconv_bulk);