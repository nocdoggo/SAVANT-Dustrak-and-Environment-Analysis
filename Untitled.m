    % Initiation tower
    [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5] = jielun(windTable{varStartIdx:varEndIdx, 213}, windTable{varStartIdx:varEndIdx, 243}, windTable{varStartIdx:varEndIdx, 273}, speedTable{varStartIdx:varEndIdx, 4});
    [Vtke_init_3, TKE_init_3, spd_init_3] = jielun(windTable{varStartIdx:varEndIdx, 214}, windTable{varStartIdx:varEndIdx, 244}, windTable{varStartIdx:varEndIdx, 274}, speedTable{varStartIdx:varEndIdx, 5});
    [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5] = jielun(windTable{varStartIdx:varEndIdx, 215}, windTable{varStartIdx:varEndIdx, 245}, windTable{varStartIdx:varEndIdx, 275}, speedTable{varStartIdx:varEndIdx, 6});
    [Vtke_init_6, TKE_init_6, spd_init_6] = jielun(windTable{varStartIdx:varEndIdx, 216}, windTable{varStartIdx:varEndIdx, 246}, windTable{varStartIdx:varEndIdx, 276}, speedTable{varStartIdx:varEndIdx, 7});
    [Vtke_init_10, TKE_init_10, spd_init_10] = jielun(windTable{varStartIdx:varEndIdx, 217}, windTable{varStartIdx:varEndIdx, 247}, windTable{varStartIdx:varEndIdx, 277}, speedTable{varStartIdx:varEndIdx, 8});
    
