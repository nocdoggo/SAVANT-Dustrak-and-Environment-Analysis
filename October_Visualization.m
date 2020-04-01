% October data visualization
% This is for Jielun's paper calculation
% Initialize memory space
clc, clear all, close all

% Prompt User Selection
%fprintf('=============================================================================');
%fprintf('\n');
%file_dir = input('Please enter the name of the input environmental file folder: \n', 's');

% The first ones are the 
file_dir = 'S';
file_dir2 = 'calculations';     % May not be used only if need to cheap out on calculation time.

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


% Initialization on buffer
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Date dictionary
date_dict = [1001:1031];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
init_count = zeros(1, 3);
rel_count = zeros(1, 3);
uconv_count = zeros(1, 3);
lconv_count = zeros(1, 3);

for daterange = date_dict
    
	% Convert to proper format
	targetDate = num2str(daterange);
    dateStamp = str2double(targetDate);
    %targetDate = strcat('0', targetDate);

    % Create file list
    speedfile = strcat(file_dir, filesep, strcat(targetDate, '_Speed.csv'));
    directionfile = strcat(file_dir, filesep, strcat(targetDate, '_Direction.csv'));
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
        directionTable = readtable(directionfile);
        temperatureTable = readtable(temperaturefile);
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
        varStartIdx = 1;		% Always starts from the first line (After skipping off the variable name list)
        %[varEndIdx, whateveritis] = size(speedTable{:,1});
		varEndIdx = 144;		% 12 samples per hour, and we choose 12 hours as stated in Jielun's paper
        
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
		index_list_A = find(speedTable{varStartIdx:varEndIdx, 38} == 1);
		index_list_B = find(temperatureTable{varStartIdx:varEndIdx, 31} == 1);
        index_list_C = find(directionTable{varStartIdx:varEndIdx, 38} == 1);
        index_list_temp = intersect(index_list_A, index_list_B);
        index_list = intersect(index_list_temp, index_list_C);
        
        init_count(1) = init_count(1) + length(index_list_A);
        init_count(2) = init_count(2) + length(index_list_B);
        init_count(3) = init_count(3) + length(index_list_C);
        		
        [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5] = Jielun_TKE_simple(windTable{index_list, 213}, windTable{index_list, 243}, windTable{index_list, 273}, speedTable{index_list, 4});
        [Vtke_init_3, TKE_init_3, spd_init_3] = Jielun_TKE_simple(windTable{index_list, 214}, windTable{index_list, 244}, windTable{index_list, 274}, speedTable{index_list, 5});
        [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5] = Jielun_TKE_simple(windTable{index_list, 215}, windTable{index_list, 245}, windTable{index_list, 275}, speedTable{index_list, 6});
        [Vtke_init_6, TKE_init_6, spd_init_6] = Jielun_TKE_simple(windTable{index_list, 216}, windTable{index_list, 246}, windTable{index_list, 276}, speedTable{index_list, 7});
        [Vtke_init_10, TKE_init_10, spd_init_10] = Jielun_TKE_simple(windTable{index_list, 217}, windTable{index_list, 247}, windTable{index_list, 277}, speedTable{index_list, 8});
        
        %     [a_sorted(:, 1), a_order] = sort(speedTable{index_list, 4});
        %     newB(:, 1) = Vtke_init_1_5(a_order,1);
        %
        %     A = a_sorted(:, 1);
        %     B = newB(:, 1);
        %     figure
        %     plot(A, B, 'r')
        
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
        
%         
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
%         movefile(strcat(targetDate, '_all_init.pdf'), strcat('Jielun', filesep, targetDate, '_all_init.pdf'));
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
%         movefile(strcat(targetDate, '_one_init.png'), strcat('Jielun', filesep, targetDate, '_one_init.png'));
%         
        
        % Release tower
        index_list_A = find(speedTable{varStartIdx:varEndIdx, 39} == 1);
		index_list_B = find(temperatureTable{varStartIdx:varEndIdx, 32} == 1);
        index_list_C = find(directionTable{varStartIdx:varEndIdx, 39} == 1);
        index_list_temp = intersect(index_list_A, index_list_B);
        index_list = intersect(index_list_temp, index_list_C);
        
        rel_count(1) = rel_count(1) + length(index_list_A);
        rel_count(2) = rel_count(2) + length(index_list_B);
        rel_count(3) = rel_count(3) + length(index_list_C);
        		
        [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5] = Jielun_TKE_simple(windTable{index_list, 219}, windTable{index_list, 249}, windTable{index_list, 279}, speedTable{index_list, 11});
        [Vtke_rel_3, TKE_rel_3, spd_rel_3] = Jielun_TKE_simple(windTable{index_list, 220}, windTable{index_list, 250}, windTable{index_list, 280}, speedTable{index_list, 12});
        [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5] = Jielun_TKE_simple(windTable{index_list, 221}, windTable{index_list, 251}, windTable{index_list, 281}, speedTable{index_list, 13});
        [Vtke_rel_6, TKE_rel_6, spd_rel_6] = Jielun_TKE_simple(windTable{index_list, 222}, windTable{index_list, 252}, windTable{index_list, 282}, speedTable{index_list, 14});
        [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5] = Jielun_TKE_simple(windTable{index_list, 223}, windTable{index_list, 253}, windTable{index_list, 283}, speedTable{index_list, 31});
        [Vtke_rel_10, TKE_rel_10, spd_rel_10] = Jielun_TKE_simple(windTable{index_list, 224}, windTable{index_list, 254}, windTable{index_list, 284}, speedTable{index_list, 15});
        [Vtke_rel_15, TKE_rel_15, spd_rel_15] = Jielun_TKE_simple(windTable{index_list, 225}, windTable{index_list, 255}, windTable{index_list, 285}, speedTable{index_list, 33});
        [Vtke_rel_20, TKE_rel_20, spd_rel_20] = Jielun_TKE_simple(windTable{index_list, 226}, windTable{index_list, 256}, windTable{index_list, 286}, speedTable{index_list, 35});
        
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
        
        % Plot it
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
%         movefile(strcat(targetDate, '_all_rel.pdf'), strcat('Jielun', filesep, targetDate, '_all_rel.pdf'));
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
%         tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '8.5m', '10.0m', '15.0m', '20.0m');
%         set(tempLegend, 'Location', 'best')
%         print(gcf, strcat(targetDate, '_one_rel.png'), '-dpng','-r1000');
%         movefile(strcat(targetDate, '_one_rel.png'), strcat('Jielun', filesep, targetDate, '_one_rel.png'));
        
        % Upper convergence tower
        index_list_A = find(speedTable{varStartIdx:varEndIdx, 40} == 1);
		index_list_B = find(temperatureTable{varStartIdx:varEndIdx, 33} == 1);
        index_list_C = find(directionTable{varStartIdx:varEndIdx, 40} == 1);
        index_list_temp = intersect(index_list_A, index_list_B);
        index_list = intersect(index_list_temp, index_list_C);
		
        uconv_count(1) = uconv_count(1) + length(index_list_A);
        uconv_count(2) = uconv_count(2) + length(index_list_B);
        uconv_count(3) = uconv_count(3) + length(index_list_C);
        
        [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5] = Jielun_TKE_simple(windTable{index_list, 228}, windTable{index_list, 258}, windTable{index_list, 288}, speedTable{index_list, 18});
        [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3] = Jielun_TKE_simple(windTable{index_list, 229}, windTable{index_list, 259}, windTable{index_list, 289}, speedTable{index_list, 19});
        [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5] = Jielun_TKE_simple(windTable{index_list, 230}, windTable{index_list, 260}, windTable{index_list, 290}, speedTable{index_list, 20});
        [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6] = Jielun_TKE_simple(windTable{index_list, 231}, windTable{index_list, 261}, windTable{index_list, 291}, speedTable{index_list, 21});
        [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10] = Jielun_TKE_simple(windTable{index_list, 232}, windTable{index_list, 262}, windTable{index_list, 292}, speedTable{index_list, 22});
        
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
        
        % Plot it
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
%         movefile(strcat(targetDate, '_all_uconv.pdf'), strcat('Jielun', filesep, targetDate, '_all_uconv.pdf'));
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
%         movefile(strcat(targetDate, '_one_uconv.png'), strcat('Jielun', filesep, targetDate, '_one_uconv.png'));
        
        % Lower convergence tower
        index_list_A = find(speedTable{varStartIdx:varEndIdx, 41} == 1);
		index_list_B = find(temperatureTable{varStartIdx:varEndIdx, 34} == 1);
        index_list_C = find(directionTable{varStartIdx:varEndIdx, 41} == 1);
        index_list_temp = intersect(index_list_A, index_list_B);
        index_list = intersect(index_list_temp, index_list_C);
		
        lconv_count(1) = lconv_count(1) + length(index_list_A);
        lconv_count(2) = lconv_count(2) + length(index_list_B);
        lconv_count(3) = lconv_count(3) + length(index_list_C);
        
        [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5] = Jielun_TKE_simple(windTable{index_list, 234}, windTable{index_list, 264}, windTable{index_list, 294}, speedTable{index_list, 25});
        [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3] = Jielun_TKE_simple(windTable{index_list, 235}, windTable{index_list, 265}, windTable{index_list, 295}, speedTable{index_list, 26});
        [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5] = Jielun_TKE_simple(windTable{index_list, 236}, windTable{index_list, 266}, windTable{index_list, 296}, speedTable{index_list, 27});
        [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6] = Jielun_TKE_simple(windTable{index_list, 237}, windTable{index_list, 267}, windTable{index_list, 297}, speedTable{index_list, 28});
        [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5] = Jielun_TKE_simple(windTable{index_list, 238}, windTable{index_list, 268}, windTable{index_list, 298}, speedTable{index_list, 32});
        [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10] = Jielun_TKE_simple(windTable{index_list, 239}, windTable{index_list, 269}, windTable{index_list, 299}, speedTable{index_list, 29});
        [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15] = Jielun_TKE_simple(windTable{index_list, 240}, windTable{index_list, 270}, windTable{index_list, 300}, speedTable{index_list, 34});
        [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20] = Jielun_TKE_simple(windTable{index_list, 241}, windTable{index_list, 271}, windTable{index_list, 301}, speedTable{index_list, 36});
        
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
        
        % Plot it
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
%         movefile(strcat(targetDate, '_all_lconv.pdf'), strcat('Jielun', filesep, targetDate, '_all_lconv.pdf'));
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
%         tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '8.5m', '10.0m', '15.0m', '20.0m');
%         set(tempLegend, 'Location', 'best')
%         %set(gcf,'PaperSize',[40 20])
%         print(gcf, strcat(targetDate, '_one_lconv.png'), '-dpng','-r1000');
%         movefile(strcat(targetDate, '_one_lconv.png'), strcat('Jielun', filesep, targetDate, '_one_lconv.png'));
        
        % To close all the windows
        close all
        
