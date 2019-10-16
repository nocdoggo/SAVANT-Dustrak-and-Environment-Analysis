            % Plot
            % Ob Length versus Dust
            figure
            yyaxis left
            plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
            xlabel('CDT Time [HH:MM:SS]')
            ylabel('Dust Concentration')
            
            yyaxis right
            plot(CDT_Time(varStartIdx:varEndIdx), L_low_lconv_1_5(varStartIdx:varEndIdx, 1), 'r-x', CDT_Time(varStartIdx:varEndIdx), L_high_lconv_1_5(varStartIdx:varEndIdx, 1), 'g-x', CDT_Time(varStartIdx:varEndIdx), L_lconv_8_5(varStartIdx:varEndIdx, 1), 'b-x', L_Init_6(varStartIdx:varEndIdx, 1), 'y-x', L_Init_10(varStartIdx:varEndIdx, 1), 'k-x', L_Rel_10(varStartIdx:varEndIdx, 1), 'c-x');
            ylabel('Obukhov Length')
            title(strcat(num2str(dateStamp), ' Obukhov Length vs Dustrak'))
            legend('Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6', 'lconv-1.5m', 'lconv-4.5m', 'lconv-8.5m', 'Init-6.0m', 'Init-10m', 'Rel-10m')
            
            % Term 3 versus Dust
            figure
            yyaxis left
            plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
            xlabel('CDT Time [HH:MM:SS]')
            ylabel('Dust Concentration')
            
            yyaxis right
            plot(CDT_Time(varStartIdx:varEndIdx), Term_3_lconv_1_5(varStartIdx:varEndIdx, 1), 'r-x', CDT_Time(varStartIdx:varEndIdx), Term_3_lconv_4_5(varStartIdx:varEndIdx, 1), 'g-x', CDT_Time(varStartIdx:varEndIdx), Term_3_lconv_8_5(varStartIdx:varEndIdx, 1), 'b-x', Term_3_Init_6(varStartIdx:varEndIdx, 1), 'y-x', Term_3_Init_10(varStartIdx:varEndIdx, 1), 'k-x', Term_3_Rel_10(varStartIdx:varEndIdx, 1), 'c-x');
            ylabel('Term 3 z/L')
            title(strcat(num2str(dateStamp), ' Term 3 vs Dustrak'))
            legend('Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6', 'lconv-1.5m', 'lconv-4.5m', 'lconv-8.5m', 'Init-6.0m', 'Init-10m', 'Rel-10m')
            
            % Richardson Number versus Dust
            figure
            yyaxis left
            plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
            xlabel('CDT Time [HH:MM:SS]')
            ylabel('Dust Concentration')
            
            yyaxis right
            plot(CDT_Time(varStartIdx:varEndIdx), R_Bulk_lconv_1_5_4_5(varStartIdx:varEndIdx, 1), 'r-x', CDT_Time(varStartIdx:varEndIdx), R_Bulk_lconv_4_5_8_5(varStartIdx:varEndIdx, 1), 'g-x');
            ylabel('Obukhov Length')
            title(strcat(num2str(dateStamp), ' Lower Convergence Richardson Number vs Dustrak'))
            legend('Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6', '1.5m-4.5m', '4.5m-8.5m')