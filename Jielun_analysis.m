% This is for Jielun's paper calculation
% Initialize memory space
clc, clear all, close all

% Prompt User Selection
fprintf('=============================================================================');
fprintf('\n');
file_dir = input('Please enter the name of the input environmental file folder: \n', 's');

% Catch all .csv files
csv_group = dir(strcat(file_dir, filesep, '*.csv'));

% Check if the directory is empty
if (isempty(csv_group))
    fprintf('\n');
    errmsg('red','No CSV file detected @ %s, please check in your file explorer!\n', data_dir);
    fprintf('\n');
    return
else
    % Not sure if the parameter is needed
    num_csv = length(csv_group);
end

% Check on specific date
fprintf('=============================================================================');
fprintf('\n');
% Use string parameter to make sure no missing 0 in front of the date
targetDate = input('Please enter the date which you would like to analyze: [MMDD] \n', 's');
dateStamp = str2double(targetDate);     % Use str2double to increase performance
fprintf('=============================================================================');
fprintf('\n');

% Create file list
speedfile = strcat(file_dir, filesep, strcat(targetDate, '_Speed.csv'));
directionfile = strcat(file_dir, filesep, strcat(targetDate, '_Direction.csv'));
temperaturefile = strcat(file_dir, filesep, strcat(targetDate, '_Temperature.csv'));
windfile = strcat(file_dir, filesep, strcat(targetDate, '_3DWind.csv'));
dustfile = strcat(file_dir, filesep, strcat(targetDate, '_Dustrak.csv'));

% Catch if see if the file exist
if isfile(speedfile)        % Check speed file at first
    isSpeedExist = 'Y';
    % fprintf('Wind speed variable exists.\n');
    errmsg('Magenta','Wind speed variable exists. \n');
else
    isSpeedExist = 'N';
    % fprintf('Wind speed variable does not exist.\n');
    errmsg('red','Wind speed variable does not exists. \n');
end

if isfile(directionfile)        % Check direction file at first
    isDirectionExist = 'Y';
    % fprintf('Wind direction variable exists.\n');
    errmsg('Magenta','Wind direction variable exists. \n');
else
    isDirectionExist = 'N';
    % fprintf('Wind direction variable does not exist.\n');
    errmsg('red','Wind direction variable does not exist. \n');
end

if isfile(temperaturefile)        % Check temperature file at first
    isTempExist = 'Y';
    % fprintf('Temperature variable exists.\n');
    errmsg('Magenta','Temperature variable exists. \n');
else
    isTempExist = 'N';
    % fprintf('Temperature variable does not exist.\n');
    errmsg('red','Temperature variable does not exist. \n');
end

if isfile(windfile)        % Check 3DWind file at first
    isWindExist = 'Y';
    % fprintf('3DWind variable exists.\n');
    errmsg('Magenta','3DWind variable exists. \n');
else
    isWindExist = 'N';
    % fprintf('3DWind variable does not exist.\n');
    errmsg('red','3DWind variable does not exist. \n');
end

if isfile(dustfile)        % Check speed file at first
    isDustExist = 'Y';
    % fprintf('Dustrak info exists.\n');
    errmsg('Magenta','Dustrak info exists. \n');
else
    isDustExist = 'N';
    % fprintf('Dustrak info does not exist.\n');
    errmsg('red','Dustrak info does not exist. \n');
end

