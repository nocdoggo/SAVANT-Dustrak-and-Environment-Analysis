% This is for Jielun's paper calculation
% Initialize memory space
clc, clear all, close all

% Prompt User Selection
%fprintf('=============================================================================');
%fprintf('\n');
%file_dir = input('Please enter the name of the input environmental file folder: \n', 's');

file_dir = 'SD';

% Color code
c = struct('rr', [0.9047, 0.1918, 0.1988], ...  %Your required color
    'bb', [0.2941, 0.5447, 0.7494], ... %Your required color
    'um', [0.0824, 0.1294, 0.4196], ... %ultra marine
    'br', [0.6510, 0.5725, 0.3412], ... %bronze
    'gl', [0.8314, 0.7020, 0.7843] );   %greyed lavender

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


% % Check on specific date
% fprintf('=============================================================================');
% fprintf('\n');
% % Use string parameter to make sure no missing 0 in front of the date
% targetDate = input('Please enter the date which you would like to analyze: [MMDD] \n', 's');
% dateStamp = str2double(targetDate);     % Use str2double to increase performance
% fprintf('=============================================================================');
% fprintf('\n');

Vtke_init_1_5_ALL= [];
TKE_init_1_5_ALL =[];
spd_init_1_5_ALL = [];

Vtke_init_3_ALL= [];
TKE_init_3_ALL =[];
spd_init_3_ALL = [];

Vtke_init_4_5_ALL= [];
TKE_init_4_5_ALL =[];
spd_init_4_5_ALL = [];

Vtke_init_6_ALL= [];
TKE_init_6_ALL =[];
spd_init_6_ALL = [];

Vtke_init_10_ALL= [];
TKE_init_10_ALL =[];
spd_init_10_ALL = [];

Vtke_uconv_1_5_ALL= [];
TKE_uconv_1_5_ALL =[];
spd_uconv_1_5_ALL = [];

Vtke_uconv_3_ALL= [];
TKE_uconv_3_ALL =[];
spd_uconv_3_ALL = [];

Vtke_uconv_4_5_ALL= [];
TKE_uconv_4_5_ALL =[];
spd_uconv_4_5_ALL = [];

Vtke_uconv_6_ALL= [];
TKE_uconv_6_ALL =[];
spd_uconv_6_ALL = [];

Vtke_uconv_10_ALL= [];
TKE_uconv_10_ALL =[];
spd_uconv_10_ALL = [];

Vtke_rel_1_5_ALL= [];
TKE_rel_1_5_ALL =[];
spd_rel_1_5_ALL = [];

Vtke_rel_3_ALL= [];
TKE_rel_3_ALL =[];
spd_rel_3_ALL = [];

Vtke_rel_4_5_ALL= [];
TKE_rel_4_5_ALL =[];
spd_rel_4_5_ALL = [];

Vtke_rel_6_ALL= [];
TKE_rel_6_ALL =[];
spd_rel_6_ALL = [];

Vtke_rel_10_ALL= [];
TKE_rel_10_ALL =[];
spd_rel_10_ALL = [];

Vtke_rel_8_5_ALL= [];
TKE_rel_8_5_ALL =[];
spd_rel_8_5_ALL = [];

Vtke_rel_15_ALL= [];
TKE_rel_15_ALL =[];
spd_rel_15_ALL = [];

Vtke_rel_20_ALL= [];
TKE_rel_20_ALL =[];
spd_rel_20_ALL = [];

Vtke_lconv_1_5_ALL= [];
TKE_lconv_1_5_ALL =[];
spd_lconv_1_5_ALL = [];

Vtke_lconv_3_ALL= [];
TKE_lconv_3_ALL =[];
spd_lconv_3_ALL = [];

Vtke_lconv_4_5_ALL= [];
TKE_lconv_4_5_ALL =[];
spd_lconv_4_5_ALL = [];

Vtke_lconv_6_ALL= [];
TKE_lconv_6_ALL =[];
spd_lconv_6_ALL = [];

Vtke_lconv_10_ALL= [];
TKE_lconv_10_ALL =[];
spd_lconv_10_ALL = [];

Vtke_lconv_8_5_ALL= [];
TKE_lconv_8_5_ALL =[];
spd_lconv_8_5_ALL = [];

Vtke_lconv_15_ALL= [];
TKE_lconv_15_ALL =[];
spd_lconv_15_ALL = [];

Vtke_lconv_20_ALL= [];
TKE_lconv_20_ALL =[];
spd_lconv_20_ALL = [];

for daterange = 0920:0930
    
    targetDate = num2str(daterange);
    dateStamp = str2double(targetDate);
    targetDate = strcat('0', targetDate);

    % Create file list
    speedfile = strcat(file_dir, filesep, strcat(targetDate, '_Speed.csv'));
%     directionfile = strcat(file_dir, filesep, strcat(targetDate, '_Direction.csv'));
    temperaturefile = strcat(file_dir, filesep, strcat(targetDate, '_Temperature.csv'));
    windfile = strcat(file_dir, filesep, strcat(targetDate, '_3DWind.csv'));
%     dustfile = strcat(file_dir, filesep, strcat(targetDate, '_Dustrak.csv'));
    
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
    
%     if isfile(directionfile)        % Check direction file at first
%         isDirectionExist = 'Y';
%         % fprintf('Wind direction variable exists.\n');
%         errmsg('Magenta','Wind direction variable exists. \n');
%     else
%         isDirectionExist = 'N';
%         % fprintf('Wind direction variable does not exist.\n');
%         errmsg('red','Wind direction variable does not exist. \n');
%     end
    
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
    

    
    
%     if isfile(dustfile)        % Check speed file at first
%         isDustExist = 'Y';
%         % fprintf('Dustrak info exists.\n');
%         errmsg('Magenta','Dustrak info exists. \n');
%     else
%         isDustExist = 'N';
%         % fprintf('Dustrak info does not exist.\n');
%         errmsg('red','Dustrak info does not exist. \n');
%     end
    
    % Start V_TKE analysis
    if (isWindExist == 'Y') && (isSpeedExist == 'Y')
        
        % Start import variables
        speedTable = readtable(speedfile);
        %directionTable = readtable(directionfile);
        %temperatureTable = readtable(temperaturefile);
        windTable = readtable(windfile);
        
        % Split out time
        CDT_Time = speedTable{:,1};
        
%         % In this part, we hard code the start and end time
%         varStart = '19:02:30';
%         [varLogA, varStartIdx] = ismember(varStart, CDT_Time);
%         
%         varEnd = '6:57:30';
%         [varLogB, varEndIdx] = ismember(varEnd, CDT_Time);

        % Figure out the size of the file
        varStartIdx = 1;
        [varEndIdx, whateveritis] = size(speedTable{:,1});
        
        %     % Ask user for time period
        %     fprintf('=============================================================================');
        %     fprintf('\n');
        %
        %     % Check time
        %     flag0 = 0;
        %     flag1 = 0;
        %
        %     while flag0 < 1
        %         varStart = input('What would be the starting time? [x:x2:30]\n', 's');
        %         [varLogA, varStartIdx] = ismember(varStart, CDT_Time);
        %         if varLogA == 1
        %             flag0 = 5;
        %         end
        %     end
        %
        %     while flag1 < 1
        %         varEnd = input('What would be the ending time? [x:x7:30]\n', 's');
        %         [varLogB, varEndIdx] = ismember(varEnd, CDT_Time);
        %         if varLogB == 1
        %             flag1 = 5;
        %         end
        %     end
        
        
        
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
        
        Vtke_init_1_5_ALL = [Vtke_init_1_5_ALL; Vtke_init_1_5];
        TKE_init_1_5_ALL = [TKE_init_1_5_ALL; TKE_init_1_5]; 
        spd_init_1_5_ALL = [spd_init_1_5_ALL; spd_init_1_5];
        
        Vtke_init_3_ALL = [Vtke_init_3_ALL; Vtke_init_3];
        TKE_init_3_ALL = [TKE_init_3_ALL; TKE_init_3]; 
        spd_init_3_ALL = [spd_init_3_ALL; spd_init_3];
        
        Vtke_init_4_5_ALL = [Vtke_init_4_5_ALL; Vtke_init_4_5];
        TKE_init_4_5_ALL = [TKE_init_4_5_ALL; TKE_init_4_5]; 
        spd_init_4_5_ALL = [spd_init_4_5_ALL; spd_init_4_5];
        
        Vtke_init_6_ALL = [Vtke_init_6_ALL; Vtke_init_6];
        TKE_init_6_ALL = [TKE_init_6_ALL; TKE_init_6]; 
        spd_init_6_ALL = [spd_init_6_ALL; spd_init_6];
        
        Vtke_init_10_ALL = [Vtke_init_10_ALL; Vtke_init_10];
        TKE_init_10_ALL = [TKE_init_10_ALL; TKE_init_10]; 
        spd_init_10_ALL = [spd_init_10_ALL; spd_init_10];
        
        
        
        %     [a_sorted(:, 1), a_order] = sort(speedTable{varStartIdx:varEndIdx, 4});
        %     newB(:, 1) = Vtke_init_1_5(a_order,1);
        %
        %     A = a_sorted(:, 1);
        %     B = newB(:, 1);
        %     figure
        %     plot(A, B, 'r')
        