%     [a_sorted(:, 1), a_order] = sort(speedTable{varStartIdx:varEndIdx, 4});
%     newB(:, 1) = Vtke_init_1_5(a_order,1);
%     
%     A = a_sorted(:, 1);
%     B = newB(:, 1);
%     figure
%     plot(A, B, 'r')
    
    % Plot it
    figure
    subplot(2, 3, 1)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_1_5)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('1.5m')
    subplot(2, 3, 2)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_3)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('3.0m')
    subplot(2, 3, 3)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_4_5)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('4.5m')
    subplot(2, 3, 4)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_6)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('6.0m')
    subplot(2, 3, 5)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_10)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('10.0m')
    
    
    figure
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_1_5, 'r-*', CDT_Time(varStartIdx:varEndIdx), Vtke_init_3, 'g-*', CDT_Time(varStartIdx:varEndIdx), Vtke_init_4_5, 'b-*', CDT_Time(varStartIdx:varEndIdx), Vtke_init_6, 'c-*', CDT_Time(varStartIdx:varEndIdx), Vtke_init_10, 'k-*')
    xlabel('CDT_Time')
    ylabel('V tke')
    title(strcat(targetDate, ' Initiation Tower Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
    
    
    
    % Release tower
    [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5] = jielun(windTable{varStartIdx:varEndIdx, 219}, windTable{varStartIdx:varEndIdx, 249}, windTable{varStartIdx:varEndIdx, 279}, speedTable{varStartIdx:varEndIdx, 11});
    [Vtke_rel_3, TKE_rel_3, spd_rel_3] = jielun(windTable{varStartIdx:varEndIdx, 220}, windTable{varStartIdx:varEndIdx, 250}, windTable{varStartIdx:varEndIdx, 280}, speedTable{varStartIdx:varEndIdx, 12});
    [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5] = jielun(windTable{varStartIdx:varEndIdx, 221}, windTable{varStartIdx:varEndIdx, 251}, windTable{varStartIdx:varEndIdx, 281}, speedTable{varStartIdx:varEndIdx, 13});
    [Vtke_rel_6, TKE_rel_6, spd_rel_6] = jielun(windTable{varStartIdx:varEndIdx, 222}, windTable{varStartIdx:varEndIdx, 252}, windTable{varStartIdx:varEndIdx, 282}, speedTable{varStartIdx:varEndIdx, 14});
    [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5] = jielun(windTable{varStartIdx:varEndIdx, 223}, windTable{varStartIdx:varEndIdx, 253}, windTable{varStartIdx:varEndIdx, 283}, speedTable{varStartIdx:varEndIdx, 31});
    [Vtke_rel_10, TKE_rel_10, spd_rel_10] = jielun(windTable{varStartIdx:varEndIdx, 224}, windTable{varStartIdx:varEndIdx, 254}, windTable{varStartIdx:varEndIdx, 284}, speedTable{varStartIdx:varEndIdx, 15});
    [Vtke_rel_15, TKE_rel_15, spd_rel_15] = jielun(windTable{varStartIdx:varEndIdx, 225}, windTable{varStartIdx:varEndIdx, 255}, windTable{varStartIdx:varEndIdx, 285}, speedTable{varStartIdx:varEndIdx, 33});
    [Vtke_rel_20, TKE_rel_20, spd_rel_20] = jielun(windTable{varStartIdx:varEndIdx, 226}, windTable{varStartIdx:varEndIdx, 256}, windTable{varStartIdx:varEndIdx, 286}, speedTable{varStartIdx:varEndIdx, 35});
    
    % Plot it
    figure
    subplot(2, 4, 1)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_1_5)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('1.5m')
    subplot(2, 4, 2)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_3)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('3.0m')
    subplot(2, 4, 3)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_4_5)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('4.5m')
    subplot(2, 4, 4)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_6)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('6.0m')
    subplot(2, 4, 5)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_8_5)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('8.5m')
    subplot(2, 4, 6)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_10)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('10.0m')
    subplot(2, 4, 7)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_15)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('15.0m')
    subplot(2, 4, 8)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_20)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('20.0m')
    
    
    figure
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_1_5, 'r-*', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_3, 'g-*', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_4_5, 'b-*', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_6, 'c-*', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_8_5, 'r--o', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_10, 'k-*', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_15, 'g--o', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_20, 'b--o')
    xlabel('CDT_Time')
    ylabel('V tke')
    title(strcat(targetDate, ' Release Tower Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
    
    % Upper convergence tower
    [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5] = jielun(windTable{varStartIdx:varEndIdx, 228}, windTable{varStartIdx:varEndIdx, 258}, windTable{varStartIdx:varEndIdx, 288}, speedTable{varStartIdx:varEndIdx, 18});
    [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3] = jielun(windTable{varStartIdx:varEndIdx, 229}, windTable{varStartIdx:varEndIdx, 259}, windTable{varStartIdx:varEndIdx, 289}, speedTable{varStartIdx:varEndIdx, 19});
    [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5] = jielun(windTable{varStartIdx:varEndIdx, 230}, windTable{varStartIdx:varEndIdx, 260}, windTable{varStartIdx:varEndIdx, 290}, speedTable{varStartIdx:varEndIdx, 20});
    [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6] = jielun(windTable{varStartIdx:varEndIdx, 231}, windTable{varStartIdx:varEndIdx, 261}, windTable{varStartIdx:varEndIdx, 291}, speedTable{varStartIdx:varEndIdx, 21});
    [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10] = jielun(windTable{varStartIdx:varEndIdx, 232}, windTable{varStartIdx:varEndIdx, 262}, windTable{varStartIdx:varEndIdx, 292}, speedTable{varStartIdx:varEndIdx, 22});
    
    % Plot it
    figure
    subplot(2, 3, 1)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_1_5)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('1.5m')
    subplot(2, 3, 2)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_3)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('3.0m')
    subplot(2, 3, 3)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_4_5)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('4.5m')
    subplot(2, 3, 4)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_6)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('6.0m')
    subplot(2, 3, 5)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_10)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('10.0m')
    
    
    figure
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_1_5, 'r-*', CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_3, 'g-*', CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_4_5, 'b-*', CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_6, 'c-*', CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_10, 'k-*')
    xlabel('CDT_Time')
    ylabel('V tke')
    title(strcat(targetDate, ' Upper Convergence Tower Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
    
    
    % Lower convergence tower
    [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5] = jielun(windTable{varStartIdx:varEndIdx, 234}, windTable{varStartIdx:varEndIdx, 264}, windTable{varStartIdx:varEndIdx, 294}, speedTable{varStartIdx:varEndIdx, 25});
    [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3] = jielun(windTable{varStartIdx:varEndIdx, 235}, windTable{varStartIdx:varEndIdx, 265}, windTable{varStartIdx:varEndIdx, 295}, speedTable{varStartIdx:varEndIdx, 26});
    [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5] = jielun(windTable{varStartIdx:varEndIdx, 236}, windTable{varStartIdx:varEndIdx, 266}, windTable{varStartIdx:varEndIdx, 296}, speedTable{varStartIdx:varEndIdx, 27});
    [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6] = jielun(windTable{varStartIdx:varEndIdx, 237}, windTable{varStartIdx:varEndIdx, 267}, windTable{varStartIdx:varEndIdx, 297}, speedTable{varStartIdx:varEndIdx, 28});
    [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5] = jielun(windTable{varStartIdx:varEndIdx, 238}, windTable{varStartIdx:varEndIdx, 268}, windTable{varStartIdx:varEndIdx, 298}, speedTable{varStartIdx:varEndIdx, 32});
    [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10] = jielun(windTable{varStartIdx:varEndIdx, 239}, windTable{varStartIdx:varEndIdx, 269}, windTable{varStartIdx:varEndIdx, 299}, speedTable{varStartIdx:varEndIdx, 29});
    [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15] = jielun(windTable{varStartIdx:varEndIdx, 240}, windTable{varStartIdx:varEndIdx, 270}, windTable{varStartIdx:varEndIdx, 300}, speedTable{varStartIdx:varEndIdx, 34});
    [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20] = jielun(windTable{varStartIdx:varEndIdx, 241}, windTable{varStartIdx:varEndIdx, 271}, windTable{varStartIdx:varEndIdx, 301}, speedTable{varStartIdx:varEndIdx, 36});
    % Plot it
    figure
    subplot(2, 4, 1)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_1_5)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('1.5m')
    subplot(2, 4, 2)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_3)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('3.0m')
    subplot(2, 4, 3)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_4_5)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('4.5m')
    subplot(2, 4, 4)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_6)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('6.0m')
    subplot(2, 4, 5)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_8_5)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('8.5m')
    subplot(2, 4, 6)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_10)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('10.0m')
    subplot(2, 4, 7)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_15)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('15.0m')
    subplot(2, 4, 8)
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_20)
    xlabel('CDT_Time')
    ylabel('V tke')
    legend('20.0m')
    
    
    figure
    plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_1_5, 'r-*', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_3, 'g-*', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_4_5, 'b-*', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_6, 'c-*', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_8_5, 'r--o', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_10, 'k-*', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_15, 'g--o', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_20, 'b--o')
    xlabel('CDT_Time')
    ylabel('V tke')
    title(strcat(targetDate, ' Lower Convergence Tower Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')