%         bar_fence = repmat('|',length(CDT_Time(index_list)),1);
%         
%         % Now we can form table
%         % Group table
%         tempT_tke = table(CDT_Time(index_list), bar_fence, spd_init_1_5, Vtke_init_1_5, spd_init_3, Vtke_init_3, spd_init_4_5, Vtke_init_4_5, spd_init_6, Vtke_init_6, spd_init_10, Vtke_init_10, ...
%             bar_fence, spd_rel_1_5, Vtke_rel_1_5, spd_rel_3, Vtke_rel_3, spd_rel_4_5, Vtke_rel_4_5, spd_rel_6, Vtke_rel_6, spd_rel_8_5, Vtke_rel_8_5, spd_rel_10, Vtke_rel_10, spd_rel_15, Vtke_rel_15, spd_rel_20, Vtke_rel_20,...
%             bar_fence, spd_uconv_1_5, Vtke_uconv_1_5, spd_uconv_3, Vtke_uconv_3, spd_uconv_4_5, Vtke_uconv_4_5, spd_uconv_6, Vtke_uconv_6, spd_uconv_10, Vtke_uconv_10,...
%             spd_lconv_1_5, Vtke_lconv_1_5, spd_lconv_3, Vtke_lconv_3, spd_lconv_4_5, Vtke_lconv_4_5, spd_lconv_6, Vtke_lconv_6, spd_lconv_8_5, Vtke_lconv_8_5, spd_lconv_10, Vtke_lconv_10, spd_lconv_15, Vtke_lconv_15, spd_lconv_20, Vtke_lconv_20);
%         
%         % Format table name
%         table_name_tke = strcat(targetDate, '_Speed_vs_Vtke.csv');
%         
%         % Output table
%         writetable(tempT_tke, table_name_tke);
%         movefile(strcat(targetDate, '_Speed_vs_Vtke.csv'), strcat('Jielun', filesep, targetDate, '_Speed_vs_Vtke.csv'));
%         
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initiation Tower

[spd_init_1_5_sorted(:, 1), spd_init_1_5_sorted_order] = sort(spd_init_1_5_ALL);
Vtke_init_1_5_ALL_sorted(:, 1) = Vtke_init_1_5_ALL(spd_init_1_5_sorted_order, 1);
TKE_init_1_5_ALL_sorted(:, 1) = TKE_init_1_5_ALL(spd_init_1_5_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_init_1_5_sorted, 0:0.25:ceil(max(spd_init_1_5_sorted)));        % Can't be fucked, just going to use histc
spd_init_1_5_mean = accumarray(idx(:),spd_init_1_5_sorted,[],@mean);
spd_init_1_5_std = accumarray(idx(:),spd_init_1_5_sorted,[],@std);
Vtke_init_1_5_mean = accumarray(idx(:),Vtke_init_1_5_ALL_sorted,[],@mean);
valid_idx_init_1_5 = find(spd_init_1_5_mean > 0);

[spd_init_3_sorted(:, 1), spd_init_3_sorted_order] = sort(spd_init_3_ALL);
Vtke_init_3_ALL_sorted(:, 1) = Vtke_init_3_ALL(spd_init_3_sorted_order, 1);
TKE_init_3_ALL_sorted(:, 1) = TKE_init_3_ALL(spd_init_3_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_init_3_sorted, 0:0.25:ceil(max(spd_init_3_sorted)));        % Can't be fucked, just going to use histc
spd_init_3_mean = accumarray(idx(:),spd_init_3_sorted,[],@mean);
spd_init_3_std = accumarray(idx(:),spd_init_3_sorted,[],@std);
Vtke_init_3_mean = accumarray(idx(:),Vtke_init_3_ALL_sorted,[],@mean);
valid_idx_init_3 = find(spd_init_3_mean > 0);