%         % Plot it
%         figure
%         subplot(3, 2, 1)
%         plot(spd_init_1_5, Vtke_init_1_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('1.5m')
%         subplot(3, 2, 2)
%         plot(spd_init_3, Vtke_init_3)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('3.0m')
%         subplot(3, 2, 3)
%         plot(spd_init_4_5, Vtke_init_4_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('4.5m')
%         subplot(3, 2, 4)
%         plot(spd_init_6, Vtke_init_6)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('6.0m')
%         subplot(3, 2, 5)
%         plot(spd_init_10, Vtke_init_10)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('10.0m')
%         print(gcf, strcat(targetDate, '_all_init'), '-dpdf','-fillpage');
%         movefile(strcat(targetDate, '_all_init.pdf'), strcat('Jielun\', targetDate, '_all_init.pdf'));
%         
%         figure
%         plot(spd_init_1_5, Vtke_init_1_5, 'r-*', spd_init_3, Vtke_init_3, 'g-*', spd_init_4_5, Vtke_init_4_5, 'b-*', spd_init_6, Vtke_init_6, 'c-*', spd_init_10, Vtke_init_10, 'k-*')
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title(strcat(targetDate, ' Initiation Tower Data'))
%         %legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
%         tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m');
%         set(tempLegend, 'Location', 'best')
%         print(gcf, strcat(targetDate, '_one_init.png'), '-dpng','-r1000');
%         movefile(strcat(targetDate, '_one_init.png'), strcat('Jielun\', targetDate, '_one_init.png'));
%         
        
        % Release tower
        [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 219}, windTable{varStartIdx:varEndIdx, 249}, windTable{varStartIdx:varEndIdx, 279}, speedTable{varStartIdx:varEndIdx, 11});
        [Vtke_rel_3, TKE_rel_3, spd_rel_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 220}, windTable{varStartIdx:varEndIdx, 250}, windTable{varStartIdx:varEndIdx, 280}, speedTable{varStartIdx:varEndIdx, 12});
        [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 221}, windTable{varStartIdx:varEndIdx, 251}, windTable{varStartIdx:varEndIdx, 281}, speedTable{varStartIdx:varEndIdx, 13});
        [Vtke_rel_6, TKE_rel_6, spd_rel_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 222}, windTable{varStartIdx:varEndIdx, 252}, windTable{varStartIdx:varEndIdx, 282}, speedTable{varStartIdx:varEndIdx, 14});
        [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 223}, windTable{varStartIdx:varEndIdx, 253}, windTable{varStartIdx:varEndIdx, 283}, speedTable{varStartIdx:varEndIdx, 31});
        [Vtke_rel_10, TKE_rel_10, spd_rel_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 224}, windTable{varStartIdx:varEndIdx, 254}, windTable{varStartIdx:varEndIdx, 284}, speedTable{varStartIdx:varEndIdx, 15});
        [Vtke_rel_15, TKE_rel_15, spd_rel_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 225}, windTable{varStartIdx:varEndIdx, 255}, windTable{varStartIdx:varEndIdx, 285}, speedTable{varStartIdx:varEndIdx, 33});
        [Vtke_rel_20, TKE_rel_20, spd_rel_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 226}, windTable{varStartIdx:varEndIdx, 256}, windTable{varStartIdx:varEndIdx, 286}, speedTable{varStartIdx:varEndIdx, 35});
        
        Vtke_rel_1_5_ALL = [Vtke_rel_1_5_ALL; Vtke_rel_1_5];
        TKE_rel_1_5_ALL = [TKE_rel_1_5_ALL; TKE_rel_1_5]; 
        spd_rel_1_5_ALL = [spd_rel_1_5_ALL; spd_rel_1_5];
        
        Vtke_rel_3_ALL = [Vtke_rel_3_ALL; Vtke_rel_3];
        TKE_rel_3_ALL = [TKE_rel_3_ALL; TKE_rel_3]; 
        spd_rel_3_ALL = [spd_rel_3_ALL; spd_rel_3];
        
        Vtke_rel_4_5_ALL = [Vtke_rel_4_5_ALL; Vtke_rel_4_5];
        TKE_rel_4_5_ALL = [TKE_rel_4_5_ALL; TKE_rel_4_5]; 
        spd_rel_4_5_ALL = [spd_rel_4_5_ALL; spd_rel_4_5];
        
        Vtke_rel_6_ALL = [Vtke_rel_6_ALL; Vtke_rel_6];
        TKE_rel_6_ALL = [TKE_rel_6_ALL; TKE_rel_6]; 
        spd_rel_6_ALL = [spd_rel_6_ALL; spd_rel_6];
        
        Vtke_rel_8_5_ALL = [Vtke_rel_8_5_ALL; Vtke_rel_8_5];
        TKE_rel_8_5_ALL = [TKE_rel_8_5_ALL; TKE_rel_8_5]; 
        spd_rel_8_5_ALL = [spd_rel_8_5_ALL; spd_rel_8_5];
        
        Vtke_rel_10_ALL = [Vtke_rel_10_ALL; Vtke_rel_10];
        TKE_rel_10_ALL = [TKE_rel_10_ALL; TKE_rel_10]; 
        spd_rel_10_ALL = [spd_rel_10_ALL; spd_rel_10];
        
        Vtke_rel_15_ALL = [Vtke_rel_15_ALL; Vtke_rel_15];
        TKE_rel_15_ALL = [TKE_rel_15_ALL; TKE_rel_15]; 
        spd_rel_15_ALL = [spd_rel_15_ALL; spd_rel_15];
        
        Vtke_rel_20_ALL = [Vtke_rel_20_ALL; Vtke_rel_20];
        TKE_rel_20_ALL = [TKE_rel_20_ALL; TKE_rel_20]; 
        spd_rel_20_ALL = [spd_rel_20_ALL; spd_rel_20];
        