% Start V_TKE analysis
if (isWindExist == 'Y') && (isSpeedExist == 'Y')
    
    % Start import variables
    speedTable = readtable(speedfile);
    %directionTable = readtable(directionfile);
    %temperatureTable = readtable(temperaturefile);
    windTable = readtable(windfile);
    
    % Split out time
    CDT_Time = speedTable{:,1};
    
    % Ask user for time period
    fprintf('=============================================================================');
    fprintf('\n');
    
    % Check time
    flag0 = 0;
    flag1 = 0;
    
    while flag0 < 1
        varStart = input('What would be the starting time? [x:x2:30]\n', 's');
        [varLogA, varStartIdx] = ismember(varStart, CDT_Time);
        if varLogA == 1
            flag0 = 5;
        end
    end
    
    while flag1 < 1
        varEnd = input('What would be the ending time? [x:x7:30]\n', 's');
        [varLogB, varEndIdx] = ismember(varEnd, CDT_Time);
        if varLogB == 1
            flag1 = 5;
        end
    end

    % Covariance(x,x)=variance(x)=square(std_deviation(x))
%     u_u = windTable{:, 213};
%     v_v = windTable{:, 243};
%     w_w = windTable{:, 273};
%     
%     % Calculate turbulence velocity scale
%     V_tke = [0.5.*(u_u + v_v + w_w)].^0.5;
%     
%     % Calculate TKE
%     TKE = V_tke .* V_tke;
    
    % Initiation tower
    [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 213}, windTable{varStartIdx:varEndIdx, 243}, windTable{varStartIdx:varEndIdx, 273}, speedTable{varStartIdx:varEndIdx, 4});
    [Vtke_init_3, TKE_init_3, spd_init_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 214}, windTable{varStartIdx:varEndIdx, 244}, windTable{varStartIdx:varEndIdx, 274}, speedTable{varStartIdx:varEndIdx, 5});
    [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 215}, windTable{varStartIdx:varEndIdx, 245}, windTable{varStartIdx:varEndIdx, 275}, speedTable{varStartIdx:varEndIdx, 6});
    [Vtke_init_6, TKE_init_6, spd_init_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 216}, windTable{varStartIdx:varEndIdx, 246}, windTable{varStartIdx:varEndIdx, 276}, speedTable{varStartIdx:varEndIdx, 7});
    [Vtke_init_10, TKE_init_10, spd_init_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 217}, windTable{varStartIdx:varEndIdx, 247}, windTable{varStartIdx:varEndIdx, 277}, speedTable{varStartIdx:varEndIdx, 8});
    
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
    plot(spd_init_1_5, Vtke_init_1_5)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('1.5m')
    subplot(2, 3, 2)
    plot(spd_init_3, Vtke_init_3)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('3.0m')
    subplot(2, 3, 3)
    plot(spd_init_4_5, Vtke_init_4_5)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('4.5m')
    subplot(2, 3, 4)
    plot(spd_init_6, Vtke_init_6)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('6.0m')
    subplot(2, 3, 5)
    plot(spd_init_10, Vtke_init_10)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('10.0m')
    
    
    figure
    plot(spd_init_1_5, Vtke_init_1_5, 'r-*', spd_init_3, Vtke_init_3, 'g-*', spd_init_4_5, Vtke_init_4_5, 'b-*', spd_init_6, Vtke_init_6, 'c-*', spd_init_10, Vtke_init_10, 'k-*')
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    title(strcat(targetDate, ' Initiation Tower Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
    
    
    
    % Release tower
    [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 219}, windTable{varStartIdx:varEndIdx, 249}, windTable{varStartIdx:varEndIdx, 279}, speedTable{varStartIdx:varEndIdx, 11});
    [Vtke_rel_3, TKE_rel_3, spd_rel_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 220}, windTable{varStartIdx:varEndIdx, 250}, windTable{varStartIdx:varEndIdx, 280}, speedTable{varStartIdx:varEndIdx, 12});
    [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 221}, windTable{varStartIdx:varEndIdx, 251}, windTable{varStartIdx:varEndIdx, 281}, speedTable{varStartIdx:varEndIdx, 13});
    [Vtke_rel_6, TKE_rel_6, spd_rel_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 222}, windTable{varStartIdx:varEndIdx, 252}, windTable{varStartIdx:varEndIdx, 282}, speedTable{varStartIdx:varEndIdx, 14});
    [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 223}, windTable{varStartIdx:varEndIdx, 253}, windTable{varStartIdx:varEndIdx, 283}, speedTable{varStartIdx:varEndIdx, 31});
    [Vtke_rel_10, TKE_rel_10, spd_rel_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 224}, windTable{varStartIdx:varEndIdx, 254}, windTable{varStartIdx:varEndIdx, 284}, speedTable{varStartIdx:varEndIdx, 15});
    [Vtke_rel_15, TKE_rel_15, spd_rel_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 225}, windTable{varStartIdx:varEndIdx, 255}, windTable{varStartIdx:varEndIdx, 285}, speedTable{varStartIdx:varEndIdx, 33});
    [Vtke_rel_20, TKE_rel_20, spd_rel_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 226}, windTable{varStartIdx:varEndIdx, 256}, windTable{varStartIdx:varEndIdx, 286}, speedTable{varStartIdx:varEndIdx, 35});
    
    % Plot it
    figure
    subplot(2, 4, 1)
    plot(spd_rel_1_5, Vtke_rel_1_5)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('1.5m')
    subplot(2, 4, 2)
    plot(spd_rel_3, Vtke_rel_3)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('3.0m')
    subplot(2, 4, 3)
    plot(spd_rel_4_5, Vtke_rel_4_5)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('4.5m')
    subplot(2, 4, 4)
    plot(spd_rel_6, Vtke_rel_6)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('6.0m')
    subplot(2, 4, 5)
    plot(spd_rel_8_5, Vtke_rel_8_5)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('8.5m')
    subplot(2, 4, 6)
    plot(spd_rel_10, Vtke_rel_10)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('10.0m')
    subplot(2, 4, 7)
    plot(spd_rel_15, Vtke_rel_15)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('15.0m')
    subplot(2, 4, 8)
    plot(spd_rel_20, Vtke_rel_20)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('20.0m')
    
    
    figure
    plot(spd_rel_1_5, Vtke_rel_1_5, 'r-*', spd_rel_3, Vtke_rel_3, 'g-*', spd_rel_4_5, Vtke_rel_4_5, 'b-*', spd_rel_6, Vtke_rel_6, 'c-*', spd_rel_8_5, Vtke_rel_8_5, 'r--o', spd_rel_10, Vtke_rel_10, 'k-*', spd_rel_15, Vtke_rel_15, 'g--o', spd_rel_20, Vtke_rel_20, 'b--o')
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    title(strcat(targetDate, ' Release Tower Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
    
    % Upper convergence tower
    [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 228}, windTable{varStartIdx:varEndIdx, 258}, windTable{varStartIdx:varEndIdx, 288}, speedTable{varStartIdx:varEndIdx, 18});
    [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 229}, windTable{varStartIdx:varEndIdx, 259}, windTable{varStartIdx:varEndIdx, 289}, speedTable{varStartIdx:varEndIdx, 19});
    [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 230}, windTable{varStartIdx:varEndIdx, 260}, windTable{varStartIdx:varEndIdx, 290}, speedTable{varStartIdx:varEndIdx, 20});
    [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 231}, windTable{varStartIdx:varEndIdx, 261}, windTable{varStartIdx:varEndIdx, 291}, speedTable{varStartIdx:varEndIdx, 21});
    [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 232}, windTable{varStartIdx:varEndIdx, 262}, windTable{varStartIdx:varEndIdx, 292}, speedTable{varStartIdx:varEndIdx, 22});
    
    % Plot it
    figure
    subplot(2, 3, 1)
    plot(spd_uconv_1_5, Vtke_uconv_1_5)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('1.5m')
    subplot(2, 3, 2)
    plot(spd_uconv_3, Vtke_uconv_3)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('3.0m')
    subplot(2, 3, 3)
    plot(spd_uconv_4_5, Vtke_uconv_4_5)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('4.5m')
    subplot(2, 3, 4)
    plot(spd_uconv_6, Vtke_uconv_6)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('6.0m')
    subplot(2, 3, 5)
    plot(spd_uconv_10, Vtke_uconv_10)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('10.0m')
    
    
    figure
    plot(spd_uconv_1_5, Vtke_uconv_1_5, 'r-*', spd_uconv_3, Vtke_uconv_3, 'g-*', spd_uconv_4_5, Vtke_uconv_4_5, 'b-*', spd_uconv_6, Vtke_uconv_6, 'c-*', spd_uconv_10, Vtke_uconv_10, 'k-*')
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    title(strcat(targetDate, ' Upper Convergence Tower Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
    
    
    % Lower convergence tower
    [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 234}, windTable{varStartIdx:varEndIdx, 264}, windTable{varStartIdx:varEndIdx, 294}, speedTable{varStartIdx:varEndIdx, 25});
    [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 235}, windTable{varStartIdx:varEndIdx, 265}, windTable{varStartIdx:varEndIdx, 295}, speedTable{varStartIdx:varEndIdx, 26});
    [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 236}, windTable{varStartIdx:varEndIdx, 266}, windTable{varStartIdx:varEndIdx, 296}, speedTable{varStartIdx:varEndIdx, 27});
    [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 237}, windTable{varStartIdx:varEndIdx, 267}, windTable{varStartIdx:varEndIdx, 297}, speedTable{varStartIdx:varEndIdx, 28});
    [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 238}, windTable{varStartIdx:varEndIdx, 268}, windTable{varStartIdx:varEndIdx, 298}, speedTable{varStartIdx:varEndIdx, 32});
    [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 239}, windTable{varStartIdx:varEndIdx, 269}, windTable{varStartIdx:varEndIdx, 299}, speedTable{varStartIdx:varEndIdx, 29});
    [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 240}, windTable{varStartIdx:varEndIdx, 270}, windTable{varStartIdx:varEndIdx, 300}, speedTable{varStartIdx:varEndIdx, 34});
    [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 241}, windTable{varStartIdx:varEndIdx, 271}, windTable{varStartIdx:varEndIdx, 301}, speedTable{varStartIdx:varEndIdx, 36});
    % Plot it
    figure
    subplot(4, 2, 1)
    plot(spd_lconv_1_5, Vtke_lconv_1_5)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('1.5m')
    subplot(4, 2, 2)
    plot(spd_lconv_3, Vtke_lconv_3)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('3.0m')
    subplot(4, 2, 3)
    plot(spd_lconv_4_5, Vtke_lconv_4_5)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('4.5m')
    subplot(4, 2, 4)
    plot(spd_lconv_6, Vtke_lconv_6)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('6.0m')
    subplot(4, 2, 5)
    plot(spd_lconv_8_5, Vtke_lconv_8_5)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('8.5m')
    subplot(4, 2, 6)
    plot(spd_lconv_10, Vtke_lconv_10)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('10.0m')
    subplot(4, 2, 7)
    plot(spd_lconv_15, Vtke_lconv_15)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('15.0m')
    subplot(4, 2, 8)
    plot(spd_lconv_20, Vtke_lconv_20)
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    legend('20.0m')
    %set(gcf,'PaperSize',[40 20])
    print(gcf, strcat(targetDate, '_all_lconv'), '-dpdf','-fillpage');
    
    figure
    plot(spd_lconv_1_5, Vtke_lconv_1_5, 'r-*', spd_lconv_3, Vtke_lconv_3, 'g-*', spd_lconv_4_5, Vtke_lconv_4_5, 'b-*', spd_lconv_6, Vtke_lconv_6, 'c-*', spd_lconv_8_5, Vtke_lconv_8_5, 'r--o', spd_lconv_10, Vtke_lconv_10, 'k-*', spd_lconv_15, Vtke_lconv_15, 'g--o', spd_lconv_20, Vtke_lconv_20, 'b--o')
    xlabel('Wind Speed (m/s)')
    ylabel('V tke')
    title(strcat(targetDate, ' Lower Convergence Tower Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
    %set(gcf,'PaperSize',[40 20])
    print(gcf, strcat(targetDate, '_one_lconv.png'), '-dpng','-r1000');
    
%         % Initiation tower
%     [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5] = jielun(windTable{varStartIdx:varEndIdx, 213}, windTable{varStartIdx:varEndIdx, 243}, windTable{varStartIdx:varEndIdx, 273}, speedTable{varStartIdx:varEndIdx, 4});
%     [Vtke_init_3, TKE_init_3, spd_init_3] = jielun(windTable{varStartIdx:varEndIdx, 214}, windTable{varStartIdx:varEndIdx, 244}, windTable{varStartIdx:varEndIdx, 274}, speedTable{varStartIdx:varEndIdx, 5});
%     [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5] = jielun(windTable{varStartIdx:varEndIdx, 215}, windTable{varStartIdx:varEndIdx, 245}, windTable{varStartIdx:varEndIdx, 275}, speedTable{varStartIdx:varEndIdx, 6});
%     [Vtke_init_6, TKE_init_6, spd_init_6] = jielun(windTable{varStartIdx:varEndIdx, 216}, windTable{varStartIdx:varEndIdx, 246}, windTable{varStartIdx:varEndIdx, 276}, speedTable{varStartIdx:varEndIdx, 7});
%     [Vtke_init_10, TKE_init_10, spd_init_10] = jielun(windTable{varStartIdx:varEndIdx, 217}, windTable{varStartIdx:varEndIdx, 247}, windTable{varStartIdx:varEndIdx, 277}, speedTable{varStartIdx:varEndIdx, 8});
%     
% %     [a_sorted(:, 1), a_order] = sort(speedTable{varStartIdx:varEndIdx, 4});
% %     newB(:, 1) = Vtke_init_1_5(a_order,1);
% %     
% %     A = a_sorted(:, 1);
% %     B = newB(:, 1);
% %     figure
% %     plot(A, B, 'r')
%     
%     % Plot it
%     figure
%     subplot(2, 3, 1)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_1_5)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('1.5m')
%     subplot(2, 3, 2)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_3)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('3.0m')
%     subplot(2, 3, 3)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_4_5)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('4.5m')
%     subplot(2, 3, 4)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_6)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('6.0m')
%     subplot(2, 3, 5)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_10)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('10.0m')
%     
%     
%     figure
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_init_1_5, 'r-*', CDT_Time(varStartIdx:varEndIdx), Vtke_init_3, 'g-*', CDT_Time(varStartIdx:varEndIdx), Vtke_init_4_5, 'b-*', CDT_Time(varStartIdx:varEndIdx), Vtke_init_6, 'c-*', CDT_Time(varStartIdx:varEndIdx), Vtke_init_10, 'k-*')
%     xlabel('CDT Time')
%     ylabel('V tke')
%     title(strcat(targetDate, ' Initiation Tower Data'))
%     legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
%     
%     
%     
%     % Release tower
%     [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5] = jielun(windTable{varStartIdx:varEndIdx, 219}, windTable{varStartIdx:varEndIdx, 249}, windTable{varStartIdx:varEndIdx, 279}, speedTable{varStartIdx:varEndIdx, 11});
%     [Vtke_rel_3, TKE_rel_3, spd_rel_3] = jielun(windTable{varStartIdx:varEndIdx, 220}, windTable{varStartIdx:varEndIdx, 250}, windTable{varStartIdx:varEndIdx, 280}, speedTable{varStartIdx:varEndIdx, 12});
%     [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5] = jielun(windTable{varStartIdx:varEndIdx, 221}, windTable{varStartIdx:varEndIdx, 251}, windTable{varStartIdx:varEndIdx, 281}, speedTable{varStartIdx:varEndIdx, 13});
%     [Vtke_rel_6, TKE_rel_6, spd_rel_6] = jielun(windTable{varStartIdx:varEndIdx, 222}, windTable{varStartIdx:varEndIdx, 252}, windTable{varStartIdx:varEndIdx, 282}, speedTable{varStartIdx:varEndIdx, 14});
%     [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5] = jielun(windTable{varStartIdx:varEndIdx, 223}, windTable{varStartIdx:varEndIdx, 253}, windTable{varStartIdx:varEndIdx, 283}, speedTable{varStartIdx:varEndIdx, 31});
%     [Vtke_rel_10, TKE_rel_10, spd_rel_10] = jielun(windTable{varStartIdx:varEndIdx, 224}, windTable{varStartIdx:varEndIdx, 254}, windTable{varStartIdx:varEndIdx, 284}, speedTable{varStartIdx:varEndIdx, 15});
%     [Vtke_rel_15, TKE_rel_15, spd_rel_15] = jielun(windTable{varStartIdx:varEndIdx, 225}, windTable{varStartIdx:varEndIdx, 255}, windTable{varStartIdx:varEndIdx, 285}, speedTable{varStartIdx:varEndIdx, 33});
%     [Vtke_rel_20, TKE_rel_20, spd_rel_20] = jielun(windTable{varStartIdx:varEndIdx, 226}, windTable{varStartIdx:varEndIdx, 256}, windTable{varStartIdx:varEndIdx, 286}, speedTable{varStartIdx:varEndIdx, 35});
%     
%     % Plot it
%     figure
%     subplot(2, 4, 1)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_1_5)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('1.5m')
%     subplot(2, 4, 2)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_3)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('3.0m')
%     subplot(2, 4, 3)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_4_5)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('4.5m')
%     subplot(2, 4, 4)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_6)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('6.0m')
%     subplot(2, 4, 5)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_8_5)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('8.5m')
%     subplot(2, 4, 6)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_10)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('10.0m')
%     subplot(2, 4, 7)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_15)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('15.0m')
%     subplot(2, 4, 8)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_20)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('20.0m')
%     
%     
%     figure
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_rel_1_5, 'r-*', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_3, 'g-*', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_4_5, 'b-*', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_6, 'c-*', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_8_5, 'r--o', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_10, 'k-*', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_15, 'g--o', CDT_Time(varStartIdx:varEndIdx), Vtke_rel_20, 'b--o')
%     xlabel('CDT Time')
%     ylabel('V tke')
%     title(strcat(targetDate, ' Release Tower Data'))
%     legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
%     
%     % Upper convergence tower
%     [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5] = jielun(windTable{varStartIdx:varEndIdx, 228}, windTable{varStartIdx:varEndIdx, 258}, windTable{varStartIdx:varEndIdx, 288}, speedTable{varStartIdx:varEndIdx, 18});
%     [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3] = jielun(windTable{varStartIdx:varEndIdx, 229}, windTable{varStartIdx:varEndIdx, 259}, windTable{varStartIdx:varEndIdx, 289}, speedTable{varStartIdx:varEndIdx, 19});
%     [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5] = jielun(windTable{varStartIdx:varEndIdx, 230}, windTable{varStartIdx:varEndIdx, 260}, windTable{varStartIdx:varEndIdx, 290}, speedTable{varStartIdx:varEndIdx, 20});
%     [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6] = jielun(windTable{varStartIdx:varEndIdx, 231}, windTable{varStartIdx:varEndIdx, 261}, windTable{varStartIdx:varEndIdx, 291}, speedTable{varStartIdx:varEndIdx, 21});
%     [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10] = jielun(windTable{varStartIdx:varEndIdx, 232}, windTable{varStartIdx:varEndIdx, 262}, windTable{varStartIdx:varEndIdx, 292}, speedTable{varStartIdx:varEndIdx, 22});
%     
%     % Plot it
%     figure
%     subplot(2, 3, 1)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_1_5)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('1.5m')
%     subplot(2, 3, 2)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_3)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('3.0m')
%     subplot(2, 3, 3)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_4_5)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('4.5m')
%     subplot(2, 3, 4)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_6)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('6.0m')
%     subplot(2, 3, 5)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_10)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('10.0m')
%     
%     
%     figure
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_1_5, 'r-*', CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_3, 'g-*', CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_4_5, 'b-*', CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_6, 'c-*', CDT_Time(varStartIdx:varEndIdx), Vtke_uconv_10, 'k-*')
%     xlabel('CDT Time')
%     ylabel('V tke')
%     title(strcat(targetDate, ' Upper Convergence Tower Data'))
%     legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
%     
%     
%     % Lower convergence tower
%     [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5] = jielun(windTable{varStartIdx:varEndIdx, 234}, windTable{varStartIdx:varEndIdx, 264}, windTable{varStartIdx:varEndIdx, 294}, speedTable{varStartIdx:varEndIdx, 25});
%     [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3] = jielun(windTable{varStartIdx:varEndIdx, 235}, windTable{varStartIdx:varEndIdx, 265}, windTable{varStartIdx:varEndIdx, 295}, speedTable{varStartIdx:varEndIdx, 26});
%     [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5] = jielun(windTable{varStartIdx:varEndIdx, 236}, windTable{varStartIdx:varEndIdx, 266}, windTable{varStartIdx:varEndIdx, 296}, speedTable{varStartIdx:varEndIdx, 27});
%     [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6] = jielun(windTable{varStartIdx:varEndIdx, 237}, windTable{varStartIdx:varEndIdx, 267}, windTable{varStartIdx:varEndIdx, 297}, speedTable{varStartIdx:varEndIdx, 28});
%     [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5] = jielun(windTable{varStartIdx:varEndIdx, 238}, windTable{varStartIdx:varEndIdx, 268}, windTable{varStartIdx:varEndIdx, 298}, speedTable{varStartIdx:varEndIdx, 32});
%     [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10] = jielun(windTable{varStartIdx:varEndIdx, 239}, windTable{varStartIdx:varEndIdx, 269}, windTable{varStartIdx:varEndIdx, 299}, speedTable{varStartIdx:varEndIdx, 29});
%     [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15] = jielun(windTable{varStartIdx:varEndIdx, 240}, windTable{varStartIdx:varEndIdx, 270}, windTable{varStartIdx:varEndIdx, 300}, speedTable{varStartIdx:varEndIdx, 34});
%     [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20] = jielun(windTable{varStartIdx:varEndIdx, 241}, windTable{varStartIdx:varEndIdx, 271}, windTable{varStartIdx:varEndIdx, 301}, speedTable{varStartIdx:varEndIdx, 36});
%     % Plot it
%     figure
%     subplot(2, 4, 1)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_1_5)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('1.5m')
%     subplot(2, 4, 2)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_3)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('3.0m')
%     subplot(2, 4, 3)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_4_5)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('4.5m')
%     subplot(2, 4, 4)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_6)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('6.0m')
%     subplot(2, 4, 5)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_8_5)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('8.5m')
%     subplot(2, 4, 6)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_10)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('10.0m')
%     subplot(2, 4, 7)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_15)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('15.0m')
%     subplot(2, 4, 8)
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_20)
%     xlabel('CDT Time')
%     ylabel('V tke')
%     legend('20.0m')
%     
%     
%     figure
%     plot(CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_1_5, 'r-*', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_3, 'g-*', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_4_5, 'b-*', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_6, 'c-*', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_8_5, 'r--o', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_10, 'k-*', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_15, 'g--o', CDT_Time(varStartIdx:varEndIdx), Vtke_lconv_20, 'b--o')
%     xlabel('CDT Time')
%     ylabel('V tke')
%     title(strcat(targetDate, ' Lower Convergence Tower Data'))
%     legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
    

    
end