[spd_init_4_5_sorted(:, 1), spd_init_4_5_sorted_order] = sort(spd_init_4_5_ALL);
Vtke_init_4_5_ALL_sorted(:, 1) = Vtke_init_4_5_ALL(spd_init_4_5_sorted_order, 1);
TKE_init_4_5_ALL_sorted(:, 1) = TKE_init_4_5_ALL(spd_init_4_5_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_init_4_5_sorted, 0:0.25:ceil(max(spd_init_4_5_sorted)));        % Can't be fucked, just going to use histc
spd_init_4_5_mean = accumarray(idx(:),spd_init_4_5_sorted,[],@mean);
spd_init_4_5_std = accumarray(idx(:),spd_init_4_5_sorted,[],@std);
Vtke_init_4_5_mean = accumarray(idx(:),Vtke_init_4_5_ALL_sorted,[],@mean);
valid_idx_init_4_5 = find(spd_init_4_5_mean > 0);

[spd_init_6_sorted(:, 1), spd_init_6_sorted_order] = sort(spd_init_6_ALL);
Vtke_init_6_ALL_sorted(:, 1) = Vtke_init_6_ALL(spd_init_6_sorted_order, 1);
TKE_init_6_ALL_sorted(:, 1) = TKE_init_6_ALL(spd_init_6_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_init_6_sorted, 0:0.25:ceil(max(spd_init_6_sorted)));        % Can't be fucked, just going to use histc
spd_init_6_mean = accumarray(idx(:),spd_init_6_sorted,[],@mean);
spd_init_6_std = accumarray(idx(:),spd_init_6_sorted,[],@std);
Vtke_init_6_mean = accumarray(idx(:),Vtke_init_6_ALL_sorted,[],@mean);
valid_idx_init_6 = find(spd_init_6_mean > 0);