%         % Plot it
%         figure
%         subplot(4, 2, 1)
%         plot(spd_rel_1_5, Vtke_rel_1_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('1.5m')
%         subplot(4, 2, 2)
%         plot(spd_rel_3, Vtke_rel_3)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('3.0m')
%         subplot(4, 2, 3)
%         plot(spd_rel_4_5, Vtke_rel_4_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('4.5m')
%         subplot(4, 2, 4)
%         plot(spd_rel_6, Vtke_rel_6)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('6.0m')
%         subplot(4, 2, 5)
%         plot(spd_rel_8_5, Vtke_rel_8_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('8.5m')
%         subplot(4, 2, 6)
%         plot(spd_rel_10, Vtke_rel_10)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('10.0m')
%         subplot(4, 2, 7)
%         plot(spd_rel_15, Vtke_rel_15)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('15.0m')
%         subplot(4, 2, 8)
%         plot(spd_rel_20, Vtke_rel_20)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('20.0m')
%         print(gcf, strcat(targetDate, '_all_rel'), '-dpdf','-fillpage');
%         movefile(strcat(targetDate, '_all_rel.pdf'), strcat('Jielun\', targetDate, '_all_rel.pdf'));
%         
%         
%         figure
%         plot(spd_rel_1_5, Vtke_rel_1_5, 'r-*', spd_rel_3, Vtke_rel_3, 'g-*', spd_rel_4_5, Vtke_rel_4_5, 'b-*', spd_rel_6, Vtke_rel_6, 'c-*', spd_rel_8_5, Vtke_rel_8_5, 'k-*')
%         hold on
%         plot(spd_rel_10, Vtke_rel_10, 'Color', c.gl, 'Marker', '*');
%         hold on
%         plot(spd_rel_15, Vtke_rel_15, 'Color', c.um, 'Marker', '*');
%         hold on
%         plot(spd_rel_20, Vtke_rel_20, 'Color', c.br, 'Marker', '*');
%         hold off
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title(strcat(targetDate, ' Release Tower Data'))
%         %legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
%         tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m');
%         set(tempLegend, 'Location', 'best')
%         print(gcf, strcat(targetDate, '_one_rel.png'), '-dpng','-r1000');
%         movefile(strcat(targetDate, '_one_rel.png'), strcat('Jielun\', targetDate, '_one_rel.png'));
        
        % Upper convergence tower
        [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 228}, windTable{varStartIdx:varEndIdx, 258}, windTable{varStartIdx:varEndIdx, 288}, speedTable{varStartIdx:varEndIdx, 18});
        [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 229}, windTable{varStartIdx:varEndIdx, 259}, windTable{varStartIdx:varEndIdx, 289}, speedTable{varStartIdx:varEndIdx, 19});
        [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 230}, windTable{varStartIdx:varEndIdx, 260}, windTable{varStartIdx:varEndIdx, 290}, speedTable{varStartIdx:varEndIdx, 20});
        [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 231}, windTable{varStartIdx:varEndIdx, 261}, windTable{varStartIdx:varEndIdx, 291}, speedTable{varStartIdx:varEndIdx, 21});
        [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 232}, windTable{varStartIdx:varEndIdx, 262}, windTable{varStartIdx:varEndIdx, 292}, speedTable{varStartIdx:varEndIdx, 22});
        
        
        Vtke_uconv_1_5_ALL = [Vtke_uconv_1_5_ALL; Vtke_uconv_1_5];
        TKE_uconv_1_5_ALL = [TKE_uconv_1_5_ALL; TKE_uconv_1_5]; 
        spd_uconv_1_5_ALL = [spd_uconv_1_5_ALL; spd_uconv_1_5];
        
        Vtke_uconv_3_ALL = [Vtke_uconv_3_ALL; Vtke_uconv_3];
        TKE_uconv_3_ALL = [TKE_uconv_3_ALL; TKE_uconv_3]; 
        spd_uconv_3_ALL = [spd_uconv_3_ALL; spd_uconv_3];
        
        Vtke_uconv_4_5_ALL = [Vtke_uconv_4_5_ALL; Vtke_uconv_4_5];
        TKE_uconv_4_5_ALL = [TKE_uconv_4_5_ALL; TKE_uconv_4_5]; 
        spd_uconv_4_5_ALL = [spd_uconv_4_5_ALL; spd_uconv_4_5];
        
        Vtke_uconv_6_ALL = [Vtke_uconv_6_ALL; Vtke_uconv_6];
        TKE_uconv_6_ALL = [TKE_uconv_6_ALL; TKE_uconv_6]; 
        spd_uconv_6_ALL = [spd_uconv_6_ALL; spd_uconv_6];
        
        Vtke_uconv_10_ALL = [Vtke_uconv_10_ALL; Vtke_uconv_10];
        TKE_uconv_10_ALL = [TKE_uconv_10_ALL; TKE_uconv_10]; 
        spd_uconv_10_ALL = [spd_uconv_10_ALL; spd_uconv_10];
        
%         % Plot it
%         figure
%         subplot(3, 2, 1)
%         plot(spd_uconv_1_5, Vtke_uconv_1_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('1.5m')
%         subplot(3, 2, 2)
%         plot(spd_uconv_3, Vtke_uconv_3)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('3.0m')
%         subplot(3, 2, 3)
%         plot(spd_uconv_4_5, Vtke_uconv_4_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('4.5m')
%         subplot(3, 2, 4)
%         plot(spd_uconv_6, Vtke_uconv_6)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('6.0m')
%         subplot(3, 2, 5)
%         plot(spd_uconv_10, Vtke_uconv_10)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('10.0m')
%         print(gcf, strcat(targetDate, '_all_uconv'), '-dpdf','-fillpage');
%         movefile(strcat(targetDate, '_all_uconv.pdf'), strcat('Jielun\', targetDate, '_all_uconv.pdf'));
%         
%         
%         figure
%         plot(spd_uconv_1_5, Vtke_uconv_1_5, 'r-*', spd_uconv_3, Vtke_uconv_3, 'g-*', spd_uconv_4_5, Vtke_uconv_4_5, 'b-*', spd_uconv_6, Vtke_uconv_6, 'c-*', spd_uconv_10, Vtke_uconv_10, 'k-*')
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title(strcat(targetDate, ' Upper Convergence Tower Data'))
%         %legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
%         tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m');
%         set(tempLegend, 'Location', 'best')
%         print(gcf, strcat(targetDate, '_one_uconv.png'), '-dpng','-r1000');
%         movefile(strcat(targetDate, '_one_uconv.png'), strcat('Jielun\', targetDate, '_one_uconv.png'));
        
        % Lower convergence tower
        [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 234}, windTable{varStartIdx:varEndIdx, 264}, windTable{varStartIdx:varEndIdx, 294}, speedTable{varStartIdx:varEndIdx, 25});
        [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 235}, windTable{varStartIdx:varEndIdx, 265}, windTable{varStartIdx:varEndIdx, 295}, speedTable{varStartIdx:varEndIdx, 26});
        [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 236}, windTable{varStartIdx:varEndIdx, 266}, windTable{varStartIdx:varEndIdx, 296}, speedTable{varStartIdx:varEndIdx, 27});
        [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 237}, windTable{varStartIdx:varEndIdx, 267}, windTable{varStartIdx:varEndIdx, 297}, speedTable{varStartIdx:varEndIdx, 28});
        [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 238}, windTable{varStartIdx:varEndIdx, 268}, windTable{varStartIdx:varEndIdx, 298}, speedTable{varStartIdx:varEndIdx, 32});
        [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 239}, windTable{varStartIdx:varEndIdx, 269}, windTable{varStartIdx:varEndIdx, 299}, speedTable{varStartIdx:varEndIdx, 29});
        [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 240}, windTable{varStartIdx:varEndIdx, 270}, windTable{varStartIdx:varEndIdx, 300}, speedTable{varStartIdx:varEndIdx, 34});
        [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 241}, windTable{varStartIdx:varEndIdx, 271}, windTable{varStartIdx:varEndIdx, 301}, speedTable{varStartIdx:varEndIdx, 36});
        
        Vtke_lconv_1_5_ALL = [Vtke_lconv_1_5_ALL; Vtke_lconv_1_5];
        TKE_lconv_1_5_ALL = [TKE_lconv_1_5_ALL; TKE_lconv_1_5]; 
        spd_lconv_1_5_ALL = [spd_lconv_1_5_ALL; spd_lconv_1_5];
        
        Vtke_lconv_3_ALL = [Vtke_lconv_3_ALL; Vtke_lconv_3];
        TKE_lconv_3_ALL = [TKE_lconv_3_ALL; TKE_lconv_3]; 
        spd_lconv_3_ALL = [spd_lconv_3_ALL; spd_lconv_3];
        
        Vtke_lconv_4_5_ALL = [Vtke_lconv_4_5_ALL; Vtke_lconv_4_5];
        TKE_lconv_4_5_ALL = [TKE_lconv_4_5_ALL; TKE_lconv_4_5]; 
        spd_lconv_4_5_ALL = [spd_lconv_4_5_ALL; spd_lconv_4_5];
        
        Vtke_lconv_6_ALL = [Vtke_lconv_6_ALL; Vtke_lconv_6];
        TKE_lconv_6_ALL = [TKE_lconv_6_ALL; TKE_lconv_6]; 
        spd_lconv_6_ALL = [spd_lconv_6_ALL; spd_lconv_6];
        
        Vtke_lconv_8_5_ALL = [Vtke_lconv_8_5_ALL; Vtke_lconv_8_5];
        TKE_lconv_8_5_ALL = [TKE_lconv_8_5_ALL; TKE_lconv_8_5]; 
        spd_lconv_8_5_ALL = [spd_lconv_8_5_ALL; spd_lconv_8_5];
        
        Vtke_lconv_10_ALL = [Vtke_lconv_10_ALL; Vtke_lconv_10];
        TKE_lconv_10_ALL = [TKE_lconv_10_ALL; TKE_lconv_10]; 
        spd_lconv_10_ALL = [spd_lconv_10_ALL; spd_lconv_10];
        
        Vtke_lconv_15_ALL = [Vtke_lconv_15_ALL; Vtke_lconv_15];
        TKE_lconv_15_ALL = [TKE_lconv_15_ALL; TKE_lconv_15]; 
        spd_lconv_15_ALL = [spd_lconv_15_ALL; spd_lconv_15];
        
        Vtke_lconv_20_ALL = [Vtke_lconv_20_ALL; Vtke_lconv_20];
        TKE_lconv_20_ALL = [TKE_lconv_20_ALL; TKE_lconv_20]; 
        spd_lconv_20_ALL = [spd_lconv_20_ALL; spd_lconv_20];
        