[spd_init_10_sorted(:, 1), spd_init_10_sorted_order] = sort(spd_init_10_ALL);
Vtke_init_10_ALL_sorted(:, 1) = Vtke_init_10_ALL(spd_init_10_sorted_order, 1);
TKE_init_10_ALL_sorted(:, 1) = TKE_init_10_ALL(spd_init_10_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_init_10_sorted, 0:0.25:ceil(max(spd_init_10_sorted)));        % Can't be fucked, just going to use histc
spd_init_10_mean = accumarray(idx(:),spd_init_10_sorted,[],@mean);
spd_init_10_std = accumarray(idx(:),spd_init_10_sorted,[],@std);
Vtke_init_10_mean = accumarray(idx(:),Vtke_init_10_ALL_sorted,[],@mean);
valid_idx_init_10 = find(spd_init_10_mean > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Release Tower

[spd_rel_1_5_sorted(:, 1), spd_rel_1_5_sorted_order] = sort(spd_rel_1_5_ALL);
Vtke_rel_1_5_ALL_sorted(:, 1) = Vtke_rel_1_5_ALL(spd_rel_1_5_sorted_order, 1);
TKE_rel_1_5_ALL_sorted(:, 1) = TKE_rel_1_5_ALL(spd_rel_1_5_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_rel_1_5_sorted, 0:0.25:ceil(max(spd_rel_1_5_sorted)));        % Can't be fucked, just going to use histc
spd_rel_1_5_mean = accumarray(idx(:),spd_rel_1_5_sorted,[],@mean);
spd_rel_1_5_std = accumarray(idx(:),spd_rel_1_5_sorted,[],@std);
Vtke_rel_1_5_mean = accumarray(idx(:),Vtke_rel_1_5_ALL_sorted,[],@mean);
valid_idx_rel_1_5 = find(spd_rel_1_5_mean > 0);

[spd_rel_3_sorted(:, 1), spd_rel_3_sorted_order] = sort(spd_rel_3_ALL);
Vtke_rel_3_ALL_sorted(:, 1) = Vtke_rel_3_ALL(spd_rel_3_sorted_order, 1);
TKE_rel_3_ALL_sorted(:, 1) = TKE_rel_3_ALL(spd_rel_3_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_rel_3_sorted, 0:0.25:ceil(max(spd_rel_3_sorted)));        % Can't be fucked, just going to use histc
spd_rel_3_mean = accumarray(idx(:),spd_rel_3_sorted,[],@mean);
spd_rel_3_std = accumarray(idx(:),spd_rel_3_sorted,[],@std);
Vtke_rel_3_mean = accumarray(idx(:),Vtke_rel_3_ALL_sorted,[],@mean);
valid_idx_rel_3 = find(spd_rel_3_mean > 0);

[spd_rel_4_5_sorted(:, 1), spd_rel_4_5_sorted_order] = sort(spd_rel_4_5_ALL);
Vtke_rel_4_5_ALL_sorted(:, 1) = Vtke_rel_4_5_ALL(spd_rel_4_5_sorted_order, 1);
TKE_rel_4_5_ALL_sorted(:, 1) = TKE_rel_4_5_ALL(spd_rel_4_5_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_rel_4_5_sorted, 0:0.25:ceil(max(spd_rel_4_5_sorted)));        % Can't be fucked, just going to use histc
spd_rel_4_5_mean = accumarray(idx(:),spd_rel_4_5_sorted,[],@mean);
spd_rel_4_5_std = accumarray(idx(:),spd_rel_4_5_sorted,[],@std);
Vtke_rel_4_5_mean = accumarray(idx(:),Vtke_rel_4_5_ALL_sorted,[],@mean);
valid_idx_rel_4_5 = find(spd_rel_4_5_mean > 0);

[spd_rel_6_sorted(:, 1), spd_rel_6_sorted_order] = sort(spd_rel_6_ALL);
Vtke_rel_6_ALL_sorted(:, 1) = Vtke_rel_6_ALL(spd_rel_6_sorted_order, 1);
TKE_rel_6_ALL_sorted(:, 1) = TKE_rel_6_ALL(spd_rel_6_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_rel_6_sorted, 0:0.25:ceil(max(spd_rel_6_sorted)));        % Can't be fucked, just going to use histc
spd_rel_6_mean = accumarray(idx(:),spd_rel_6_sorted,[],@mean);
spd_rel_6_std = accumarray(idx(:),spd_rel_6_sorted,[],@std);
Vtke_rel_6_mean = accumarray(idx(:),Vtke_rel_6_ALL_sorted,[],@mean);
valid_idx_rel_6 = find(spd_rel_6_mean > 0);

[spd_rel_8_5_sorted(:, 1), spd_rel_8_5_sorted_order] = sort(spd_rel_8_5_ALL);
Vtke_rel_8_5_ALL_sorted(:, 1) = Vtke_rel_8_5_ALL(spd_rel_8_5_sorted_order, 1);
TKE_rel_8_5_ALL_sorted(:, 1) = TKE_rel_8_5_ALL(spd_rel_8_5_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_rel_8_5_sorted, 0:0.25:ceil(max(spd_rel_8_5_sorted)));        % Can't be fucked, just going to use histc
spd_rel_8_5_mean = accumarray(idx(:),spd_rel_8_5_sorted,[],@mean);
spd_rel_8_5_std = accumarray(idx(:),spd_rel_8_5_sorted,[],@std);
Vtke_rel_8_5_mean = accumarray(idx(:),Vtke_rel_8_5_ALL_sorted,[],@mean);
valid_idx_rel_8_5 = find(spd_rel_8_5_mean > 0);

[spd_rel_10_sorted(:, 1), spd_rel_10_sorted_order] = sort(spd_rel_10_ALL);
Vtke_rel_10_ALL_sorted(:, 1) = Vtke_rel_10_ALL(spd_rel_10_sorted_order, 1);
TKE_rel_10_ALL_sorted(:, 1) = TKE_rel_10_ALL(spd_rel_10_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_rel_10_sorted, 0:0.25:ceil(max(spd_rel_10_sorted)));        % Can't be fucked, just going to use histc
spd_rel_10_mean = accumarray(idx(:),spd_rel_10_sorted,[],@mean);
spd_rel_10_std = accumarray(idx(:),spd_rel_10_sorted,[],@std);
Vtke_rel_10_mean = accumarray(idx(:),Vtke_rel_10_ALL_sorted,[],@mean);
valid_idx_rel_10 = find(spd_rel_10_mean > 0);

[spd_rel_15_sorted(:, 1), spd_rel_15_sorted_order] = sort(spd_rel_15_ALL);
Vtke_rel_15_ALL_sorted(:, 1) = Vtke_rel_15_ALL(spd_rel_15_sorted_order, 1);
TKE_rel_15_ALL_sorted(:, 1) = TKE_rel_15_ALL(spd_rel_15_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_rel_15_sorted, 0:0.25:ceil(max(spd_rel_15_sorted)));        % Can't be fucked, just going to use histc
spd_rel_15_mean = accumarray(idx(:),spd_rel_15_sorted,[],@mean);
spd_rel_15_std = accumarray(idx(:),spd_rel_15_sorted,[],@std);
Vtke_rel_15_mean = accumarray(idx(:),Vtke_rel_15_ALL_sorted,[],@mean);
valid_idx_rel_15 = find(spd_rel_15_mean > 0);

[spd_rel_20_sorted(:, 1), spd_rel_20_sorted_order] = sort(spd_rel_20_ALL);
Vtke_rel_20_ALL_sorted(:, 1) = Vtke_rel_20_ALL(spd_rel_20_sorted_order, 1);
TKE_rel_20_ALL_sorted(:, 1) = TKE_rel_20_ALL(spd_rel_20_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_rel_20_sorted, 0:0.25:ceil(max(spd_rel_20_sorted)));        % Can't be fucked, just going to use histc
spd_rel_20_mean = accumarray(idx(:),spd_rel_20_sorted,[],@mean);
spd_rel_20_std = accumarray(idx(:),spd_rel_20_sorted,[],@std);
Vtke_rel_20_mean = accumarray(idx(:),Vtke_rel_20_ALL_sorted,[],@mean);
valid_idx_rel_20 = find(spd_rel_20_mean > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Upper Convergence Tower

[spd_uconv_1_5_sorted(:, 1), spd_uconv_1_5_sorted_order] = sort(spd_uconv_1_5_ALL);
Vtke_uconv_1_5_ALL_sorted(:, 1) = Vtke_uconv_1_5_ALL(spd_uconv_1_5_sorted_order, 1);
TKE_uconv_1_5_ALL_sorted(:, 1) = TKE_uconv_1_5_ALL(spd_uconv_1_5_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_uconv_1_5_sorted, 0:0.25:ceil(max(spd_uconv_1_5_sorted)));        % Can't be fucked, just going to use histc
spd_uconv_1_5_mean = accumarray(idx(:),spd_uconv_1_5_sorted,[],@mean);
spd_uconv_1_5_std = accumarray(idx(:),spd_uconv_1_5_sorted,[],@std);
Vtke_uconv_1_5_mean = accumarray(idx(:),Vtke_uconv_1_5_ALL_sorted,[],@mean);
valid_idx_uconv_1_5 = find(spd_uconv_1_5_mean > 0);

[spd_uconv_3_sorted(:, 1), spd_uconv_3_sorted_order] = sort(spd_uconv_3_ALL);
Vtke_uconv_3_ALL_sorted(:, 1) = Vtke_uconv_3_ALL(spd_uconv_3_sorted_order, 1);
TKE_uconv_3_ALL_sorted(:, 1) = TKE_uconv_3_ALL(spd_uconv_3_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_uconv_3_sorted, 0:0.25:ceil(max(spd_uconv_3_sorted)));        % Can't be fucked, just going to use histc
spd_uconv_3_mean = accumarray(idx(:),spd_uconv_3_sorted,[],@mean);
spd_uconv_3_std = accumarray(idx(:),spd_uconv_3_sorted,[],@std);
Vtke_uconv_3_mean = accumarray(idx(:),Vtke_uconv_3_ALL_sorted,[],@mean);
valid_idx_uconv_3 = find(spd_uconv_3_mean > 0);

[spd_uconv_4_5_sorted(:, 1), spd_uconv_4_5_sorted_order] = sort(spd_uconv_4_5_ALL);
Vtke_uconv_4_5_ALL_sorted(:, 1) = Vtke_uconv_4_5_ALL(spd_uconv_4_5_sorted_order, 1);
TKE_uconv_4_5_ALL_sorted(:, 1) = TKE_uconv_4_5_ALL(spd_uconv_4_5_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_uconv_4_5_sorted, 0:0.25:ceil(max(spd_uconv_4_5_sorted)));        % Can't be fucked, just going to use histc
spd_uconv_4_5_mean = accumarray(idx(:),spd_uconv_4_5_sorted,[],@mean);
spd_uconv_4_5_std = accumarray(idx(:),spd_uconv_4_5_sorted,[],@std);
Vtke_uconv_4_5_mean = accumarray(idx(:),Vtke_uconv_4_5_ALL_sorted,[],@mean);
valid_idx_uconv_4_5 = find(spd_uconv_4_5_mean > 0);

[spd_uconv_6_sorted(:, 1), spd_uconv_6_sorted_order] = sort(spd_uconv_6_ALL);
Vtke_uconv_6_ALL_sorted(:, 1) = Vtke_uconv_6_ALL(spd_uconv_6_sorted_order, 1);
TKE_uconv_6_ALL_sorted(:, 1) = TKE_uconv_6_ALL(spd_uconv_6_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_uconv_6_sorted, 0:0.25:ceil(max(spd_uconv_6_sorted)));        % Can't be fucked, just going to use histc
spd_uconv_6_mean = accumarray(idx(:),spd_uconv_6_sorted,[],@mean);
spd_uconv_6_std = accumarray(idx(:),spd_uconv_6_sorted,[],@std);
Vtke_uconv_6_mean = accumarray(idx(:),Vtke_uconv_6_ALL_sorted,[],@mean);
valid_idx_uconv_6 = find(spd_uconv_6_mean > 0);

[spd_uconv_10_sorted(:, 1), spd_uconv_10_sorted_order] = sort(spd_uconv_10_ALL);
Vtke_uconv_10_ALL_sorted(:, 1) = Vtke_uconv_10_ALL(spd_uconv_10_sorted_order, 1);
TKE_uconv_10_ALL_sorted(:, 1) = TKE_uconv_10_ALL(spd_uconv_10_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_uconv_10_sorted, 0:0.25:ceil(max(spd_uconv_10_sorted)));        % Can't be fucked, just going to use histc
spd_uconv_10_mean = accumarray(idx(:),spd_uconv_10_sorted,[],@mean);
spd_uconv_10_std = accumarray(idx(:),spd_uconv_10_sorted,[],@std);
Vtke_uconv_10_mean = accumarray(idx(:),Vtke_uconv_10_ALL_sorted,[],@mean);
valid_idx_uconv_10 = find(spd_uconv_10_mean > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lower Convergence Tower

[spd_lconv_1_5_sorted(:, 1), spd_lconv_1_5_sorted_order] = sort(spd_lconv_1_5_ALL);
Vtke_lconv_1_5_ALL_sorted(:, 1) = Vtke_lconv_1_5_ALL(spd_lconv_1_5_sorted_order, 1);
TKE_lconv_1_5_ALL_sorted(:, 1) = TKE_lconv_1_5_ALL(spd_lconv_1_5_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_lconv_1_5_sorted, 0:0.25:ceil(max(spd_lconv_1_5_sorted)));        % Can't be fucked, just going to use histc
spd_lconv_1_5_mean = accumarray(idx(:),spd_lconv_1_5_sorted,[],@mean);
spd_lconv_1_5_std = accumarray(idx(:),spd_lconv_1_5_sorted,[],@std);
Vtke_lconv_1_5_mean = accumarray(idx(:),Vtke_lconv_1_5_ALL_sorted,[],@mean);
valid_idx_lconv_1_5 = find(spd_lconv_1_5_mean > 0);

[spd_lconv_3_sorted(:, 1), spd_lconv_3_sorted_order] = sort(spd_lconv_3_ALL);
Vtke_lconv_3_ALL_sorted(:, 1) = Vtke_lconv_3_ALL(spd_lconv_3_sorted_order, 1);
TKE_lconv_3_ALL_sorted(:, 1) = TKE_lconv_3_ALL(spd_lconv_3_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_lconv_3_sorted, 0:0.25:ceil(max(spd_lconv_3_sorted)));        % Can't be fucked, just going to use histc
spd_lconv_3_mean = accumarray(idx(:),spd_lconv_3_sorted,[],@mean);
spd_lconv_3_std = accumarray(idx(:),spd_lconv_3_sorted,[],@std);
Vtke_lconv_3_mean = accumarray(idx(:),Vtke_lconv_3_ALL_sorted,[],@mean);
valid_idx_lconv_3 = find(spd_lconv_3_mean > 0);

[spd_lconv_4_5_sorted(:, 1), spd_lconv_4_5_sorted_order] = sort(spd_lconv_4_5_ALL);
Vtke_lconv_4_5_ALL_sorted(:, 1) = Vtke_lconv_4_5_ALL(spd_lconv_4_5_sorted_order, 1);
TKE_lconv_4_5_ALL_sorted(:, 1) = TKE_lconv_4_5_ALL(spd_lconv_4_5_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_lconv_4_5_sorted, 0:0.25:ceil(max(spd_lconv_4_5_sorted)));        % Can't be fucked, just going to use histc
spd_lconv_4_5_mean = accumarray(idx(:),spd_lconv_4_5_sorted,[],@mean);
spd_lconv_4_5_std = accumarray(idx(:),spd_lconv_4_5_sorted,[],@std);
Vtke_lconv_4_5_mean = accumarray(idx(:),Vtke_lconv_4_5_ALL_sorted,[],@mean);
valid_idx_lconv_4_5 = find(spd_lconv_4_5_mean > 0);

[spd_lconv_6_sorted(:, 1), spd_lconv_6_sorted_order] = sort(spd_lconv_6_ALL);
Vtke_lconv_6_ALL_sorted(:, 1) = Vtke_lconv_6_ALL(spd_lconv_6_sorted_order, 1);
TKE_lconv_6_ALL_sorted(:, 1) = TKE_lconv_6_ALL(spd_lconv_6_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_lconv_6_sorted, 0:0.25:ceil(max(spd_lconv_6_sorted)));        % Can't be fucked, just going to use histc
spd_lconv_6_mean = accumarray(idx(:),spd_lconv_6_sorted,[],@mean);
spd_lconv_6_std = accumarray(idx(:),spd_lconv_6_sorted,[],@std);
Vtke_lconv_6_mean = accumarray(idx(:),Vtke_lconv_6_ALL_sorted,[],@mean);
valid_idx_lconv_6 = find(spd_lconv_6_mean > 0);

[spd_lconv_8_5_sorted(:, 1), spd_lconv_8_5_sorted_order] = sort(spd_lconv_8_5_ALL);
Vtke_lconv_8_5_ALL_sorted(:, 1) = Vtke_lconv_8_5_ALL(spd_lconv_8_5_sorted_order, 1);
TKE_lconv_8_5_ALL_sorted(:, 1) = TKE_lconv_8_5_ALL(spd_lconv_8_5_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_lconv_8_5_sorted, 0:0.25:ceil(max(spd_lconv_8_5_sorted)));        % Can't be fucked, just going to use histc
spd_lconv_8_5_mean = accumarray(idx(:),spd_lconv_8_5_sorted,[],@mean);
spd_lconv_8_5_std = accumarray(idx(:),spd_lconv_8_5_sorted,[],@std);
Vtke_lconv_8_5_mean = accumarray(idx(:),Vtke_lconv_8_5_ALL_sorted,[],@mean);
valid_idx_lconv_8_5 = find(spd_lconv_8_5_mean > 0);

[spd_lconv_10_sorted(:, 1), spd_lconv_10_sorted_order] = sort(spd_lconv_10_ALL);
Vtke_lconv_10_ALL_sorted(:, 1) = Vtke_lconv_10_ALL(spd_lconv_10_sorted_order, 1);
TKE_lconv_10_ALL_sorted(:, 1) = TKE_lconv_10_ALL(spd_lconv_10_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_lconv_10_sorted, 0:0.25:ceil(max(spd_lconv_10_sorted)));        % Can't be fucked, just going to use histc
spd_lconv_10_mean = accumarray(idx(:),spd_lconv_10_sorted,[],@mean);
spd_lconv_10_std = accumarray(idx(:),spd_lconv_10_sorted,[],@std);
Vtke_lconv_10_mean = accumarray(idx(:),Vtke_lconv_10_ALL_sorted,[],@mean);
valid_idx_lconv_10 = find(spd_lconv_10_mean > 0);

[spd_lconv_15_sorted(:, 1), spd_lconv_15_sorted_order] = sort(spd_lconv_15_ALL);
Vtke_lconv_15_ALL_sorted(:, 1) = Vtke_lconv_15_ALL(spd_lconv_15_sorted_order, 1);
TKE_lconv_15_ALL_sorted(:, 1) = TKE_lconv_15_ALL(spd_lconv_15_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_lconv_15_sorted, 0:0.25:ceil(max(spd_lconv_15_sorted)));        % Can't be fucked, just going to use histc
spd_lconv_15_mean = accumarray(idx(:),spd_lconv_15_sorted,[],@mean);
spd_lconv_15_std = accumarray(idx(:),spd_lconv_15_sorted,[],@std);
Vtke_lconv_15_mean = accumarray(idx(:),Vtke_lconv_15_ALL_sorted,[],@mean);
valid_idx_lconv_15 = find(spd_lconv_15_mean > 0);

[spd_lconv_20_sorted(:, 1), spd_lconv_20_sorted_order] = sort(spd_lconv_20_ALL);
Vtke_lconv_20_ALL_sorted(:, 1) = Vtke_lconv_20_ALL(spd_lconv_20_sorted_order, 1);
TKE_lconv_20_ALL_sorted(:, 1) = TKE_lconv_20_ALL(spd_lconv_20_sorted_order, 1);

% Find speed mean and std
[~, idx] = histc(spd_lconv_20_sorted, 0:0.25:ceil(max(spd_lconv_20_sorted)));        % Can't be fucked, just going to use histc
spd_lconv_20_mean = accumarray(idx(:),spd_lconv_20_sorted,[],@mean);
spd_lconv_20_std = accumarray(idx(:),spd_lconv_20_sorted,[],@std);
Vtke_lconv_20_mean = accumarray(idx(:),Vtke_lconv_20_ALL_sorted,[],@mean);
valid_idx_lconv_20 = find(spd_lconv_20_mean > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
errorbar(spd_init_1_5_mean(valid_idx_init_1_5), Vtke_init_1_5_mean(valid_idx_init_1_5), spd_init_1_5_std(valid_idx_init_1_5))
hold on
errorbar(spd_init_3_mean(valid_idx_init_3), Vtke_init_3_mean(valid_idx_init_3), spd_init_3_std(valid_idx_init_3))
hold on
errorbar(spd_init_4_5_mean(valid_idx_init_4_5), Vtke_init_4_5_mean(valid_idx_init_4_5), spd_init_4_5_std(valid_idx_init_4_5))
hold on
errorbar(spd_init_6_mean(valid_idx_init_6), Vtke_init_6_mean(valid_idx_init_6), spd_init_6_std(valid_idx_init_6))
hold on
errorbar(spd_init_10_mean(valid_idx_init_10), Vtke_init_10_mean(valid_idx_init_10), spd_init_10_std(valid_idx_init_10))
hold off
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title(strcat('Initiation Tower Binned Data'))
%legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m');
set(tempLegend, 'Location', 'best')
%set(gcf,'PaperSize',[40 20])
print(gcf, strcat('one_init_bin.png'), '-dpng','-r1000');
movefile(strcat( 'one_init_bin.png'), strcat('Jielun', filesep, 'one_init_bin.png'));



figure
errorbar(spd_rel_1_5_mean(valid_idx_rel_1_5), Vtke_rel_1_5_mean(valid_idx_rel_1_5), spd_rel_1_5_std(valid_idx_rel_1_5))
hold on
errorbar(spd_rel_3_mean(valid_idx_rel_3), Vtke_rel_3_mean(valid_idx_rel_3), spd_rel_3_std(valid_idx_rel_3))
hold on
errorbar(spd_rel_4_5_mean(valid_idx_rel_4_5), Vtke_rel_4_5_mean(valid_idx_rel_4_5), spd_rel_4_5_std(valid_idx_rel_4_5))
hold on
errorbar(spd_rel_6_mean(valid_idx_rel_6), Vtke_rel_6_mean(valid_idx_rel_6), spd_rel_6_std(valid_idx_rel_6))
hold on
errorbar(spd_rel_8_5_mean(valid_idx_rel_8_5), Vtke_rel_8_5_mean(valid_idx_rel_8_5), spd_rel_8_5_std(valid_idx_rel_8_5))
hold on
errorbar(spd_rel_10_mean(valid_idx_rel_10), Vtke_rel_10_mean(valid_idx_rel_10), spd_rel_10_std(valid_idx_rel_10))
hold on
errorbar(spd_rel_15_mean(valid_idx_rel_15), Vtke_rel_15_mean(valid_idx_rel_15), spd_rel_15_std(valid_idx_rel_15))
hold on
errorbar(spd_rel_20_mean(valid_idx_rel_20), Vtke_rel_20_mean(valid_idx_rel_20), spd_rel_20_std(valid_idx_rel_20))
hold off
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title(strcat('Release Tower Binned Data'))
%legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '8.5m', '10.0m', '15.0m', '20.0m');
set(tempLegend, 'Location', 'best')
%set(gcf,'PaperSize',[40 20])
print(gcf, strcat('one_rel_bin.png'), '-dpng','-r1000');
movefile(strcat( 'one_rel_bin.png'), strcat('Jielun', filesep, 'one_rel_bin.png'));



figure
errorbar(spd_uconv_1_5_mean(valid_idx_uconv_1_5), Vtke_uconv_1_5_mean(valid_idx_uconv_1_5), spd_uconv_1_5_std(valid_idx_uconv_1_5))
hold on
errorbar(spd_uconv_3_mean(valid_idx_uconv_3), Vtke_uconv_3_mean(valid_idx_uconv_3), spd_uconv_3_std(valid_idx_uconv_3))
hold on
errorbar(spd_uconv_4_5_mean(valid_idx_uconv_4_5), Vtke_uconv_4_5_mean(valid_idx_uconv_4_5), spd_uconv_4_5_std(valid_idx_uconv_4_5))
hold on
errorbar(spd_uconv_6_mean(valid_idx_uconv_6), Vtke_uconv_6_mean(valid_idx_uconv_6), spd_uconv_6_std(valid_idx_uconv_6))
hold on
errorbar(spd_uconv_10_mean(valid_idx_uconv_10), Vtke_uconv_10_mean(valid_idx_uconv_10), spd_uconv_10_std(valid_idx_uconv_10))
hold off
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title(strcat('Upper Convergence Tower Binned Data'))
%legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m');
set(tempLegend, 'Location', 'best')
%set(gcf,'PaperSize',[40 20])
print(gcf, strcat('one_uconv_bin.png'), '-dpng','-r1000');
movefile(strcat( 'one_uconv_bin.png'), strcat('Jielun', filesep, 'one_uconv_bin.png'));


figure
errorbar(spd_lconv_1_5_mean(valid_idx_lconv_1_5), Vtke_lconv_1_5_mean(valid_idx_lconv_1_5), spd_lconv_1_5_std(valid_idx_lconv_1_5))
hold on
errorbar(spd_lconv_3_mean(valid_idx_lconv_3), Vtke_lconv_3_mean(valid_idx_lconv_3), spd_lconv_3_std(valid_idx_lconv_3))
hold on
errorbar(spd_lconv_4_5_mean(valid_idx_lconv_4_5), Vtke_lconv_4_5_mean(valid_idx_lconv_4_5), spd_lconv_4_5_std(valid_idx_lconv_4_5))
hold on
errorbar(spd_lconv_6_mean(valid_idx_lconv_6), Vtke_lconv_6_mean(valid_idx_lconv_6), spd_lconv_6_std(valid_idx_lconv_6))
hold on
errorbar(spd_lconv_8_5_mean(valid_idx_lconv_8_5), Vtke_lconv_8_5_mean(valid_idx_lconv_8_5), spd_lconv_8_5_std(valid_idx_lconv_8_5))
hold on
errorbar(spd_lconv_10_mean(valid_idx_lconv_10), Vtke_lconv_10_mean(valid_idx_lconv_10), spd_lconv_10_std(valid_idx_lconv_10))
hold on
errorbar(spd_lconv_15_mean(valid_idx_lconv_15), Vtke_lconv_15_mean(valid_idx_lconv_15), spd_lconv_15_std(valid_idx_lconv_15))
hold on
errorbar(spd_lconv_20_mean(valid_idx_lconv_20), Vtke_lconv_20_mean(valid_idx_lconv_20), spd_lconv_20_std(valid_idx_lconv_20))
hold off
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title(strcat('Lower Convergence Tower Binned Data'))
%legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '8.5m', '10.0m', '15.0m', '20.0m');
set(tempLegend, 'Location', 'best')
%set(gcf,'PaperSize',[40 20])
print(gcf, strcat('one_lconv_bin.png'), '-dpng','-r1000');
movefile(strcat( 'one_lconv_bin.png'), strcat('Jielun', filesep, 'one_lconv_bin.png'));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot it
figure
subplot(3, 2, 1)
scatter(spd_init_1_5_ALL, Vtke_init_1_5_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('1.5m')
subplot(3, 2, 2)
scatter(spd_init_3_ALL, Vtke_init_3_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('3.0m')
subplot(3, 2, 3)
scatter(spd_init_4_5_ALL, Vtke_init_4_5_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('4.5m')
subplot(3, 2, 4)
scatter(spd_init_6_ALL, Vtke_init_6_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('6.0m')
subplot(3, 2, 5)
scatter(spd_init_10_ALL, Vtke_init_10_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('10.0m')
%set(gcf,'PaperSize',[40 20])
sgtitle('Initation Tower Per Height')
print(gcf, strcat( 'all_init'), '-dpdf','-fillpage');
movefile(strcat( 'all_init.pdf'), strcat('Jielun', filesep, 'all_init.pdf'));

figure
scatter(spd_init_1_5_ALL, Vtke_init_1_5_ALL, 'r*');
hold on
scatter(spd_init_3_ALL, Vtke_init_3_ALL, 'g*');
hold on
scatter(spd_init_4_5_ALL, Vtke_init_4_5_ALL, 'b*');
hold on
scatter(spd_init_6_ALL, Vtke_init_6_ALL, 'c*');
hold on
scatter(spd_init_10_ALL, Vtke_init_10_ALL, 'MarkerEdgeColor', c.gl, 'Marker', '*');
hold off
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title(strcat(' Initiation Convergence Tower Data'))
%legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m');
set(tempLegend, 'Location', 'best')
%set(gcf,'PaperSize',[40 20])
print(gcf, strcat('one_init_ALL.png'), '-dpng','-r1000');
movefile(strcat( 'one_init_ALL.png'), strcat('Jielun', filesep, 'one_init_ALL.png'));

figure
subplot(4, 2, 1)
scatter(spd_rel_1_5_ALL, Vtke_rel_1_5_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('1.5m')
subplot(4, 2, 2)
scatter(spd_rel_3_ALL, Vtke_rel_3_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('3.0m')
subplot(4, 2, 3)
scatter(spd_rel_4_5_ALL, Vtke_rel_4_5_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('4.5m')
subplot(4, 2, 4)
scatter(spd_rel_6_ALL, Vtke_rel_6_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('6.0m')
subplot(4, 2, 5)
scatter(spd_rel_8_5_ALL, Vtke_rel_8_5_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('8.5m')
subplot(4, 2, 6)
scatter(spd_rel_10_ALL, Vtke_rel_10_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('10.0m')
subplot(4, 2, 7)
scatter(spd_rel_15_ALL, Vtke_rel_15_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('15.0m')
subplot(4, 2, 8)
scatter(spd_rel_20_ALL, Vtke_rel_20_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('20.0m')
%set(gcf,'PaperSize',[40 20])
sgtitle('Release Tower Per Height')
print(gcf, strcat( 'all_rel'), '-dpdf','-fillpage');
movefile(strcat( 'all_rel.pdf'), strcat('Jielun', filesep, 'all_rel.pdf'));

figure
scatter(spd_rel_1_5_ALL, Vtke_rel_1_5_ALL, 'r*');
hold on
scatter(spd_rel_3_ALL, Vtke_rel_3_ALL, 'g*');
hold on
scatter(spd_rel_4_5_ALL, Vtke_rel_4_5_ALL, 'b*');
hold on
scatter(spd_rel_6_ALL, Vtke_rel_6_ALL, 'c*');
hold on
scatter(spd_rel_8_5_ALL, Vtke_rel_8_5_ALL, 'k*');
hold on
scatter(spd_rel_10_ALL, Vtke_rel_10_ALL, 'MarkerEdgeColor', c.gl, 'Marker', '*');
hold on
scatter(spd_rel_15_ALL, Vtke_rel_15_ALL, 'MarkerEdgeColor', c.um, 'Marker', '*');
hold on
scatter(spd_rel_20_ALL, Vtke_rel_20_ALL, 'MarkerEdgeColor', c.br, 'Marker', '*');
hold off
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title(strcat(' Release Tower Universal Data'))
%legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '8.5m', '10.0m', '15.0m', '20.0m');
set(tempLegend, 'Location', 'best')
%set(gcf,'PaperSize',[40 20])
print(gcf, strcat('one_rel_ALL.png'), '-dpng','-r1000');
movefile(strcat( 'one_rel_ALL.png'), strcat('Jielun', filesep, 'one_rel_ALL.png'));

% Plot it
figure
subplot(3, 2, 1)
scatter(spd_uconv_1_5_ALL, Vtke_uconv_1_5_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('1.5m')
subplot(3, 2, 2)
scatter(spd_uconv_3_ALL, Vtke_uconv_3_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('3.0m')
subplot(3, 2, 3)
scatter(spd_uconv_4_5_ALL, Vtke_uconv_4_5_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('4.5m')
subplot(3, 2, 4)
scatter(spd_uconv_6_ALL, Vtke_uconv_6_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('6.0m')
subplot(3, 2, 5)
scatter(spd_uconv_10_ALL, Vtke_uconv_10_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('10.0m')
%set(gcf,'PaperSize',[40 20])
sgtitle('Upper Convergence Tower Per Height')
print(gcf, strcat( 'all_uconv'), '-dpdf','-fillpage');
movefile(strcat( 'all_uconv.pdf'), strcat('Jielun', filesep, 'all_uconv.pdf'));

figure
scatter(spd_uconv_1_5_ALL, Vtke_uconv_1_5_ALL, 'r*');
hold on
scatter(spd_uconv_3_ALL, Vtke_uconv_3_ALL, 'g*');
hold on
scatter(spd_uconv_4_5_ALL, Vtke_uconv_4_5_ALL, 'b*');
hold on
scatter(spd_uconv_6_ALL, Vtke_uconv_6_ALL, 'c*');
hold on
scatter(spd_uconv_10_ALL, Vtke_uconv_10_ALL, 'MarkerEdgeColor', c.gl, 'Marker', '*');
hold off
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title(strcat(' Upper Convergence Tower Data'))
%legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m');
set(tempLegend, 'Location', 'best')
%set(gcf,'PaperSize',[40 20])
print(gcf, strcat('one_uconv_ALL.png'), '-dpng','-r1000');
movefile(strcat( 'one_uconv_ALL.png'), strcat('Jielun', filesep, 'one_uconv_ALL.png'));

figure
subplot(4, 2, 1)
scatter(spd_lconv_1_5_ALL, Vtke_lconv_1_5_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('1.5m')
subplot(4, 2, 2)
scatter(spd_lconv_3_ALL, Vtke_lconv_3_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('3.0m')
subplot(4, 2, 3)
scatter(spd_lconv_4_5_ALL, Vtke_lconv_4_5_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('4.5m')
subplot(4, 2, 4)
scatter(spd_lconv_6_ALL, Vtke_lconv_6_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('6.0m')
subplot(4, 2, 5)
scatter(spd_lconv_8_5_ALL, Vtke_lconv_8_5_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('8.5m')
subplot(4, 2, 6)
scatter(spd_lconv_10_ALL, Vtke_lconv_10_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('10.0m')
subplot(4, 2, 7)
scatter(spd_lconv_15_ALL, Vtke_lconv_15_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('15.0m')
subplot(4, 2, 8)
scatter(spd_lconv_20_ALL, Vtke_lconv_20_ALL)
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title('20.0m')
%set(gcf,'PaperSize',[40 20])
sgtitle('Lower Convergence Tower Per Height')
print(gcf, strcat( 'all_lconv'), '-dpdf','-fillpage');
movefile(strcat('all_lconv.pdf'), strcat('Jielun', filesep, 'all_lconv.pdf'));

figure
scatter(spd_lconv_1_5_ALL, Vtke_lconv_1_5_ALL, 'r*');
hold on
scatter(spd_lconv_3_ALL, Vtke_lconv_3_ALL, 'g*');
hold on
scatter(spd_lconv_4_5_ALL, Vtke_lconv_4_5_ALL, 'b*');
hold on
scatter(spd_lconv_6_ALL, Vtke_lconv_6_ALL, 'c*');
hold on
scatter(spd_lconv_8_5_ALL, Vtke_lconv_8_5_ALL, 'k*');
hold on
scatter(spd_lconv_10_ALL, Vtke_lconv_10_ALL, 'MarkerEdgeColor', c.gl, 'Marker', '*');
hold on
scatter(spd_lconv_15_ALL, Vtke_lconv_15_ALL, 'MarkerEdgeColor', c.um, 'Marker', '*');
hold on
scatter(spd_lconv_20_ALL, Vtke_lconv_20_ALL, 'MarkerEdgeColor', c.br, 'Marker', '*');
hold off
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title(strcat(' Lower Convergence Tower Data'))
%legend('1.5m', '3.0m', '4.5m', '6.0m', '10.0m', '15.0m', '20.0m')
tempLegend = legend('1.5m', '3.0m', '4.5m', '6.0m', '8.5m', '10.0m', '15.0m', '20.0m');
set(tempLegend, 'Location', 'best')
%set(gcf,'PaperSize',[40 20])
print(gcf, strcat( 'one_lconv_ALL.png'), '-dpng','-r1000');
movefile(strcat('one_lconv_ALL.png'), strcat('Jielun', filesep, 'one_lconv_ALL.png'));

% Now all in one mug shot?
figure
scatter(spd_init_1_5_ALL, Vtke_init_1_5_ALL, 'r*');
hold on
scatter(spd_init_3_ALL, Vtke_init_3_ALL, 'g*');
hold on
scatter(spd_init_4_5_ALL, Vtke_init_4_5_ALL, 'b*');
hold on
scatter(spd_init_6_ALL, Vtke_init_6_ALL, 'c*');
hold on
scatter(spd_init_10_ALL, Vtke_init_10_ALL, 'MarkerEdgeColor', c.gl, 'Marker', '*');
hold on
scatter(spd_rel_1_5_ALL, Vtke_rel_1_5_ALL, 'r*');
hold on
scatter(spd_rel_3_ALL, Vtke_rel_3_ALL, 'g*');
hold on
scatter(spd_rel_4_5_ALL, Vtke_rel_4_5_ALL, 'b*');
hold on
scatter(spd_rel_6_ALL, Vtke_rel_6_ALL, 'c*');
hold on
scatter(spd_rel_8_5_ALL, Vtke_rel_8_5_ALL, 'k*');
hold on
scatter(spd_rel_10_ALL, Vtke_rel_10_ALL, 'MarkerEdgeColor', c.gl, 'Marker', '*');
hold on
scatter(spd_rel_15_ALL, Vtke_rel_15_ALL, 'MarkerEdgeColor', c.um, 'Marker', '*');
hold on
scatter(spd_rel_20_ALL, Vtke_rel_20_ALL, 'MarkerEdgeColor', c.br, 'Marker', '*');
hold on
scatter(spd_uconv_1_5_ALL, Vtke_uconv_1_5_ALL, 'r*');
hold on
scatter(spd_uconv_3_ALL, Vtke_uconv_3_ALL, 'g*');
hold on
scatter(spd_uconv_4_5_ALL, Vtke_uconv_4_5_ALL, 'b*');
hold on
scatter(spd_uconv_6_ALL, Vtke_uconv_6_ALL, 'c*');
hold on
scatter(spd_uconv_10_ALL, Vtke_uconv_10_ALL, 'MarkerEdgeColor', c.gl, 'Marker', '*');
hold on
scatter(spd_lconv_1_5_ALL, Vtke_lconv_1_5_ALL, 'r*');
hold on
scatter(spd_lconv_3_ALL, Vtke_lconv_3_ALL, 'g*');
hold on
scatter(spd_lconv_4_5_ALL, Vtke_lconv_4_5_ALL, 'b*');
hold on
scatter(spd_lconv_6_ALL, Vtke_lconv_6_ALL, 'c*');
hold on
scatter(spd_lconv_8_5_ALL, Vtke_lconv_8_5_ALL, 'k*');
hold on
scatter(spd_lconv_10_ALL, Vtke_lconv_10_ALL, 'MarkerEdgeColor', c.gl, 'Marker', '*');
hold on
scatter(spd_lconv_15_ALL, Vtke_lconv_15_ALL, 'MarkerEdgeColor', c.um, 'Marker', '*');
hold on
scatter(spd_lconv_20_ALL, Vtke_lconv_20_ALL, 'MarkerEdgeColor', c.br, 'Marker', '*');
hold off
xlabel('Wind Speed (m/s)')
ylabel('V tke')
title(strcat('All Tower Data'))
print(gcf, strcat( 'universal.png'), '-dpng','-r1000');
movefile(strcat('universal.png'), strcat('Jielun', filesep, 'universal.png'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now print out the stats
errmsg('cyan', '=======================================================================================\n');
errmsg('black', '\n');
errmsg('cyan', 'Overall valid data counts:\n');
errmsg('black', '\n');
errmsg('red', 'For initiation tower:\n');
errmsg('red', '------------------------------------------------------------------------\n');
errmsg('red', '|    Speed    | Temperature |  Direction   | Total Count |  Universal  |\n');
errmsg('red', '------------------------------------------------------------------------\n');
errmsg('red', '|  %7d    |  %7d    |   %7d    |  %7d    |  %7d    |\n', init_count(1)*6, init_count(2)*4, init_count(3)*6, init_count(1)*6 + init_count(2)*4 + init_count(3)*6, 144 * length(date_dict)*(6+4+6));
errmsg('red', '------------------------------------------------------------------------\n');
errmsg('black', '\n');
errmsg('black', 'For release tower:\n');
errmsg('black', '------------------------------------------------------------------------\n');
errmsg('black', '|    Speed    | Temperature |  Direction   | Total Count |  Universal  |\n');
errmsg('black', '------------------------------------------------------------------------\n');
errmsg('black', '|  %7d    |  %7d    |   %7d    |  %7d    |  %7d    |\n', rel_count(1)*9, rel_count(2)*6, rel_count(3)*9, rel_count(1)*9 + rel_count(2)*6 + rel_count(3)*9, 144 * length(date_dict)*(9+6+9));
errmsg('black', '------------------------------------------------------------------------\n');
errmsg('black', '\n');
errmsg('blue', 'For upper convergence tower:\n');
errmsg('blue', '------------------------------------------------------------------------\n');
errmsg('blue', '|    Speed    | Temperature |  Direction   | Total Count |  Universal  |\n');
errmsg('blue', '------------------------------------------------------------------------\n');
errmsg('blue', '|  %7d    |  %7d    |   %7d    |  %7d    |  %7d    |\n', uconv_count(1)*6, uconv_count(2)*4, uconv_count(3)*6, uconv_count(1)*6 + uconv_count(2)*4 + uconv_count(3)*6, 144 * length(date_dict)*(6+4+6));
errmsg('blue', '------------------------------------------------------------------------\n');
errmsg('black', '\n');
errmsg('magenta', 'For lower convergence tower:\n');
errmsg('magenta', '------------------------------------------------------------------------\n');
errmsg('magenta', '|    Speed    | Temperature |  Direction   | Total Count |  Universal  |\n');
errmsg('magenta', '------------------------------------------------------------------------\n');
errmsg('magenta', '|  %7d    |  %7d    |   %7d    |  %7d    |  %7d    |\n', lconv_count(1)*9, lconv_count(2)*6, lconv_count(3)*9, lconv_count(1)*9 + lconv_count(2)*6 + lconv_count(3)*9, 144 * length(date_dict)*(9+6+9));
errmsg('magenta', '------------------------------------------------------------------------\n');
errmsg('cyan', '=======================================================================================\n');