%         % Plot it
%         figure
%         subplot(4, 2, 1)
%         plot(spd_lconv_1_5, Vtke_lconv_1_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('1.5m')
%         subplot(4, 2, 2)
%         plot(spd_lconv_3, Vtke_lconv_3)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('3.0m')
%         subplot(4, 2, 3)
%         plot(spd_lconv_4_5, Vtke_lconv_4_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('4.5m')
%         subplot(4, 2, 4)
%         plot(spd_lconv_6, Vtke_lconv_6)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('6.0m')
%         subplot(4, 2, 5)
%         plot(spd_lconv_8_5, Vtke_lconv_8_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('8.5m')
%         subplot(4, 2, 6)
%         plot(spd_lconv_10, Vtke_lconv_10)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('10.0m')
%         subplot(4, 2, 7)
%         plot(spd_lconv_15, Vtke_lconv_15)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('15.0m')
%         subplot(4, 2, 8)
%         plot(spd_lconv_20, Vtke_lconv_20)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('20.0m')
%         %set(gcf,'PaperSize',[40 20])
%         print(gcf, strcat(targetDate, '_all_lconv'), '-dpdf','-fillpage');
%         movefile(strcat(targetDate, '_all_lconv.pdf'), strcat('Jielun\', targetDate, '_all_lconv.pdf'));
%         
%         figure
%         plot(spd_lconv_1_5, Vtke_lconv_1_5, 'r-*', spd_lconv_3, Vtke_lconv_3, 'g-*', spd_lconv_4_5, Vtke_lconv_4_5, 'b-*', spd_lconv_6, Vtke_lconv_6, 'c-*', spd_lconv_8_5, Vtke_lconv_8_5, 'k-*');
%         hold on
%         plot(spd_lconv_10, Vtke_lconv_10, 'Color', c.gl, 'Marker', '*');
%         hold on
%         plot(spd_lconv_15, Vtke_lconv_15, 'Color', c.um, 'Marker', '*');
%         hold on
%         plot(spd_lconv_20, Vtke_lconv_20, 'Color', c.br, 'Marker', '*');
%         hold off
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title(strcat(targetDate, ' Lower Convergence Tower Data'))
%         %legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
%         tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m');
%         set(tempLegend, 'Location', 'best')
%         %set(gcf,'PaperSize',[40 20])
%         print(gcf, strcat(targetDate, '_one_lconv.png'), '-dpng','-r1000');
%         movefile(strcat(targetDate, '_one_lconv.png'), strcat('Jielun\', targetDate, '_one_lconv.png'));
        
        % To close all the windows
        close all
        
        bar_fence = repmat('|',length(CDT_Time(varStartIdx:varEndIdx)),1);
        
        % Now we can form table
%         % Group table
%         tempT_tke = table(CDT_Time(varStartIdx:varEndIdx), bar_fence, spd_init_1_5, Vtke_init_1_5, spd_init_3, Vtke_init_3, spd_init_4_5, Vtke_init_4_5, spd_init_6, Vtke_init_6, spd_init_10, Vtke_init_10, ...
%             bar_fence, spd_rel_1_5, Vtke_rel_1_5, spd_rel_3, Vtke_rel_3, spd_rel_4_5, Vtke_rel_4_5, spd_rel_6, Vtke_rel_6, spd_rel_8_5, Vtke_rel_8_5, spd_rel_10, Vtke_rel_10, spd_rel_15, Vtke_rel_15, spd_rel_20, Vtke_rel_20,...
%             bar_fence, spd_uconv_1_5, Vtke_uconv_1_5, spd_uconv_3, Vtke_uconv_3, spd_uconv_4_5, Vtke_uconv_4_5, spd_uconv_6, Vtke_uconv_6, spd_uconv_10, Vtke_uconv_10,...
%             spd_lconv_1_5, Vtke_lconv_1_5, spd_lconv_3, Vtke_lconv_3, spd_lconv_4_5, Vtke_lconv_4_5, spd_lconv_6, Vtke_lconv_6, spd_lconv_8_5, Vtke_lconv_8_5, spd_lconv_10, Vtke_lconv_10, spd_lconv_15, Vtke_lconv_15, spd_lconv_20, Vtke_lconv_20);
%         
%         % Format table name
%         table_name_tke = strcat(targetDate, '_Speed_vs_Vtke.csv');
%         
%         % Output table
%         writetable(tempT_tke, table_name_tke);
%         movefile(strcat(targetDate, '_Speed_vs_Vtke.csv'), strcat('Jielun\', targetDate, '_Speed_vs_Vtke.csv'));
        
        

    end

    
end

for daterange = 1001:1123
    
    targetDate = num2str(daterange);
    dateStamp = str2double(targetDate);
    %targetDate = strcat('0', targetDate);

    % Create file list
    speedfile = strcat(file_dir, filesep, strcat(targetDate, '_Speed.csv'));
%     directionfile = strcat(file_dir, filesep, strcat(targetDate, '_Direction.csv'));
    temperaturefile = strcat(file_dir, filesep, strcat(targetDate, '_Temperature.csv'));
    windfile = strcat(file_dir, filesep, strcat(targetDate, '_3DWind.csv'));
%     dustfile = strcat(file_dir, filesep, strcat(targetDate, '_Dustrak.csv'));
    
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
    
%     if isfile(directionfile)        % Check direction file at first
%         isDirectionExist = 'Y';
%         % fprintf('Wind direction variable exists.\n');
%         errmsg('Magenta','Wind direction variable exists. \n');
%     else
%         isDirectionExist = 'N';
%         % fprintf('Wind direction variable does not exist.\n');
%         errmsg('red','Wind direction variable does not exist. \n');
%     end
    
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
    

    
    
%     if isfile(dustfile)        % Check speed file at first
%         isDustExist = 'Y';
%         % fprintf('Dustrak info exists.\n');
%         errmsg('Magenta','Dustrak info exists. \n');
%     else
%         isDustExist = 'N';
%         % fprintf('Dustrak info does not exist.\n');
%         errmsg('red','Dustrak info does not exist. \n');
%     end
    
    % Start V_TKE analysis
    if (isWindExist == 'Y') && (isSpeedExist == 'Y')
        
        % Start import variables
        speedTable = readtable(speedfile);
        %directionTable = readtable(directionfile);
        %temperatureTable = readtable(temperaturefile);
        windTable = readtable(windfile);
        
        % Split out time
        CDT_Time = speedTable{:,1};
        
%         % In this part, we hard code the start and end time
%         varStart = '19:02:30';
%         [varLogA, varStartIdx] = ismember(varStart, CDT_Time);
%         
%         varEnd = '6:57:30';
%         [varLogB, varEndIdx] = ismember(varEnd, CDT_Time);

        % Figure out the size of the file
        varStartIdx = 1;
        [varEndIdx, whateveritis] = size(speedTable{:,1});
        
        %     % Ask user for time period
        %     fprintf('=============================================================================');
        %     fprintf('\n');
        %
        %     % Check time
        %     flag0 = 0;
        %     flag1 = 0;
        %
        %     while flag0 < 1
        %         varStart = input('What would be the starting time? [x:x2:30]\n', 's');
        %         [varLogA, varStartIdx] = ismember(varStart, CDT_Time);
        %         if varLogA == 1
        %             flag0 = 5;
        %         end
        %     end
        %
        %     while flag1 < 1
        %         varEnd = input('What would be the ending time? [x:x7:30]\n', 's');
        %         [varLogB, varEndIdx] = ismember(varEnd, CDT_Time);
        %         if varLogB == 1
        %             flag1 = 5;
        %         end
        %     end
        
        
        
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
        
        Vtke_init_1_5_ALL = [Vtke_init_1_5_ALL; Vtke_init_1_5];
        TKE_init_1_5_ALL = [TKE_init_1_5_ALL; TKE_init_1_5]; 
        spd_init_1_5_ALL = [spd_init_1_5_ALL; spd_init_1_5];
        
        Vtke_init_3_ALL = [Vtke_init_3_ALL; Vtke_init_3];
        TKE_init_3_ALL = [TKE_init_3_ALL; TKE_init_3]; 
        spd_init_3_ALL = [spd_init_3_ALL; spd_init_3];
        
        Vtke_init_4_5_ALL = [Vtke_init_4_5_ALL; Vtke_init_4_5];
        TKE_init_4_5_ALL = [TKE_init_4_5_ALL; TKE_init_4_5]; 
        spd_init_4_5_ALL = [spd_init_4_5_ALL; spd_init_4_5];
        
        Vtke_init_6_ALL = [Vtke_init_6_ALL; Vtke_init_6];
        TKE_init_6_ALL = [TKE_init_6_ALL; TKE_init_6]; 
        spd_init_6_ALL = [spd_init_6_ALL; spd_init_6];
        
        Vtke_init_10_ALL = [Vtke_init_10_ALL; Vtke_init_10];
        TKE_init_10_ALL = [TKE_init_10_ALL; TKE_init_10]; 
        spd_init_10_ALL = [spd_init_10_ALL; spd_init_10];
        
        
        
        %     [a_sorted(:, 1), a_order] = sort(speedTable{varStartIdx:varEndIdx, 4});
        %     newB(:, 1) = Vtke_init_1_5(a_order,1);
        %
        %     A = a_sorted(:, 1);
        %     B = newB(:, 1);
        %     figure
        %     plot(A, B, 'r')
        
%         % Plot it
%         figure
%         subplot(3, 2, 1)
%         plot(spd_init_1_5, Vtke_init_1_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('1.5m')
%         subplot(3, 2, 2)
%         plot(spd_init_3, Vtke_init_3)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('3.0m')
%         subplot(3, 2, 3)
%         plot(spd_init_4_5, Vtke_init_4_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('4.5m')
%         subplot(3, 2, 4)
%         plot(spd_init_6, Vtke_init_6)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('6.0m')
%         subplot(3, 2, 5)
%         plot(spd_init_10, Vtke_init_10)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('10.0m')
%         print(gcf, strcat(targetDate, '_all_init'), '-dpdf','-fillpage');
%         movefile(strcat(targetDate, '_all_init.pdf'), strcat('Jielun\', targetDate, '_all_init.pdf'));
%         
%         figure
%         plot(spd_init_1_5, Vtke_init_1_5, 'r-*', spd_init_3, Vtke_init_3, 'g-*', spd_init_4_5, Vtke_init_4_5, 'b-*', spd_init_6, Vtke_init_6, 'c-*', spd_init_10, Vtke_init_10, 'k-*')
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title(strcat(targetDate, ' Initiation Tower Data'))
%         %legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
%         tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m');
%         set(tempLegend, 'Location', 'best')
%         print(gcf, strcat(targetDate, '_one_init.png'), '-dpng','-r1000');
%         movefile(strcat(targetDate, '_one_init.png'), strcat('Jielun\', targetDate, '_one_init.png'));
%         
        
        % Release tower
        [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 219}, windTable{varStartIdx:varEndIdx, 249}, windTable{varStartIdx:varEndIdx, 279}, speedTable{varStartIdx:varEndIdx, 11});
        [Vtke_rel_3, TKE_rel_3, spd_rel_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 220}, windTable{varStartIdx:varEndIdx, 250}, windTable{varStartIdx:varEndIdx, 280}, speedTable{varStartIdx:varEndIdx, 12});
        [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 221}, windTable{varStartIdx:varEndIdx, 251}, windTable{varStartIdx:varEndIdx, 281}, speedTable{varStartIdx:varEndIdx, 13});
        [Vtke_rel_6, TKE_rel_6, spd_rel_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 222}, windTable{varStartIdx:varEndIdx, 252}, windTable{varStartIdx:varEndIdx, 282}, speedTable{varStartIdx:varEndIdx, 14});
        [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 223}, windTable{varStartIdx:varEndIdx, 253}, windTable{varStartIdx:varEndIdx, 283}, speedTable{varStartIdx:varEndIdx, 31});
        [Vtke_rel_10, TKE_rel_10, spd_rel_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 224}, windTable{varStartIdx:varEndIdx, 254}, windTable{varStartIdx:varEndIdx, 284}, speedTable{varStartIdx:varEndIdx, 15});
        [Vtke_rel_15, TKE_rel_15, spd_rel_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 225}, windTable{varStartIdx:varEndIdx, 255}, windTable{varStartIdx:varEndIdx, 285}, speedTable{varStartIdx:varEndIdx, 33});
        [Vtke_rel_20, TKE_rel_20, spd_rel_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 226}, windTable{varStartIdx:varEndIdx, 256}, windTable{varStartIdx:varEndIdx, 286}, speedTable{varStartIdx:varEndIdx, 35});
        
        Vtke_rel_1_5_ALL = [Vtke_rel_1_5_ALL; Vtke_rel_1_5];
        TKE_rel_1_5_ALL = [TKE_rel_1_5_ALL; TKE_rel_1_5]; 
        spd_rel_1_5_ALL = [spd_rel_1_5_ALL; spd_rel_1_5];
        
        Vtke_rel_3_ALL = [Vtke_rel_3_ALL; Vtke_rel_3];
        TKE_rel_3_ALL = [TKE_rel_3_ALL; TKE_rel_3]; 
        spd_rel_3_ALL = [spd_rel_3_ALL; spd_rel_3];
        
        Vtke_rel_4_5_ALL = [Vtke_rel_4_5_ALL; Vtke_rel_4_5];
        TKE_rel_4_5_ALL = [TKE_rel_4_5_ALL; TKE_rel_4_5]; 
        spd_rel_4_5_ALL = [spd_rel_4_5_ALL; spd_rel_4_5];
        
        Vtke_rel_6_ALL = [Vtke_rel_6_ALL; Vtke_rel_6];
        TKE_rel_6_ALL = [TKE_rel_6_ALL; TKE_rel_6]; 
        spd_rel_6_ALL = [spd_rel_6_ALL; spd_rel_6];
        
        Vtke_rel_8_5_ALL = [Vtke_rel_8_5_ALL; Vtke_rel_8_5];
        TKE_rel_8_5_ALL = [TKE_rel_8_5_ALL; TKE_rel_8_5]; 
        spd_rel_8_5_ALL = [spd_rel_8_5_ALL; spd_rel_8_5];
        
        Vtke_rel_10_ALL = [Vtke_rel_10_ALL; Vtke_rel_10];
        TKE_rel_10_ALL = [TKE_rel_10_ALL; TKE_rel_10]; 
        spd_rel_10_ALL = [spd_rel_10_ALL; spd_rel_10];
        
        Vtke_rel_15_ALL = [Vtke_rel_15_ALL; Vtke_rel_15];
        TKE_rel_15_ALL = [TKE_rel_15_ALL; TKE_rel_15]; 
        spd_rel_15_ALL = [spd_rel_15_ALL; spd_rel_15];
        
        Vtke_rel_20_ALL = [Vtke_rel_20_ALL; Vtke_rel_20];
        TKE_rel_20_ALL = [TKE_rel_20_ALL; TKE_rel_20]; 
        spd_rel_20_ALL = [spd_rel_20_ALL; spd_rel_20];
        
%         % Plot it
%         figure
%         subplot(4, 2, 1)
%         plot(spd_rel_1_5, Vtke_rel_1_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('1.5m')
%         subplot(4, 2, 2)
%         plot(spd_rel_3, Vtke_rel_3)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('3.0m')
%         subplot(4, 2, 3)
%         plot(spd_rel_4_5, Vtke_rel_4_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('4.5m')
%         subplot(4, 2, 4)
%         plot(spd_rel_6, Vtke_rel_6)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('6.0m')
%         subplot(4, 2, 5)
%         plot(spd_rel_8_5, Vtke_rel_8_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('8.5m')
%         subplot(4, 2, 6)
%         plot(spd_rel_10, Vtke_rel_10)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('10.0m')
%         subplot(4, 2, 7)
%         plot(spd_rel_15, Vtke_rel_15)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('15.0m')
%         subplot(4, 2, 8)
%         plot(spd_rel_20, Vtke_rel_20)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('20.0m')
%         print(gcf, strcat(targetDate, '_all_rel'), '-dpdf','-fillpage');
%         movefile(strcat(targetDate, '_all_rel.pdf'), strcat('Jielun\', targetDate, '_all_rel.pdf'));
%         
%         
%         figure
%         plot(spd_rel_1_5, Vtke_rel_1_5, 'r-*', spd_rel_3, Vtke_rel_3, 'g-*', spd_rel_4_5, Vtke_rel_4_5, 'b-*', spd_rel_6, Vtke_rel_6, 'c-*', spd_rel_8_5, Vtke_rel_8_5, 'k-*')
%         hold on
%         plot(spd_rel_10, Vtke_rel_10, 'Color', c.gl, 'Marker', '*');
%         hold on
%         plot(spd_rel_15, Vtke_rel_15, 'Color', c.um, 'Marker', '*');
%         hold on
%         plot(spd_rel_20, Vtke_rel_20, 'Color', c.br, 'Marker', '*');
%         hold off
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title(strcat(targetDate, ' Release Tower Data'))
%         %legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
%         tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m');
%         set(tempLegend, 'Location', 'best')
%         print(gcf, strcat(targetDate, '_one_rel.png'), '-dpng','-r1000');
%         movefile(strcat(targetDate, '_one_rel.png'), strcat('Jielun\', targetDate, '_one_rel.png'));
        
        % Upper convergence tower
        [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 228}, windTable{varStartIdx:varEndIdx, 258}, windTable{varStartIdx:varEndIdx, 288}, speedTable{varStartIdx:varEndIdx, 18});
        [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 229}, windTable{varStartIdx:varEndIdx, 259}, windTable{varStartIdx:varEndIdx, 289}, speedTable{varStartIdx:varEndIdx, 19});
        [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 230}, windTable{varStartIdx:varEndIdx, 260}, windTable{varStartIdx:varEndIdx, 290}, speedTable{varStartIdx:varEndIdx, 20});
        [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 231}, windTable{varStartIdx:varEndIdx, 261}, windTable{varStartIdx:varEndIdx, 291}, speedTable{varStartIdx:varEndIdx, 21});
        [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 232}, windTable{varStartIdx:varEndIdx, 262}, windTable{varStartIdx:varEndIdx, 292}, speedTable{varStartIdx:varEndIdx, 22});
        
        
        Vtke_uconv_1_5_ALL = [Vtke_uconv_1_5_ALL; Vtke_uconv_1_5];
        TKE_uconv_1_5_ALL = [TKE_uconv_1_5_ALL; TKE_uconv_1_5]; 
        spd_uconv_1_5_ALL = [spd_uconv_1_5_ALL; spd_uconv_1_5];
        
        Vtke_uconv_3_ALL = [Vtke_uconv_3_ALL; Vtke_uconv_3];
        TKE_uconv_3_ALL = [TKE_uconv_3_ALL; TKE_uconv_3]; 
        spd_uconv_3_ALL = [spd_uconv_3_ALL; spd_uconv_3];
        
        Vtke_uconv_4_5_ALL = [Vtke_uconv_4_5_ALL; Vtke_uconv_4_5];
        TKE_uconv_4_5_ALL = [TKE_uconv_4_5_ALL; TKE_uconv_4_5]; 
        spd_uconv_4_5_ALL = [spd_uconv_4_5_ALL; spd_uconv_4_5];
        
        Vtke_uconv_6_ALL = [Vtke_uconv_6_ALL; Vtke_uconv_6];
        TKE_uconv_6_ALL = [TKE_uconv_6_ALL; TKE_uconv_6]; 
        spd_uconv_6_ALL = [spd_uconv_6_ALL; spd_uconv_6];
        
        Vtke_uconv_10_ALL = [Vtke_uconv_10_ALL; Vtke_uconv_10];
        TKE_uconv_10_ALL = [TKE_uconv_10_ALL; TKE_uconv_10]; 
        spd_uconv_10_ALL = [spd_uconv_10_ALL; spd_uconv_10];
        
%         % Plot it
%         figure
%         subplot(3, 2, 1)
%         plot(spd_uconv_1_5, Vtke_uconv_1_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('1.5m')
%         subplot(3, 2, 2)
%         plot(spd_uconv_3, Vtke_uconv_3)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('3.0m')
%         subplot(3, 2, 3)
%         plot(spd_uconv_4_5, Vtke_uconv_4_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('4.5m')
%         subplot(3, 2, 4)
%         plot(spd_uconv_6, Vtke_uconv_6)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('6.0m')
%         subplot(3, 2, 5)
%         plot(spd_uconv_10, Vtke_uconv_10)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('10.0m')
%         print(gcf, strcat(targetDate, '_all_uconv'), '-dpdf','-fillpage');
%         movefile(strcat(targetDate, '_all_uconv.pdf'), strcat('Jielun\', targetDate, '_all_uconv.pdf'));
%         
%         
%         figure
%         plot(spd_uconv_1_5, Vtke_uconv_1_5, 'r-*', spd_uconv_3, Vtke_uconv_3, 'g-*', spd_uconv_4_5, Vtke_uconv_4_5, 'b-*', spd_uconv_6, Vtke_uconv_6, 'c-*', spd_uconv_10, Vtke_uconv_10, 'k-*')
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title(strcat(targetDate, ' Upper Convergence Tower Data'))
%         %legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m')
%         tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m');
%         set(tempLegend, 'Location', 'best')
%         print(gcf, strcat(targetDate, '_one_uconv.png'), '-dpng','-r1000');
%         movefile(strcat(targetDate, '_one_uconv.png'), strcat('Jielun\', targetDate, '_one_uconv.png'));
        
        % Lower convergence tower
        [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 234}, windTable{varStartIdx:varEndIdx, 264}, windTable{varStartIdx:varEndIdx, 294}, speedTable{varStartIdx:varEndIdx, 25});
        [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 235}, windTable{varStartIdx:varEndIdx, 265}, windTable{varStartIdx:varEndIdx, 295}, speedTable{varStartIdx:varEndIdx, 26});
        [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 236}, windTable{varStartIdx:varEndIdx, 266}, windTable{varStartIdx:varEndIdx, 296}, speedTable{varStartIdx:varEndIdx, 27});
        [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 237}, windTable{varStartIdx:varEndIdx, 267}, windTable{varStartIdx:varEndIdx, 297}, speedTable{varStartIdx:varEndIdx, 28});
        [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 238}, windTable{varStartIdx:varEndIdx, 268}, windTable{varStartIdx:varEndIdx, 298}, speedTable{varStartIdx:varEndIdx, 32});
        [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 239}, windTable{varStartIdx:varEndIdx, 269}, windTable{varStartIdx:varEndIdx, 299}, speedTable{varStartIdx:varEndIdx, 29});
        [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 240}, windTable{varStartIdx:varEndIdx, 270}, windTable{varStartIdx:varEndIdx, 300}, speedTable{varStartIdx:varEndIdx, 34});
        [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 241}, windTable{varStartIdx:varEndIdx, 271}, windTable{varStartIdx:varEndIdx, 301}, speedTable{varStartIdx:varEndIdx, 36});
        
        Vtke_lconv_1_5_ALL = [Vtke_lconv_1_5_ALL; Vtke_lconv_1_5];
        TKE_lconv_1_5_ALL = [TKE_lconv_1_5_ALL; TKE_lconv_1_5]; 
        spd_lconv_1_5_ALL = [spd_lconv_1_5_ALL; spd_lconv_1_5];
        
        Vtke_lconv_3_ALL = [Vtke_lconv_3_ALL; Vtke_lconv_3];
        TKE_lconv_3_ALL = [TKE_lconv_3_ALL; TKE_lconv_3]; 
        spd_lconv_3_ALL = [spd_lconv_3_ALL; spd_lconv_3];
        
        Vtke_lconv_4_5_ALL = [Vtke_lconv_4_5_ALL; Vtke_lconv_4_5];
        TKE_lconv_4_5_ALL = [TKE_lconv_4_5_ALL; TKE_lconv_4_5]; 
        spd_lconv_4_5_ALL = [spd_lconv_4_5_ALL; spd_lconv_4_5];
        
        Vtke_lconv_6_ALL = [Vtke_lconv_6_ALL; Vtke_lconv_6];
        TKE_lconv_6_ALL = [TKE_lconv_6_ALL; TKE_lconv_6]; 
        spd_lconv_6_ALL = [spd_lconv_6_ALL; spd_lconv_6];
        
        Vtke_lconv_8_5_ALL = [Vtke_lconv_8_5_ALL; Vtke_lconv_8_5];
        TKE_lconv_8_5_ALL = [TKE_lconv_8_5_ALL; TKE_lconv_8_5]; 
        spd_lconv_8_5_ALL = [spd_lconv_8_5_ALL; spd_lconv_8_5];
        
        Vtke_lconv_10_ALL = [Vtke_lconv_10_ALL; Vtke_lconv_10];
        TKE_lconv_10_ALL = [TKE_lconv_10_ALL; TKE_lconv_10]; 
        spd_lconv_10_ALL = [spd_lconv_10_ALL; spd_lconv_10];
        
        Vtke_lconv_15_ALL = [Vtke_lconv_15_ALL; Vtke_lconv_15];
        TKE_lconv_15_ALL = [TKE_lconv_15_ALL; TKE_lconv_15]; 
        spd_lconv_15_ALL = [spd_lconv_15_ALL; spd_lconv_15];
        
        Vtke_lconv_20_ALL = [Vtke_lconv_20_ALL; Vtke_lconv_20];
        TKE_lconv_20_ALL = [TKE_lconv_20_ALL; TKE_lconv_20]; 
        spd_lconv_20_ALL = [spd_lconv_20_ALL; spd_lconv_20];
        
%         % Plot it
%         figure
%         subplot(4, 2, 1)
%         plot(spd_lconv_1_5, Vtke_lconv_1_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('1.5m')
%         subplot(4, 2, 2)
%         plot(spd_lconv_3, Vtke_lconv_3)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('3.0m')
%         subplot(4, 2, 3)
%         plot(spd_lconv_4_5, Vtke_lconv_4_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('4.5m')
%         subplot(4, 2, 4)
%         plot(spd_lconv_6, Vtke_lconv_6)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('6.0m')
%         subplot(4, 2, 5)
%         plot(spd_lconv_8_5, Vtke_lconv_8_5)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('8.5m')
%         subplot(4, 2, 6)
%         plot(spd_lconv_10, Vtke_lconv_10)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('10.0m')
%         subplot(4, 2, 7)
%         plot(spd_lconv_15, Vtke_lconv_15)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('15.0m')
%         subplot(4, 2, 8)
%         plot(spd_lconv_20, Vtke_lconv_20)
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title('20.0m')
%         %set(gcf,'PaperSize',[40 20])
%         print(gcf, strcat(targetDate, '_all_lconv'), '-dpdf','-fillpage');
%         movefile(strcat(targetDate, '_all_lconv.pdf'), strcat('Jielun\', targetDate, '_all_lconv.pdf'));
%         
%         figure
%         plot(spd_lconv_1_5, Vtke_lconv_1_5, 'r-*', spd_lconv_3, Vtke_lconv_3, 'g-*', spd_lconv_4_5, Vtke_lconv_4_5, 'b-*', spd_lconv_6, Vtke_lconv_6, 'c-*', spd_lconv_8_5, Vtke_lconv_8_5, 'k-*');
%         hold on
%         plot(spd_lconv_10, Vtke_lconv_10, 'Color', c.gl, 'Marker', '*');
%         hold on
%         plot(spd_lconv_15, Vtke_lconv_15, 'Color', c.um, 'Marker', '*');
%         hold on
%         plot(spd_lconv_20, Vtke_lconv_20, 'Color', c.br, 'Marker', '*');
%         hold off
%         xlabel('Wind Speed (m/s)')
%         ylabel('V tke')
%         title(strcat(targetDate, ' Lower Convergence Tower Data'))
%         %legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
%         tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m');
%         set(tempLegend, 'Location', 'best')
%         %set(gcf,'PaperSize',[40 20])
%         print(gcf, strcat(targetDate, '_one_lconv.png'), '-dpng','-r1000');
%         movefile(strcat(targetDate, '_one_lconv.png'), strcat('Jielun\', targetDate, '_one_lconv.png'));
        
        % To close all the windows
        close all
        
        bar_fence = repmat('|',length(CDT_Time(varStartIdx:varEndIdx)),1);
        
        % Now we can form table
%         % Group table
%         tempT_tke = table(CDT_Time(varStartIdx:varEndIdx), bar_fence, spd_init_1_5, Vtke_init_1_5, spd_init_3, Vtke_init_3, spd_init_4_5, Vtke_init_4_5, spd_init_6, Vtke_init_6, spd_init_10, Vtke_init_10, ...
%             bar_fence, spd_rel_1_5, Vtke_rel_1_5, spd_rel_3, Vtke_rel_3, spd_rel_4_5, Vtke_rel_4_5, spd_rel_6, Vtke_rel_6, spd_rel_8_5, Vtke_rel_8_5, spd_rel_10, Vtke_rel_10, spd_rel_15, Vtke_rel_15, spd_rel_20, Vtke_rel_20,...
%             bar_fence, spd_uconv_1_5, Vtke_uconv_1_5, spd_uconv_3, Vtke_uconv_3, spd_uconv_4_5, Vtke_uconv_4_5, spd_uconv_6, Vtke_uconv_6, spd_uconv_10, Vtke_uconv_10,...
%             spd_lconv_1_5, Vtke_lconv_1_5, spd_lconv_3, Vtke_lconv_3, spd_lconv_4_5, Vtke_lconv_4_5, spd_lconv_6, Vtke_lconv_6, spd_lconv_8_5, Vtke_lconv_8_5, spd_lconv_10, Vtke_lconv_10, spd_lconv_15, Vtke_lconv_15, spd_lconv_20, Vtke_lconv_20);
%         
%         % Format table name
%         table_name_tke = strcat(targetDate, '_Speed_vs_Vtke.csv');
%         
%         % Output table
%         writetable(tempT_tke, table_name_tke);
%         movefile(strcat(targetDate, '_Speed_vs_Vtke.csv'), strcat('Jielun\', targetDate, '_Speed_vs_Vtke.csv'));
        
        

    end

    
end

[spd_init_1_5_sorted(:, 1), spd_init_1_5_sorted_order] = sort(spd_init_1_5_ALL);
Vtke_init_1_5_ALL_sorted(:, 1) = Vtke_init_1_5_ALL(spd_init_1_5_sorted_order, 1);
TKE_init_1_5_ALL_sorted(:, 1) = TKE_init_1_5_ALL(spd_init_1_5_sorted_order, 1);

[spd_init_3_sorted(:, 1), spd_init_3_sorted_order] = sort(spd_init_3_ALL);
Vtke_init_3_ALL_sorted(:, 1) = Vtke_init_3_ALL(spd_init_3_sorted_order, 1);
TKE_init_3_ALL_sorted(:, 1) = TKE_init_3_ALL(spd_init_3_sorted_order, 1);

[spd_init_4_5_sorted(:, 1), spd_init_4_5_sorted_order] = sort(spd_init_4_5_ALL);
Vtke_init_4_5_ALL_sorted(:, 1) = Vtke_init_4_5_ALL(spd_init_4_5_sorted_order, 1);
TKE_init_4_5_ALL_sorted(:, 1) = TKE_init_4_5_ALL(spd_init_4_5_sorted_order, 1);

[spd_init_6_sorted(:, 1), spd_init_6_sorted_order] = sort(spd_init_6_ALL);
Vtke_init_6_ALL_sorted(:, 1) = Vtke_init_6_ALL(spd_init_6_sorted_order, 1);
TKE_init_6_ALL_sorted(:, 1) = TKE_init_6_ALL(spd_init_6_sorted_order, 1);

[spd_init_10_sorted(:, 1), spd_init_10_sorted_order] = sort(spd_init_10_ALL);
Vtke_init_10_ALL_sorted(:, 1) = Vtke_init_10_ALL(spd_init_10_sorted_order, 1);
TKE_init_10_ALL_sorted(:, 1) = TKE_init_10_ALL(spd_init_10_sorted_order, 1);


[spd_rel_1_5_sorted(:, 1), spd_rel_1_5_sorted_order] = sort(spd_rel_1_5_ALL);
Vtke_rel_1_5_ALL_sorted(:, 1) = Vtke_rel_1_5_ALL(spd_rel_1_5_sorted_order, 1);
TKE_rel_1_5_ALL_sorted(:, 1) = TKE_rel_1_5_ALL(spd_rel_1_5_sorted_order, 1);

[spd_rel_3_sorted(:, 1), spd_rel_3_sorted_order] = sort(spd_rel_3_ALL);
Vtke_rel_3_ALL_sorted(:, 1) = Vtke_rel_3_ALL(spd_rel_3_sorted_order, 1);
TKE_rel_3_ALL_sorted(:, 1) = TKE_rel_3_ALL(spd_rel_3_sorted_order, 1);

[spd_rel_4_5_sorted(:, 1), spd_rel_4_5_sorted_order] = sort(spd_rel_4_5_ALL);
Vtke_rel_4_5_ALL_sorted(:, 1) = Vtke_rel_4_5_ALL(spd_rel_4_5_sorted_order, 1);
TKE_rel_4_5_ALL_sorted(:, 1) = TKE_rel_4_5_ALL(spd_rel_4_5_sorted_order, 1);

[spd_rel_6_sorted(:, 1), spd_rel_6_sorted_order] = sort(spd_rel_6_ALL);
Vtke_rel_6_ALL_sorted(:, 1) = Vtke_rel_6_ALL(spd_rel_6_sorted_order, 1);
TKE_rel_6_ALL_sorted(:, 1) = TKE_rel_6_ALL(spd_rel_6_sorted_order, 1);

[spd_rel_8_5_sorted(:, 1), spd_rel_8_5_sorted_order] = sort(spd_rel_8_5_ALL);
Vtke_rel_8_5_ALL_sorted(:, 1) = Vtke_rel_8_5_ALL(spd_rel_8_5_sorted_order, 1);
TKE_rel_8_5_ALL_sorted(:, 1) = TKE_rel_8_5_ALL(spd_rel_8_5_sorted_order, 1);

[spd_rel_10_sorted(:, 1), spd_rel_10_sorted_order] = sort(spd_rel_10_ALL);
Vtke_rel_10_ALL_sorted(:, 1) = Vtke_rel_10_ALL(spd_rel_10_sorted_order, 1);
TKE_rel_10_ALL_sorted(:, 1) = TKE_rel_10_ALL(spd_rel_10_sorted_order, 1);

[spd_rel_15_sorted(:, 1), spd_rel_15_sorted_order] = sort(spd_rel_15_ALL);
Vtke_rel_15_ALL_sorted(:, 1) = Vtke_rel_15_ALL(spd_rel_15_sorted_order, 1);
TKE_rel_15_ALL_sorted(:, 1) = TKE_rel_15_ALL(spd_rel_15_sorted_order, 1);

[spd_rel_20_sorted(:, 1), spd_rel_20_sorted_order] = sort(spd_rel_20_ALL);
Vtke_rel_20_ALL_sorted(:, 1) = Vtke_rel_20_ALL(spd_rel_20_sorted_order, 1);
TKE_rel_20_ALL_sorted(:, 1) = TKE_rel_20_ALL(spd_rel_20_sorted_order, 1);

[spd_uconv_1_5_sorted(:, 1), spd_uconv_1_5_sorted_order] = sort(spd_uconv_1_5_ALL);
Vtke_uconv_1_5_ALL_sorted(:, 1) = Vtke_uconv_1_5_ALL(spd_uconv_1_5_sorted_order, 1);
TKE_uconv_1_5_ALL_sorted(:, 1) = TKE_uconv_1_5_ALL(spd_uconv_1_5_sorted_order, 1);

[spd_uconv_3_sorted(:, 1), spd_uconv_3_sorted_order] = sort(spd_uconv_3_ALL);
Vtke_uconv_3_ALL_sorted(:, 1) = Vtke_uconv_3_ALL(spd_uconv_3_sorted_order, 1);
TKE_uconv_3_ALL_sorted(:, 1) = TKE_uconv_3_ALL(spd_uconv_3_sorted_order, 1);

[spd_uconv_4_5_sorted(:, 1), spd_uconv_4_5_sorted_order] = sort(spd_uconv_4_5_ALL);
Vtke_uconv_4_5_ALL_sorted(:, 1) = Vtke_uconv_4_5_ALL(spd_uconv_4_5_sorted_order, 1);
TKE_uconv_4_5_ALL_sorted(:, 1) = TKE_uconv_4_5_ALL(spd_uconv_4_5_sorted_order, 1);

[spd_uconv_6_sorted(:, 1), spd_uconv_6_sorted_order] = sort(spd_uconv_6_ALL);
Vtke_uconv_6_ALL_sorted(:, 1) = Vtke_uconv_6_ALL(spd_uconv_6_sorted_order, 1);
TKE_uconv_6_ALL_sorted(:, 1) = TKE_uconv_6_ALL(spd_uconv_6_sorted_order, 1);

[spd_uconv_10_sorted(:, 1), spd_uconv_10_sorted_order] = sort(spd_uconv_10_ALL);
Vtke_uconv_10_ALL_sorted(:, 1) = Vtke_uconv_10_ALL(spd_uconv_10_sorted_order, 1);
TKE_uconv_10_ALL_sorted(:, 1) = TKE_uconv_10_ALL(spd_uconv_10_sorted_order, 1);

[spd_lconv_1_5_sorted(:, 1), spd_lconv_1_5_sorted_order] = sort(spd_lconv_1_5_ALL);
Vtke_lconv_1_5_ALL_sorted(:, 1) = Vtke_lconv_1_5_ALL(spd_lconv_1_5_sorted_order, 1);
TKE_lconv_1_5_ALL_sorted(:, 1) = TKE_lconv_1_5_ALL(spd_lconv_1_5_sorted_order, 1);

[spd_lconv_3_sorted(:, 1), spd_lconv_3_sorted_order] = sort(spd_lconv_3_ALL);
Vtke_lconv_3_ALL_sorted(:, 1) = Vtke_lconv_3_ALL(spd_lconv_3_sorted_order, 1);
TKE_lconv_3_ALL_sorted(:, 1) = TKE_lconv_3_ALL(spd_lconv_3_sorted_order, 1);

[spd_lconv_4_5_sorted(:, 1), spd_lconv_4_5_sorted_order] = sort(spd_lconv_4_5_ALL);
Vtke_lconv_4_5_ALL_sorted(:, 1) = Vtke_lconv_4_5_ALL(spd_lconv_4_5_sorted_order, 1);
TKE_lconv_4_5_ALL_sorted(:, 1) = TKE_lconv_4_5_ALL(spd_lconv_4_5_sorted_order, 1);

[spd_lconv_6_sorted(:, 1), spd_lconv_6_sorted_order] = sort(spd_lconv_6_ALL);
Vtke_lconv_6_ALL_sorted(:, 1) = Vtke_lconv_6_ALL(spd_lconv_6_sorted_order, 1);
TKE_lconv_6_ALL_sorted(:, 1) = TKE_lconv_6_ALL(spd_lconv_6_sorted_order, 1);

[spd_lconv_8_5_sorted(:, 1), spd_lconv_8_5_sorted_order] = sort(spd_lconv_8_5_ALL);
Vtke_lconv_8_5_ALL_sorted(:, 1) = Vtke_lconv_8_5_ALL(spd_lconv_8_5_sorted_order, 1);
TKE_lconv_8_5_ALL_sorted(:, 1) = TKE_lconv_8_5_ALL(spd_lconv_8_5_sorted_order, 1);

[spd_lconv_10_sorted(:, 1), spd_lconv_10_sorted_order] = sort(spd_lconv_10_ALL);
Vtke_lconv_10_ALL_sorted(:, 1) = Vtke_lconv_10_ALL(spd_lconv_10_sorted_order, 1);
TKE_lconv_10_ALL_sorted(:, 1) = TKE_lconv_10_ALL(spd_lconv_10_sorted_order, 1);

[spd_lconv_15_sorted(:, 1), spd_lconv_15_sorted_order] = sort(spd_lconv_15_ALL);
Vtke_lconv_15_ALL_sorted(:, 1) = Vtke_lconv_15_ALL(spd_lconv_15_sorted_order, 1);
TKE_lconv_15_ALL_sorted(:, 1) = TKE_lconv_15_ALL(spd_lconv_15_sorted_order, 1);

[spd_lconv_20_sorted(:, 1), spd_lconv_20_sorted_order] = sort(spd_lconv_20_ALL);
Vtke_lconv_20_ALL_sorted(:, 1) = Vtke_lconv_20_ALL(spd_lconv_20_sorted_order, 1);
TKE_lconv_20_ALL_sorted(:, 1) = TKE_lconv_20_ALL(spd_lconv_20_sorted_order, 1);
