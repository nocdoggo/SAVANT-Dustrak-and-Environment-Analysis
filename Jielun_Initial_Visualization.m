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
c = struct('A', [0.9047, 0.1918, 0.1988], ...  %Your required color
    'B', [0,      1,      1     ], ... %Your required color
    'C', [0.0824, 0.1294, 0.4196], ... %ultra marine
    'D', [0.6510, 0.5725, 0.3412], ... %bronze
    'E', [1.0000, 0,      1.0000], ... %magenta
    'F', [0.4660, 0.6740, 0.1880], ... %'#77AC30'
    'G', [176/256,195/256,222/256],... %light steel blue
    'H', [75/256, 0,      130/256],... %indigo
    'I', [0.8314, 0.7020, 0.7843] );   %greyed lavender
names = 'ABCDEFGHI';    % I know this way is retard

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

daterange = 1018;
% Nic = [925:930];
% Nic = [Nic, 1001:1031];

%for daterange = Nic
if daterange > 1000
    targetDate = num2str(daterange);
    dateStamp = str2double(targetDate);
else
    targetDate = num2str(daterange);
    dateStamp = str2double(targetDate);
    targetDate = strcat('0', targetDate);
end

if daterange == 1001
    preDate = '0930';
elseif daterange == 1101
    preDate = '1031';
else
    preDate = num2str(daterange - 1);
end

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
    
    % Figure out the size of the file and the mid point
    % I know the way is stupid due to the CDT time list is over 2 days
    % So the stupid thing can collapse when you plot
    varStartIdx = 1;
    
    MidPoint = '23:57:30';
    [varMidLog, varMidIdx] = ismember(MidPoint, CDT_Time);
    
    [varEndIdx, whateveritis] = size(speedTable{:,1});
    
    % Initiation tower
    %     [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5] = Jielun_TKE(windTable{varStartIdx:varMidIdx, 213}, windTable{varStartIdx:varMidIdx, 243}, windTable{varStartIdx:varMidIdx, 273}, speedTable{varStartIdx:varMidIdx, 4});
    %     [Vtke_init_3, TKE_init_3, spd_init_3] = Jielun_TKE(windTable{varStartIdx:varMidIdx, 214}, windTable{varStartIdx:varMidIdx, 244}, windTable{varStartIdx:varMidIdx, 274}, speedTable{varStartIdx:varMidIdx, 5});
    %     [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5] = Jielun_TKE(windTable{varStartIdx:varMidIdx, 215}, windTable{varStartIdx:varMidIdx, 245}, windTable{varStartIdx:varMidIdx, 275}, speedTable{varStartIdx:varMidIdx, 6});
    %     [Vtke_init_6, TKE_init_6, spd_init_6] = Jielun_TKE(windTable{varStartIdx:varMidIdx, 216}, windTable{varStartIdx:varMidIdx, 246}, windTable{varStartIdx:varMidIdx, 276}, speedTable{varStartIdx:varMidIdx, 7});
    %     [Vtke_init_10, TKE_init_10, spd_init_10] = Jielun_TKE(windTable{varStartIdx:varMidIdx, 217}, windTable{varStartIdx:varMidIdx, 247}, windTable{varStartIdx:varMidIdx, 277}, speedTable{varStartIdx:varMidIdx, 8});
    %
    %
    %     [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5] = Jielun_TKE(windTable{(varMidIdx + 1):varEndIdx, 213}, windTable{(varMidIdx + 1):varEndIdx, 243}, windTable{(varMidIdx + 1):varEndIdx, 273}, speedTable{(varMidIdx + 1):varEndIdx, 4});
    %     [Vtke_init_3, TKE_init_3, spd_init_3] = Jielun_TKE(windTable{(varMidIdx + 1):varEndIdx, 214}, windTable{(varMidIdx + 1):varEndIdx, 244}, windTable{(varMidIdx + 1):varEndIdx, 274}, speedTable{(varMidIdx + 1):varEndIdx, 5});
    %     [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5] = Jielun_TKE(windTable{(varMidIdx + 1):varEndIdx, 215}, windTable{(varMidIdx + 1):varEndIdx, 245}, windTable{(varMidIdx + 1):varEndIdx, 275}, speedTable{(varMidIdx + 1):varEndIdx, 6});
    %     [Vtke_init_6, TKE_init_6, spd_init_6] = Jielun_TKE(windTable{(varMidIdx + 1):varEndIdx, 216}, windTable{(varMidIdx + 1):varEndIdx, 246}, windTable{(varMidIdx + 1):varEndIdx, 276}, speedTable{(varMidIdx + 1):varEndIdx, 7});
    %     [Vtke_init_10, TKE_init_10, spd_init_10] = Jielun_TKE(windTable{(varMidIdx + 1):varEndIdx, 217}, windTable{(varMidIdx + 1):varEndIdx, 247}, windTable{(varMidIdx + 1):varEndIdx, 277}, speedTable{(varMidIdx + 1):varEndIdx, 8});
    
    % Check on the V versus Z plot
    spd_0_2m_init_A = speedTable{varStartIdx:varMidIdx, 3};
    spd_1_5m_init_A = speedTable{varStartIdx:varMidIdx, 4};
    spd_3m_init_A = speedTable{varStartIdx:varMidIdx, 5};
    spd_4_5m_init_A = speedTable{varStartIdx:varMidIdx, 6};
    spd_6m_init_A = speedTable{varStartIdx:varMidIdx, 7};
    spd_10m_init_A = speedTable{varStartIdx:varMidIdx, 8};
    
    dspd_0_85m_init_A = (spd_1_5m_init_A - spd_0_2m_init_A) / (1.5 - 0.2);
    dspd_2_25m_init_A = (spd_3m_init_A - spd_1_5m_init_A) / (3 - 1.5);
    dspd_3_75m_init_A = (spd_4_5m_init_A - spd_3m_init_A) / (4.5 - 3);
    dspd_5_25m_init_A = (spd_6m_init_A - spd_4_5m_init_A) / (6 - 4.5);
    dspd_8m_init_A = (spd_10m_init_A - spd_6m_init_A) / (10 - 6);
    
    spd_0_2m_init_B = speedTable{(varMidIdx+1):varEndIdx, 3};
    spd_1_5m_init_B = speedTable{(varMidIdx+1):varEndIdx, 4};
    spd_3m_init_B = speedTable{(varMidIdx+1):varEndIdx, 5};
    spd_4_5m_init_B = speedTable{(varMidIdx+1):varEndIdx, 6};
    spd_6m_init_B = speedTable{(varMidIdx+1):varEndIdx, 7};
    spd_10m_init_B = speedTable{(varMidIdx+1):varEndIdx, 8};
    
    dspd_0_85m_init_B = (spd_1_5m_init_B - spd_0_2m_init_B) / (1.5 - 0.2);
    dspd_2_25m_init_B = (spd_3m_init_B - spd_1_5m_init_B) / (3 - 1.5);
    dspd_3_75m_init_B = (spd_4_5m_init_B - spd_3m_init_B) / (4.5 - 3);
    dspd_5_25m_init_B = (spd_6m_init_B - spd_4_5m_init_B) / (6 - 4.5);
    dspd_8m_init_B = (spd_10m_init_B - spd_6m_init_B) / (10 - 6);
    
    vtemp_1_5m_init_A = windTable{varStartIdx:varMidIdx, 153};
    vtemp_3m_init_A = windTable{varStartIdx:varMidIdx, 154};
    vtemp_4_5m_init_A = windTable{varStartIdx:varMidIdx, 155};
    vtemp_6m_init_A = windTable{varStartIdx:varMidIdx, 156};
    vtemp_10m_init_A = windTable{varStartIdx:varMidIdx, 157};
    
    dvtemp_2_25m_init_A = (vtemp_3m_init_A - vtemp_1_5m_init_A) / (3 - 1.5);
    dvtemp_3_75m_init_A = (vtemp_4_5m_init_A - vtemp_3m_init_A) / (4.5 - 3);
    dvtemp_5_25m_init_A = (vtemp_6m_init_A - vtemp_4_5m_init_A) / (6 - 4.5);
    dvtemp_8m_init_A = (vtemp_10m_init_A - vtemp_6m_init_A) / (10 - 6);
    
    vtemp_1_5m_init_B = windTable{(varMidIdx+1):varEndIdx, 153};
    vtemp_3m_init_B = windTable{(varMidIdx+1):varEndIdx, 154};
    vtemp_4_5m_init_B = windTable{(varMidIdx+1):varEndIdx, 155};
    vtemp_6m_init_B = windTable{(varMidIdx+1):varEndIdx, 156};
    vtemp_10m_init_B = windTable{(varMidIdx+1):varEndIdx, 157};
    
    dvtemp_2_25m_init_B = (vtemp_3m_init_B - vtemp_1_5m_init_B) / (3 - 1.5);
    dvtemp_3_75m_init_B = (vtemp_4_5m_init_B - vtemp_3m_init_B) / (4.5 - 3);
    dvtemp_5_25m_init_B = (vtemp_6m_init_B - vtemp_4_5m_init_B) / (6 - 4.5);
    dvtemp_8m_init_B = (vtemp_10m_init_B - vtemp_6m_init_B) / (10 - 6);
    
    
    spd_0_2m_uconv_A = speedTable{varStartIdx:varMidIdx, 17};
    spd_1_5m_uconv_A = speedTable{varStartIdx:varMidIdx, 18};
    spd_3m_uconv_A = speedTable{varStartIdx:varMidIdx, 19};
    spd_4_5m_uconv_A = speedTable{varStartIdx:varMidIdx, 20};
    spd_6m_uconv_A = speedTable{varStartIdx:varMidIdx, 21};
    spd_10m_uconv_A = speedTable{varStartIdx:varMidIdx, 22};
    
    dspd_0_85m_uconv_A = (spd_1_5m_uconv_A - spd_0_2m_uconv_A) / (1.5 - 0.2);
    dspd_2_25m_uconv_A = (spd_3m_uconv_A - spd_1_5m_uconv_A) / (3 - 1.5);
    dspd_3_75m_uconv_A = (spd_4_5m_uconv_A - spd_3m_uconv_A) / (4.5 - 3);
    dspd_5_25m_uconv_A = (spd_6m_uconv_A - spd_4_5m_uconv_A) / (6 - 4.5);
    dspd_8m_uconv_A = (spd_10m_uconv_A - spd_6m_uconv_A) / (10 - 6);
    
    spd_0_2m_uconv_B = speedTable{(varMidIdx+1):varEndIdx, 17};
    spd_1_5m_uconv_B = speedTable{(varMidIdx+1):varEndIdx, 18};
    spd_3m_uconv_B = speedTable{(varMidIdx+1):varEndIdx, 19};
    spd_4_5m_uconv_B = speedTable{(varMidIdx+1):varEndIdx, 20};
    spd_6m_uconv_B = speedTable{(varMidIdx+1):varEndIdx, 21};
    spd_10m_uconv_B = speedTable{(varMidIdx+1):varEndIdx, 22};
    
    dspd_0_85m_uconv_B = (spd_1_5m_uconv_B - spd_0_2m_uconv_B) / (1.5 - 0.2);
    dspd_2_25m_uconv_B = (spd_3m_uconv_B - spd_1_5m_uconv_B) / (3 - 1.5);
    dspd_3_75m_uconv_B = (spd_4_5m_uconv_B - spd_3m_uconv_B) / (4.5 - 3);
    dspd_5_25m_uconv_B = (spd_6m_uconv_B - spd_4_5m_uconv_B) / (6 - 4.5);
    dspd_8m_uconv_B = (spd_10m_uconv_B - spd_6m_uconv_B) / (10 - 6);
    
    vtemp_1_5m_uconv_A = windTable{varStartIdx:varMidIdx, 48};
    vtemp_3m_uconv_A = windTable{varStartIdx:varMidIdx, 49};
    vtemp_4_5m_uconv_A = windTable{varStartIdx:varMidIdx, 50};
    vtemp_6m_uconv_A = windTable{varStartIdx:varMidIdx, 51};
    vtemp_10m_uconv_A = windTable{varStartIdx:varMidIdx, 52};
    
    dvtemp_2_25m_uconv_A = (vtemp_3m_uconv_A - vtemp_1_5m_uconv_A) / (3 - 1.5);
    dvtemp_3_75m_uconv_A = (vtemp_4_5m_uconv_A - vtemp_3m_uconv_A) / (4.5 - 3);
    dvtemp_5_25m_uconv_A = (vtemp_6m_uconv_A - vtemp_4_5m_uconv_A) / (6 - 4.5);
    dvtemp_8m_uconv_A = (vtemp_10m_uconv_A - vtemp_6m_uconv_A) / (10 - 6);
    
    vtemp_1_5m_uconv_B = windTable{(varMidIdx+1):varEndIdx, 48};
    vtemp_3m_uconv_B = windTable{(varMidIdx+1):varEndIdx, 49};
    vtemp_4_5m_uconv_B = windTable{(varMidIdx+1):varEndIdx, 50};
    vtemp_6m_uconv_B = windTable{(varMidIdx+1):varEndIdx, 51};
    vtemp_10m_uconv_B = windTable{(varMidIdx+1):varEndIdx, 52};
    
    dvtemp_2_25m_uconv_B = (vtemp_3m_uconv_B - vtemp_1_5m_uconv_B) / (3 - 1.5);
    dvtemp_3_75m_uconv_B = (vtemp_4_5m_uconv_B - vtemp_3m_uconv_B) / (4.5 - 3);
    dvtemp_5_25m_uconv_B = (vtemp_6m_uconv_B - vtemp_4_5m_uconv_B) / (6 - 4.5);
    dvtemp_8m_uconv_B = (vtemp_10m_uconv_B - vtemp_6m_uconv_B) / (10 - 6);
    
    part_A = varMidIdx - varStartIdx + 1;
    part_B = varEndIdx - varMidIdx;
    
    %         % Time series speed at each tower
    %         % 3D Plot
    %         figure
    %
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_0_2m_init_A, 0.2*ones(part_A, 1), 'Color', c.A, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_1_5m_init_A, 1.5*ones(part_A, 1), 'Color', c.B, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_3m_init_A, 3*ones(part_A, 1), 'Color', c.C, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_4_5m_init_A, 4.5*ones(part_A, 1), 'Color', c.D, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_6m_init_A, 6*ones(part_A, 1), 'Color', c.E, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_10m_init_A, 10*ones(part_A, 1), 'Color', c.F, 'Marker', '*')
    %         hold off
    %
    %         % 2D Plot
    %         figure
    %
    %         plot(spd_0_2m_init_A, 0.2*ones(part_A, 1), 'Color', c.A, 'Marker', '*')
    %         hold on
    %         plot(spd_1_5m_init_A, 1.5*ones(part_A, 1), 'Color', c.B, 'Marker', '*')
    %         hold on
    %         plot(spd_3m_init_A, 3*ones(part_A, 1), 'Color', c.C, 'Marker', '*')
    %         hold on
    %         plot(spd_4_5m_init_A, 4.5*ones(part_A, 1), 'Color', c.D, 'Marker', '*')
    %         hold on
    %         plot(spd_6m_init_A, 6*ones(part_A, 1), 'Color', c.E, 'Marker', '*')
    %         hold on
    %         plot(spd_10m_init_A, 10*ones(part_A, 1), 'Color', c.F, 'Marker', '*')
    %         hold off
    %
    %                 % Time series speed at each tower
    %         % 3D Plot
    %         figure
    %
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_0_2m_uconv_A, 0.2*ones(part_A, 1), 'Color', c.A, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_1_5m_uconv_A, 1.5*ones(part_A, 1), 'Color', c.B, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_3m_uconv_A, 3*ones(part_A, 1), 'Color', c.C, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_4_5m_uconv_A, 4.5*ones(part_A, 1), 'Color', c.D, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_6m_uconv_A, 6*ones(part_A, 1), 'Color', c.E, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_10m_uconv_A, 10*ones(part_A, 1), 'Color', c.F, 'Marker', '*')
    %         hold off
    %
    %         % 2D Plot
    %         figure
    %
    %         plot(spd_0_2m_uconv_A, 0.2*ones(part_A, 1), 'Color', c.A, 'Marker', '*')
    %         hold on
    %         plot(spd_1_5m_uconv_A, 1.5*ones(part_A, 1), 'Color', c.B, 'Marker', '*')
    %         hold on
    %         plot(spd_3m_uconv_A, 3*ones(part_A, 1), 'Color', c.C, 'Marker', '*')
    %         hold on
    %         plot(spd_4_5m_uconv_A, 4.5*ones(part_A, 1), 'Color', c.D, 'Marker', '*')
    %         hold on
    %         plot(spd_6m_uconv_A, 6*ones(part_A, 1), 'Color', c.E, 'Marker', '*')
    %         hold on
    %         plot(spd_10m_uconv_A, 10*ones(part_A, 1), 'Color', c.F, 'Marker', '*')
    %         hold off
    
    % Check on the V versus Z plot
    spd_0_2m_rel_A = speedTable{varStartIdx:varMidIdx, 10};
    spd_1_5m_rel_A = speedTable{varStartIdx:varMidIdx, 11};
    spd_3m_rel_A = speedTable{varStartIdx:varMidIdx, 12};
    spd_4_5m_rel_A = speedTable{varStartIdx:varMidIdx, 13};
    spd_6m_rel_A = speedTable{varStartIdx:varMidIdx, 14};
    spd_10m_rel_A = speedTable{varStartIdx:varMidIdx, 15};
    spd_8_5m_rel_A = speedTable{varStartIdx:varMidIdx, 31};
    spd_15m_rel_A = speedTable{varStartIdx:varMidIdx, 33};
    spd_20m_rel_A = speedTable{varStartIdx:varMidIdx, 35};
    
    dspd_0_85m_rel_A = (spd_1_5m_rel_A - spd_0_2m_rel_A) / (1.5 - 0.2);
    dspd_2_25m_rel_A = (spd_3m_rel_A - spd_1_5m_rel_A) / (3 - 1.5);
    dspd_3_75m_rel_A = (spd_4_5m_rel_A - spd_3m_rel_A) / (4.5 - 3);
    dspd_5_25m_rel_A = (spd_6m_rel_A - spd_4_5m_rel_A) / (6 - 4.5);
    dspd_7_25m_rel_A = (spd_8_5m_rel_A - spd_6m_rel_A) / (8.5 - 6);
    dspd_9_25m_rel_A = (spd_10m_rel_A - spd_8_5m_rel_A) / (10 - 8.5);
    dspd_12_5m_rel_A = (spd_15m_rel_A - spd_10m_rel_A) / (15 - 10);
    dspd_17_5m_rel_A = (spd_20m_rel_A - spd_15m_rel_A) / (20 - 15);
    
    spd_0_2m_rel_B = speedTable{(varMidIdx+1):varEndIdx, 10};
    spd_1_5m_rel_B = speedTable{(varMidIdx+1):varEndIdx, 11};
    spd_3m_rel_B = speedTable{(varMidIdx+1):varEndIdx, 12};
    spd_4_5m_rel_B = speedTable{(varMidIdx+1):varEndIdx, 13};
    spd_6m_rel_B = speedTable{(varMidIdx+1):varEndIdx, 14};
    spd_10m_rel_B = speedTable{(varMidIdx+1):varEndIdx, 15};
    spd_8_5m_rel_B = speedTable{(varMidIdx+1):varEndIdx, 31};
    spd_15m_rel_B = speedTable{(varMidIdx+1):varEndIdx, 33};
    spd_20m_rel_B = speedTable{(varMidIdx+1):varEndIdx, 35};
    
    dspd_0_85m_rel_B = (spd_1_5m_rel_B - spd_0_2m_rel_B) / (1.5 - 0.2);
    dspd_2_25m_rel_B = (spd_3m_rel_B - spd_1_5m_rel_B) / (3 - 1.5);
    dspd_3_75m_rel_B = (spd_4_5m_rel_B - spd_3m_rel_B) / (4.5 - 3);
    dspd_5_25m_rel_B = (spd_6m_rel_B - spd_4_5m_rel_B) / (6 - 4.5);
    dspd_7_25m_rel_B = (spd_8_5m_rel_B - spd_6m_rel_B) / (8.5 - 6);
    dspd_9_25m_rel_B = (spd_10m_rel_B - spd_8_5m_rel_B) / (10 - 8.5);
    dspd_12_5m_rel_B = (spd_15m_rel_B - spd_10m_rel_B) / (15 - 10);
    dspd_17_5m_rel_B = (spd_20m_rel_B - spd_15m_rel_B) / (20 - 15);
    
    vtemp_1_5m_rel_A = windTable{varStartIdx:varMidIdx, 164};
    vtemp_3m_rel_A = windTable{varStartIdx:varMidIdx, 165};
    vtemp_4_5m_rel_A = windTable{varStartIdx:varMidIdx, 166};
    vtemp_6m_rel_A = windTable{varStartIdx:varMidIdx, 162};
    vtemp_10m_rel_A = windTable{varStartIdx:varMidIdx, 163};
    vtemp_8_5m_rel_A = windTable{varStartIdx:varMidIdx, 164};
    vtemp_15m_rel_A = windTable{varStartIdx:varMidIdx, 165};
    vtemp_20m_rel_A = windTable{varStartIdx:varMidIdx, 166};
    
    dvtemp_2_25m_rel_A = (vtemp_3m_rel_A - vtemp_1_5m_rel_A) / (3 - 1.5);
    dvtemp_3_75m_rel_A = (vtemp_4_5m_rel_A - vtemp_3m_rel_A) / (4.5 - 3);
    dvtemp_5_25m_rel_A = (vtemp_6m_rel_A - vtemp_4_5m_rel_A) / (6 - 4.5);
    dvtemp_7_25m_rel_A = (vtemp_8_5m_rel_A - vtemp_6m_rel_A) / (8.5 - 6);
    dvtemp_9_25m_rel_A = (vtemp_10m_rel_A - vtemp_8_5m_rel_A) / (10 - 8.5);
    dvtemp_12_5m_rel_A = (vtemp_15m_rel_A - vtemp_10m_rel_A) / (15 - 10);
    dvtemp_17_5m_rel_A = (vtemp_20m_rel_A - vtemp_15m_rel_A) / (20 - 15);
    
    vtemp_1_5m_rel_B = windTable{(varMidIdx+1):varEndIdx, 164};
    vtemp_3m_rel_B = windTable{(varMidIdx+1):varEndIdx, 165};
    vtemp_4_5m_rel_B = windTable{(varMidIdx+1):varEndIdx, 166};
    vtemp_6m_rel_B = windTable{(varMidIdx+1):varEndIdx, 162};
    vtemp_10m_rel_B = windTable{(varMidIdx+1):varEndIdx, 163};
    vtemp_8_5m_rel_B = windTable{(varMidIdx+1):varEndIdx, 164};
    vtemp_15m_rel_B = windTable{(varMidIdx+1):varEndIdx, 165};
    vtemp_20m_rel_B = windTable{(varMidIdx+1):varEndIdx, 166};
    
    dvtemp_2_25m_rel_B = (vtemp_3m_rel_B - vtemp_1_5m_rel_B) / (3 - 1.5);
    dvtemp_3_75m_rel_B = (vtemp_4_5m_rel_B - vtemp_3m_rel_B) / (4.5 - 3);
    dvtemp_5_25m_rel_B = (vtemp_6m_rel_B - vtemp_4_5m_rel_B) / (6 - 4.5);
    dvtemp_7_25m_rel_B = (vtemp_8_5m_rel_B - vtemp_6m_rel_B) / (8.5 - 6);
    dvtemp_9_25m_rel_B = (vtemp_10m_rel_B - vtemp_8_5m_rel_B) / (10 - 8.5);
    dvtemp_12_5m_rel_B = (vtemp_15m_rel_B - vtemp_10m_rel_B) / (15 - 10);
    dvtemp_17_5m_rel_B = (vtemp_20m_rel_B - vtemp_15m_rel_B) / (20 - 15);
    
    part_A = varMidIdx - varStartIdx + 1;
    part_B = varEndIdx - varMidIdx;
    
    spd_0_2m_lconv_A = speedTable{varStartIdx:varMidIdx, 24};
    spd_1_5m_lconv_A = speedTable{varStartIdx:varMidIdx, 25};
    spd_3m_lconv_A = speedTable{varStartIdx:varMidIdx, 26};
    spd_4_5m_lconv_A = speedTable{varStartIdx:varMidIdx, 27};
    spd_6m_lconv_A = speedTable{varStartIdx:varMidIdx, 28};
    spd_10m_lconv_A = speedTable{varStartIdx:varMidIdx, 29};
    spd_8_5m_lconv_A = speedTable{varStartIdx:varMidIdx, 32};
    spd_15m_lconv_A = speedTable{varStartIdx:varMidIdx, 34};
    spd_20m_lconv_A = speedTable{varStartIdx:varMidIdx, 36};
    
    dspd_0_85m_lconv_A = (spd_1_5m_lconv_A - spd_0_2m_lconv_A) / (1.5 - 0.2);
    dspd_2_25m_lconv_A = (spd_3m_lconv_A - spd_1_5m_lconv_A) / (3 - 1.5);
    dspd_3_75m_lconv_A = (spd_4_5m_lconv_A - spd_3m_lconv_A) / (4.5 - 3);
    dspd_5_25m_lconv_A = (spd_6m_lconv_A - spd_4_5m_lconv_A) / (6 - 4.5);
    dspd_7_25m_lconv_A = (spd_8_5m_lconv_A - spd_6m_lconv_A) / (8.5 - 6);
    dspd_9_25m_lconv_A = (spd_10m_lconv_A - spd_8_5m_lconv_A) / (10 - 8.5);
    dspd_12_5m_lconv_A = (spd_15m_lconv_A - spd_10m_lconv_A) / (15 - 10);
    dspd_17_5m_lconv_A = (spd_20m_lconv_A - spd_15m_lconv_A) / (20 - 15);
    
    spd_0_2m_lconv_B = speedTable{(varMidIdx+1):varEndIdx, 24};
    spd_1_5m_lconv_B = speedTable{(varMidIdx+1):varEndIdx, 25};
    spd_3m_lconv_B = speedTable{(varMidIdx+1):varEndIdx, 26};
    spd_4_5m_lconv_B = speedTable{(varMidIdx+1):varEndIdx, 27};
    spd_6m_lconv_B = speedTable{(varMidIdx+1):varEndIdx, 28};
    spd_10m_lconv_B = speedTable{(varMidIdx+1):varEndIdx, 29};
    spd_8_5m_lconv_B = speedTable{(varMidIdx+1):varEndIdx, 32};
    spd_15m_lconv_B = speedTable{(varMidIdx+1):varEndIdx, 34};
    spd_20m_lconv_B = speedTable{(varMidIdx+1):varEndIdx, 36};
    
    dspd_0_85m_lconv_B = (spd_1_5m_lconv_B - spd_0_2m_lconv_B) / (1.5 - 0.2);
    dspd_2_25m_lconv_B = (spd_3m_lconv_B - spd_1_5m_lconv_B) / (3 - 1.5);
    dspd_3_75m_lconv_B = (spd_4_5m_lconv_B - spd_3m_lconv_B) / (4.5 - 3);
    dspd_5_25m_lconv_B = (spd_6m_lconv_B - spd_4_5m_lconv_B) / (6 - 4.5);
    dspd_7_25m_lconv_B = (spd_8_5m_lconv_B - spd_6m_lconv_B) / (8.5 - 6);
    dspd_9_25m_lconv_B = (spd_10m_lconv_B - spd_8_5m_lconv_B) / (10 - 8.5);
    dspd_12_5m_lconv_B = (spd_15m_lconv_B - spd_10m_lconv_B) / (15 - 10);
    dspd_17_5m_lconv_B = (spd_20m_lconv_B - spd_15m_lconv_B) / (20 - 15);
    
    vtemp_1_5m_lconv_A = windTable{varStartIdx:varMidIdx, 54};
    vtemp_3m_lconv_A = windTable{varStartIdx:varMidIdx, 55};
    vtemp_4_5m_lconv_A = windTable{varStartIdx:varMidIdx, 56};
    vtemp_6m_lconv_A = windTable{varStartIdx:varMidIdx, 57};
    vtemp_10m_lconv_A = windTable{varStartIdx:varMidIdx, 58};
    vtemp_8_5m_lconv_A = windTable{varStartIdx:varMidIdx, 59};
    vtemp_15m_lconv_A = windTable{varStartIdx:varMidIdx, 60};
    vtemp_20m_lconv_A = windTable{varStartIdx:varMidIdx, 61};
    
    dvtemp_2_25m_lconv_A = (vtemp_3m_lconv_A - vtemp_1_5m_lconv_A) / (3 - 1.5);
    dvtemp_3_75m_lconv_A = (vtemp_4_5m_lconv_A - vtemp_3m_lconv_A) / (4.5 - 3);
    dvtemp_5_25m_lconv_A = (vtemp_6m_lconv_A - vtemp_4_5m_lconv_A) / (6 - 4.5);
    dvtemp_7_25m_lconv_A = (vtemp_8_5m_lconv_A - vtemp_6m_lconv_A) / (8.5 - 6);
    dvtemp_9_25m_lconv_A = (vtemp_10m_lconv_A - vtemp_8_5m_lconv_A) / (10 - 8.5);
    dvtemp_12_5m_lconv_A = (vtemp_15m_lconv_A - vtemp_10m_lconv_A) / (15 - 10);
    dvtemp_17_5m_lconv_A = (vtemp_20m_lconv_A - vtemp_15m_lconv_A) / (20 - 15);
    
    vtemp_1_5m_lconv_B = windTable{(varMidIdx+1):varEndIdx, 54};
    vtemp_3m_lconv_B = windTable{(varMidIdx+1):varEndIdx, 55};
    vtemp_4_5m_lconv_B = windTable{(varMidIdx+1):varEndIdx, 56};
    vtemp_6m_lconv_B = windTable{(varMidIdx+1):varEndIdx, 57};
    vtemp_10m_lconv_B = windTable{(varMidIdx+1):varEndIdx, 58};
    vtemp_8_5m_lconv_B = windTable{(varMidIdx+1):varEndIdx, 59};
    vtemp_15m_lconv_B = windTable{(varMidIdx+1):varEndIdx, 60};
    vtemp_20m_lconv_B = windTable{(varMidIdx+1):varEndIdx, 61};
    
    dvtemp_2_25m_lconv_B = (vtemp_3m_lconv_B - vtemp_1_5m_lconv_B) / (3 - 1.5);
    dvtemp_3_75m_lconv_B = (vtemp_4_5m_lconv_B - vtemp_3m_lconv_B) / (4.5 - 3);
    dvtemp_5_25m_lconv_B = (vtemp_6m_lconv_B - vtemp_4_5m_lconv_B) / (6 - 4.5);
    dvtemp_7_25m_lconv_B = (vtemp_8_5m_lconv_B - vtemp_6m_lconv_B) / (8.5 - 6);
    dvtemp_9_25m_lconv_B = (vtemp_10m_lconv_B - vtemp_8_5m_lconv_B) / (10 - 8.5);
    dvtemp_12_5m_lconv_B = (vtemp_15m_lconv_B - vtemp_10m_lconv_B) / (15 - 10);
    dvtemp_17_5m_lconv_B = (vtemp_20m_lconv_B - vtemp_15m_lconv_B) / (20 - 15);
    
    part_A = varMidIdx - varStartIdx + 1;
    part_B = varEndIdx - varMidIdx;
    
    %         % Time series speed at each tower
    %         % 3D Plot
    %         figure
    %
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_0_2m_rel_A, 0.2*ones(part_A, 1), 'Color', c.A, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_1_5m_rel_A, 1.5*ones(part_A, 1), 'Color', c.B, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_3m_rel_A, 3*ones(part_A, 1), 'Color', c.C, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_4_5m_rel_A, 4.5*ones(part_A, 1), 'Color', c.D, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_6m_rel_A, 6*ones(part_A, 1), 'Color', c.E, 'Marker', '*')
    %         hold on
    %         plot3(CDT_Time(varStartIdx:varMidIdx), spd_10m_rel_A, 10*ones(part_A, 1), 'Color', c.F, 'Marker', '*')
    %         hold off
    %
    %         % 2D Plot
    %         figure
    %
    %         plot(spd_0_2m_rel_A, 0.2*ones(part_A, 1), 'Color', c.A, 'Marker', '*')
    %         hold on
    %         plot(spd_1_5m_rel_A, 1.5*ones(part_A, 1), 'Color', c.B, 'Marker', '*')
    %         hold on
    %         plot(spd_3m_rel_A, 3*ones(part_A, 1), 'Color', c.C, 'Marker', '*')
    %         hold on
    %         plot(spd_4_5m_rel_A, 4.5*ones(part_A, 1), 'Color', c.D, 'Marker', '*')
    %         hold on
    %         plot(spd_6m_rel_A, 6*ones(part_A, 1), 'Color', c.E, 'Marker', '*')
    %         hold on
    %         plot(spd_10m_rel_A, 10*ones(part_A, 1), 'Color', c.F, 'Marker', '*')
    %         hold off
    
    
    % V versus z
    
    
    %         for hours = 1:12
    %             figure
    %             y_arr = [0.2, 1.5, 3, 4.5, 6, 10];
    %             %set(gca, 'DataAspectRatioMode', 'auto')
    %             set(gca, 'LooseInset', get(gca,'TightInset'))
    %             %daspect([1.75,5,1])
    %             for iteration = 1:7
    %                 x_arr = [spd_0_2m_init_A(iteration), spd_1_5m_init_A(iteration), spd_3m_init_A(iteration), spd_4_5m_init_A(iteration), spd_6m_init_A(iteration), spd_10m_init_A(iteration)];
    %
    %                 plot(x_arr, y_arr, 'Color', c.(names(iteration)), 'Marker', '*')
    %
    %                 hold on
    %             end
    %
    %             for iteration = 8:12
    %                 x_arr = [spd_0_2m_init_A(iteration), spd_1_5m_init_A(iteration), spd_3m_init_A(iteration), spd_4_5m_init_A(iteration), spd_6m_init_A(iteration), spd_10m_init_A(iteration)];
    %
    %                 plot(x_arr, y_arr, 'Color', c.(names(iteration - 7)), 'LineStyle', '--', 'Marker', 'o')
    %
    %                 hold on
    %             end
    %
    %             hold off
    %             %pbaspect([1,0.252676659528908,0.252676659528908])
    %             %set(gca, 'DataAspectRatioMode', 'auto')
    %             % MaximizeFigureWindow()
    %             set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.5, 0.45]);
    %             % daspect([1.75,5,1])
    %             %axis fill
    %             xlabel('V (m/s)')
    %             ylabel('z (m)')
    %             %legend(CDT_Time(1), CDT_Time(2), CDT_Time(3), CDT_Time(4), CDT_Time(5), CDT_Time(6), CDT_Time(7), CDT_Time(8), CDT_Time(9), CDT_Time(10), CDT_Time(11), CDT_Time(12))
    %             tempLegend = legend(char(CDT_Time((1+(hours-1)*12):12+(hours-1)*12)));
    %             set(tempLegend, 'Location', 'best')
    %
    %             temp_tag = char(CDT_Time((1+(hours-1)*12)));
    %             if temp_tag(1)== '0'
    %                 title(strcat(targetDate, ' Initiation Tower @ ', temp_tag(2), " o'clock"))
    %                 print(gcf, strcat(targetDate, '_init_', temp_tag(1:2), '.png'), '-dpng','-r350');
    %                 movefile(strcat(targetDate, '_init_', temp_tag(1:2), '.png'), strcat('v_VS_z\', targetDate, '_init_', temp_tag(1:2), '.png'));
    %             else
    %                 title(strcat(preDate, ' Initiation Tower @ ', temp_tag(1:2), " o'clock"))
    %                 print(gcf, strcat(preDate, '_init_', temp_tag(1:2),'.png'), '-dpng','-r350');
    %                 movefile(strcat(preDate, '_init_', temp_tag(1:2),'.png'), strcat('v_VS_z\', preDate, '_init_', temp_tag(1:2),'.png'));
    %             end
    %
    %             %print(gcf, strcat(targetDate, '_init_', '.png'), '-dpng','-r800');
    %
    %             figure
    %             y_arr = [0.2, 1.5, 3, 4.5, 6, 10];
    %             %set(gca, 'DataAspectRatioMode', 'auto')
    %             set(gca, 'LooseInset', get(gca,'TightInset'))
    %             %daspect([1.75,5,1])
    %             for iteration = 1:7
    %                 x_arr = [spd_0_2m_uconv_A(iteration), spd_1_5m_uconv_A(iteration), spd_3m_uconv_A(iteration), spd_4_5m_uconv_A(iteration), spd_6m_uconv_A(iteration), spd_10m_uconv_A(iteration)];
    %
    %                 plot(x_arr, y_arr, 'Color', c.(names(iteration)), 'Marker', '*')
    %
    %                 hold on
    %             end
    %
    %             for iteration = 8:12
    %                 x_arr = [spd_0_2m_uconv_A(iteration), spd_1_5m_uconv_A(iteration), spd_3m_uconv_A(iteration), spd_4_5m_uconv_A(iteration), spd_6m_uconv_A(iteration), spd_10m_uconv_A(iteration)];
    %
    %                 plot(x_arr, y_arr, 'Color', c.(names(iteration - 7)), 'LineStyle', '--', 'Marker', 'o')
    %
    %                 hold on
    %             end
    %
    %             hold off
    %             %pbaspect([1,0.252676659528908,0.252676659528908])
    %             %set(gca, 'DataAspectRatioMode', 'auto')
    %             % MaximizeFigureWindow()
    %             set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.5, 0.45]);
    %             % daspect([1.75,5,1])
    %             %axis fill
    %             xlabel('V (m/s)')
    %             ylabel('z (m)')
    %             %legend(CDT_Time(1), CDT_Time(2), CDT_Time(3), CDT_Time(4), CDT_Time(5), CDT_Time(6), CDT_Time(7), CDT_Time(8), CDT_Time(9), CDT_Time(10), CDT_Time(11), CDT_Time(12))
    %             tempLegend = legend(char(CDT_Time((1+(hours-1)*12):12+(hours-1)*12)));
    %             set(tempLegend, 'Location', 'best')
    %
    %             temp_tag = char(CDT_Time((1+(hours-1)*12)));
    %             if temp_tag(1)== '0'
    %                 title(strcat(targetDate, ' Upper Conv Tower @ ', temp_tag(2), " o'clock"))
    %                 print(gcf, strcat(targetDate, '_uconv_', temp_tag(1:2), '.png'), '-dpng','-r350');
    %                 movefile(strcat(targetDate, '_uconv_', temp_tag(1:2), '.png'), strcat('v_VS_z\', targetDate, '_uconv_', temp_tag(1:2), '.png'));
    %             else
    %                 title(strcat(preDate, ' Upper Conv Tower @ ', temp_tag(1:2), " o'clock"))
    %                 print(gcf, strcat(preDate, '_uconv_', temp_tag(1:2),'.png'), '-dpng','-r350');
    %                 movefile(strcat(preDate, '_uconv_', temp_tag(1:2),'.png'), strcat('v_VS_z\', preDate, '_uconv_', temp_tag(1:2),'.png'));
    %             end
    %
    %             %print(gcf, strcat(targetDate, '_uconv_', '.png'), '-dpng','-r800');
    %
    %             figure
    %             y_arr = [0.2, 1.5, 3, 4.5, 6, 8.5, 10, 15, 20];
    %             %set(gca, 'DataAspectRatioMode', 'auto')
    %             set(gca, 'LooseInset', get(gca,'TightInset'))
    %             %daspect([1.75,5,1])
    %             for iteration = 1:7
    %                 x_arr = [spd_0_2m_rel_A(iteration), spd_1_5m_rel_A(iteration), spd_3m_rel_A(iteration), spd_4_5m_rel_A(iteration), spd_6m_rel_A(iteration), spd_8_5m_rel_A(iteration), spd_10m_rel_A(iteration), spd_15m_rel_A(iteration), spd_20m_rel_A(iteration)];
    %
    %                 plot(x_arr, y_arr, 'Color', c.(names(iteration)), 'Marker', '*')
    %
    %                 hold on
    %             end
    %
    %             for iteration = 8:12
    %                 x_arr = [spd_0_2m_rel_A(iteration), spd_1_5m_rel_A(iteration), spd_3m_rel_A(iteration), spd_4_5m_rel_A(iteration), spd_6m_rel_A(iteration), spd_8_5m_rel_A(iteration), spd_10m_rel_A(iteration), spd_15m_rel_A(iteration), spd_20m_rel_A(iteration)];
    %
    %                 plot(x_arr, y_arr, 'Color', c.(names(iteration - 7)), 'LineStyle', '--', 'Marker', 'o')
    %
    %                 hold on
    %             end
    %
    %             hold off
    %             %pbaspect([1,0.252676659528908,0.252676659528908])
    %             %set(gca, 'DataAspectRatioMode', 'auto')
    %             % MaximizeFigureWindow()
    %             set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.5, 0.45]);
    %             % daspect([1.75,5,1])
    %             %axis fill
    %             xlabel('V (m/s)')
    %             ylabel('z (m)')
    %             %legend(CDT_Time(1), CDT_Time(2), CDT_Time(3), CDT_Time(4), CDT_Time(5), CDT_Time(6), CDT_Time(7), CDT_Time(8), CDT_Time(9), CDT_Time(10), CDT_Time(11), CDT_Time(12))
    %             tempLegend = legend(char(CDT_Time((1+(hours-1)*12):12+(hours-1)*12)));
    %             set(tempLegend, 'Location', 'best')
    %
    %             temp_tag = char(CDT_Time((1+(hours-1)*12)));
    %             if temp_tag(1)== '0'
    %                 title(strcat(targetDate, ' Release Tower @ ', temp_tag(2), " o'clock"))
    %                 print(gcf, strcat(targetDate, '_rel_', temp_tag(1:2), '.png'), '-dpng','-r350');
    %                 movefile(strcat(targetDate, '_rel_', temp_tag(1:2), '.png'), strcat('v_VS_z\', targetDate, '_rel_', temp_tag(1:2), '.png'));
    %             else
    %                 title(strcat(preDate, ' Release Tower @ ', temp_tag(1:2), " o'clock"))
    %                 print(gcf, strcat(preDate, '_rel_', temp_tag(1:2),'.png'), '-dpng','-r350');
    %                 movefile(strcat(preDate, '_rel_', temp_tag(1:2),'.png'), strcat('v_VS_z\', preDate, '_rel_', temp_tag(1:2),'.png'));
    %             end
    %
    %             %print(gcf, strcat(targetDate, '_rel_', '.png'), '-dpng','-r800');
    %
    %             figure
    %             y_arr = [0.2, 1.5, 3, 4.5, 6, 8.5, 10, 15, 20];
    %             %set(gca, 'DataAspectRatioMode', 'auto')
    %             set(gca, 'LooseInset', get(gca,'TightInset'))
    %             %daspect([1.75,5,1])
    %             for iteration = 1:7
    %                 x_arr = [spd_0_2m_lconv_A(iteration), spd_1_5m_lconv_A(iteration), spd_3m_lconv_A(iteration), spd_4_5m_lconv_A(iteration), spd_6m_lconv_A(iteration), spd_8_5m_lconv_A(iteration), spd_10m_lconv_A(iteration), spd_15m_lconv_A(iteration), spd_20m_lconv_A(iteration)];
    %
    %                 plot(x_arr, y_arr, 'Color', c.(names(iteration)), 'Marker', '*')
    %
    %                 hold on
    %             end
    %
    %             for iteration = 8:12
    %                 x_arr = [spd_0_2m_lconv_A(iteration), spd_1_5m_lconv_A(iteration), spd_3m_lconv_A(iteration), spd_4_5m_lconv_A(iteration), spd_6m_lconv_A(iteration), spd_8_5m_lconv_A(iteration), spd_10m_lconv_A(iteration), spd_15m_lconv_A(iteration), spd_20m_lconv_A(iteration)];
    %
    %                 plot(x_arr, y_arr, 'Color', c.(names(iteration - 7)), 'LineStyle', '--', 'Marker', 'o')
    %
    %                 hold on
    %             end
    %
    %             hold off
    %             %pbaspect([1,0.252676659528908,0.252676659528908])
    %             %set(gca, 'DataAspectRatioMode', 'auto')
    %             % MaximizeFigureWindow()
    %             set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.5, 0.45]);
    %             % daspect([1.75,5,1])
    %             %axis fill
    %             xlabel('V (m/s)')
    %             ylabel('z (m)')
    %             %legend(CDT_Time(1), CDT_Time(2), CDT_Time(3), CDT_Time(4), CDT_Time(5), CDT_Time(6), CDT_Time(7), CDT_Time(8), CDT_Time(9), CDT_Time(10), CDT_Time(11), CDT_Time(12))
    %             tempLegend = legend(char(CDT_Time((1+(hours-1)*12):12+(hours-1)*12)));
    %             set(tempLegend, 'Location', 'best')
    %
    %             temp_tag = char(CDT_Time((1+(hours-1)*12)));
    %             if temp_tag(1)== '0'
    %                 title(strcat(targetDate, ' Lower Conv Tower @ ', temp_tag(2), " o'clock"))
    %                 print(gcf, strcat(targetDate, '_lconv_', temp_tag(1:2), '.png'), '-dpng','-r350');
    %                 movefile(strcat(targetDate, '_lconv_', temp_tag(1:2), '.png'), strcat('v_VS_z\', targetDate, '_lconv_', temp_tag(1:2), '.png'));
    %             else
    %                 title(strcat(preDate, ' Lower Conv Tower @ ', temp_tag(1:2), " o'clock"))
    %                 print(gcf, strcat(preDate, '_lconv_', temp_tag(1:2),'.png'), '-dpng','-r350');
    %                 movefile(strcat(preDate, '_lconv_', temp_tag(1:2),'.png'), strcat('v_VS_z\', preDate, '_lconv_', temp_tag(1:2),'.png'));
    %             end
    %
    %             %print(gcf, strcat(targetDate, '_lconv_', '.png'), '-dpng','-r800');
    %
    %
    %         end
    %
    %
    %     end
    %
    %     close all
    
    
    
    
    figure
    tempStart = 1;
    
    set(gca, 'LooseInset', get(gca,'TightInset'))
    for hours = 1:5
        y_arr = [0.2, 1.5, 3, 4.5, 6, 10];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(spd_0_2m_init_A((tempStart+ (hours-1) * 12):(tempStart + (hours) * 12 - 1))),...
            mean(spd_1_5m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_3m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_4_5m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_6m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_10m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [0.2, 1.5, 3, 4.5, 6, 10];
        hours = hours - 5;
        x_arr = [mean(spd_0_2m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_1_5m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_3m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_4_5m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_6m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_10m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours )), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Initiation Tower', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly', '_init_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly', '_init_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly', '_init_' ,'.png'));
    
    
    figure
    tempStart = 1;
    
    set(gca, 'LooseInset', get(gca,'TightInset'))
    for hours = 1:5
        y_arr = [0.2, 1.5, 3, 4.5, 6, 10];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(spd_0_2m_uconv_A((tempStart+ (hours-1) * 12):(tempStart + (hours) * 12 - 1))),...
            mean(spd_1_5m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_3m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_4_5m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_6m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_10m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [0.2, 1.5, 3, 4.5, 6, 10];
        hours = hours - 5;
        x_arr = [mean(spd_0_2m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_1_5m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_3m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_4_5m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_6m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_10m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours )), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Upper Conv Tower', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly', '_uconv_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly', '_uconv_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly', '_uconv_' ,'.png'));
    
    figure
    tempStart = 1;
    
    set(gca, 'LooseInset', get(gca,'TightInset'))
    for hours = 1:5
        y_arr = [0.2, 1.5, 3, 4.5, 6, 8.5, 10, 15, 20];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(spd_0_2m_rel_A((tempStart+ (hours-1) * 12):(tempStart + (hours) * 12 - 1))),...
            mean(spd_1_5m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_3m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_4_5m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_6m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_8_5m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_10m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_15m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_20m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [0.2, 1.5, 3, 4.5, 6, 8.5, 10, 15, 20];
        hours = hours - 5;
        x_arr = [mean(spd_0_2m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_1_5m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_3m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_4_5m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_6m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_8_5m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_10m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_15m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_20m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Release Tower', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly', '_rel_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly', '_rel_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly', '_rel_' ,'.png'));
    
    figure
    tempStart = 1;
    
    set(gca, 'LooseInset', get(gca,'TightInset'))
    for hours = 1:5
        y_arr = [0.2, 1.5, 3, 4.5, 6, 8.5, 10, 15, 20];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(spd_0_2m_lconv_A((tempStart+ (hours-1) * 12):(tempStart + (hours) * 12 - 1))),...
            mean(spd_1_5m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_3m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_4_5m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_6m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_8_5m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_10m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_15m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_20m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [0.2, 1.5, 3, 4.5, 6, 8.5, 10, 15, 20];
        hours = hours - 5;
        x_arr = [mean(spd_0_2m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_1_5m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_3m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_4_5m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_6m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_8_5m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_10m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_15m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(spd_20m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Lower Conv Tower', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly', '_lconv_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly', '_lconv_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly', '_lconv_' ,'.png'));
    
    
    %
    %
    %     hold off
    %     %pbaspect([1,0.252676659528908,0.252676659528908])
    %     %set(gca, 'DataAspectRatioMode', 'auto')
    %     % MaximizeFigureWindow()
    %     set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.5, 0.45]);
    %     % daspect([1.75,5,1])
    %     %axis fill
    %     xlabel('V (m/s)')
    %     ylabel('z (m)')
    %     %legend(CDT_Time(1), CDT_Time(2), CDT_Time(3), CDT_Time(4), CDT_Time(5), CDT_Time(6), CDT_Time(7), CDT_Time(8), CDT_Time(9), CDT_Time(10), CDT_Time(11), CDT_Time(12))
    %     tempLegend = legend(char(CDT_Time((1+(hours-1)*12):12+(hours-1)*12)));
    %     set(tempLegend, 'Location', 'best')
    %
    %     temp_tag = char(CDT_Time((1+(hours-1)*12)));
    %     if temp_tag(1)== '0'
    %         title(strcat(targetDate, ' Initiation Tower @ ', temp_tag(2), " o'clock"))
    %         print(gcf, strcat(targetDate, '_init_', temp_tag(1:2), '.png'), '-dpng','-r350');
    %         movefile(strcat(targetDate, '_init_', temp_tag(1:2), '.png'), strcat('v_VS_z\', targetDate, '_init_', temp_tag(1:2), '.png'));
    %     else
    %         title(strcat(preDate, ' Initiation Tower @ ', temp_tag(1:2), " o'clock"))
    %         print(gcf, strcat(preDate, '_init_', temp_tag(1:2),'.png'), '-dpng','-r350');
    %         movefile(strcat(preDate, '_init_', temp_tag(1:2),'.png'), strcat('v_VS_z\', preDate, '_init_', temp_tag(1:2),'.png'));
    %     end
    %
    %     %print(gcf, strcat(targetDate, '_init_', '.png'), '-dpng','-r800');
    %
    %     figure
    %     y_arr = [0.2, 1.5, 3, 4.5, 6, 10];
    %     %set(gca, 'DataAspectRatioMode', 'auto')
    %     set(gca, 'LooseInset', get(gca,'TightInset'))
    %     %daspect([1.75,5,1])
    %     for iteration = 1:7
    %         x_arr = [spd_0_2m_uconv_A(iteration), spd_1_5m_uconv_A(iteration), spd_3m_uconv_A(iteration), spd_4_5m_uconv_A(iteration), spd_6m_uconv_A(iteration), spd_10m_uconv_A(iteration)];
    %
    %         plot(x_arr, y_arr, 'Color', c.(names(iteration)), 'Marker', '*')
    %
    %         hold on
    %     end
    %
    %     for iteration = 8:12
    %         x_arr = [spd_0_2m_uconv_A(iteration), spd_1_5m_uconv_A(iteration), spd_3m_uconv_A(iteration), spd_4_5m_uconv_A(iteration), spd_6m_uconv_A(iteration), spd_10m_uconv_A(iteration)];
    %
    %         plot(x_arr, y_arr, 'Color', c.(names(iteration - 7)), 'LineStyle', '--', 'Marker', 'o')
    %
    %         hold on
    %     end
    %
    %     hold off
    %     %pbaspect([1,0.252676659528908,0.252676659528908])
    %     %set(gca, 'DataAspectRatioMode', 'auto')
    %     % MaximizeFigureWindow()
    %     set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.5, 0.45]);
    %     % daspect([1.75,5,1])
    %     %axis fill
    %     xlabel('V (m/s)')
    %     ylabel('z (m)')
    %     %legend(CDT_Time(1), CDT_Time(2), CDT_Time(3), CDT_Time(4), CDT_Time(5), CDT_Time(6), CDT_Time(7), CDT_Time(8), CDT_Time(9), CDT_Time(10), CDT_Time(11), CDT_Time(12))
    %     tempLegend = legend(char(CDT_Time((1+(hours-1)*12):12+(hours-1)*12)));
    %     set(tempLegend, 'Location', 'best')
    %
    %     temp_tag = char(CDT_Time((1+(hours-1)*12)));
    %     if temp_tag(1)== '0'
    %         title(strcat(targetDate, ' Upper Conv Tower @ ', temp_tag(2), " o'clock"))
    %         print(gcf, strcat(targetDate, '_uconv_', temp_tag(1:2), '.png'), '-dpng','-r350');
    %         movefile(strcat(targetDate, '_uconv_', temp_tag(1:2), '.png'), strcat('v_VS_z\', targetDate, '_uconv_', temp_tag(1:2), '.png'));
    %     else
    %         title(strcat(preDate, ' Upper Conv Tower @ ', temp_tag(1:2), " o'clock"))
    %         print(gcf, strcat(preDate, '_uconv_', temp_tag(1:2),'.png'), '-dpng','-r350');
    %         movefile(strcat(preDate, '_uconv_', temp_tag(1:2),'.png'), strcat('v_VS_z\', preDate, '_uconv_', temp_tag(1:2),'.png'));
    %     end
    %
    %     %print(gcf, strcat(targetDate, '_uconv_', '.png'), '-dpng','-r800');
    %
    %     figure
    %     y_arr = [0.2, 1.5, 3, 4.5, 6, 8.5, 10, 15, 20];
    %     %set(gca, 'DataAspectRatioMode', 'auto')
    %     set(gca, 'LooseInset', get(gca,'TightInset'))
    %     %daspect([1.75,5,1])
    %     for iteration = 1:7
    %         x_arr = [spd_0_2m_rel_A(iteration), spd_1_5m_rel_A(iteration), spd_3m_rel_A(iteration), spd_4_5m_rel_A(iteration), spd_6m_rel_A(iteration), spd_8_5m_rel_A(iteration), spd_10m_rel_A(iteration), spd_15m_rel_A(iteration), spd_20m_rel_A(iteration)];
    %
    %         plot(x_arr, y_arr, 'Color', c.(names(iteration)), 'Marker', '*')
    %
    %         hold on
    %     end
    %
    %     for iteration = 8:12
    %         x_arr = [spd_0_2m_rel_A(iteration), spd_1_5m_rel_A(iteration), spd_3m_rel_A(iteration), spd_4_5m_rel_A(iteration), spd_6m_rel_A(iteration), spd_8_5m_rel_A(iteration), spd_10m_rel_A(iteration), spd_15m_rel_A(iteration), spd_20m_rel_A(iteration)];
    %
    %         plot(x_arr, y_arr, 'Color', c.(names(iteration - 7)), 'LineStyle', '--', 'Marker', 'o')
    %
    %         hold on
    %     end
    %
    %     hold off
    %     %pbaspect([1,0.252676659528908,0.252676659528908])
    %     %set(gca, 'DataAspectRatioMode', 'auto')
    %     % MaximizeFigureWindow()
    %     set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.5, 0.45]);
    %     % daspect([1.75,5,1])
    %     %axis fill
    %     xlabel('V (m/s)')
    %     ylabel('z (m)')
    %     %legend(CDT_Time(1), CDT_Time(2), CDT_Time(3), CDT_Time(4), CDT_Time(5), CDT_Time(6), CDT_Time(7), CDT_Time(8), CDT_Time(9), CDT_Time(10), CDT_Time(11), CDT_Time(12))
    %     tempLegend = legend(char(CDT_Time((1+(hours-1)*12):12+(hours-1)*12)));
    %     set(tempLegend, 'Location', 'best')
    %
    %     temp_tag = char(CDT_Time((1+(hours-1)*12)));
    %     if temp_tag(1)== '0'
    %         title(strcat(targetDate, ' Release Tower @ ', temp_tag(2), " o'clock"))
    %         print(gcf, strcat(targetDate, '_rel_', temp_tag(1:2), '.png'), '-dpng','-r350');
    %         movefile(strcat(targetDate, '_rel_', temp_tag(1:2), '.png'), strcat('v_VS_z\', targetDate, '_rel_', temp_tag(1:2), '.png'));
    %     else
    %         title(strcat(preDate, ' Release Tower @ ', temp_tag(1:2), " o'clock"))
    %         print(gcf, strcat(preDate, '_rel_', temp_tag(1:2),'.png'), '-dpng','-r350');
    %         movefile(strcat(preDate, '_rel_', temp_tag(1:2),'.png'), strcat('v_VS_z\', preDate, '_rel_', temp_tag(1:2),'.png'));
    %     end
    %
    %     %print(gcf, strcat(targetDate, '_rel_', '.png'), '-dpng','-r800');
    %
    %     figure
    %     y_arr = [0.2, 1.5, 3, 4.5, 6, 8.5, 10, 15, 20];
    %     %set(gca, 'DataAspectRatioMode', 'auto')
    %     set(gca, 'LooseInset', get(gca,'TightInset'))
    %     %daspect([1.75,5,1])
    %     for iteration = 1:7
    %         x_arr = [spd_0_2m_lconv_A(iteration), spd_1_5m_lconv_A(iteration), spd_3m_lconv_A(iteration), spd_4_5m_lconv_A(iteration), spd_6m_lconv_A(iteration), spd_8_5m_lconv_A(iteration), spd_10m_lconv_A(iteration), spd_15m_lconv_A(iteration), spd_20m_lconv_A(iteration)];
    %
    %         plot(x_arr, y_arr, 'Color', c.(names(iteration)), 'Marker', '*')
    %
    %         hold on
    %     end
    %
    %     for iteration = 8:12
    %         x_arr = [spd_0_2m_lconv_A(iteration), spd_1_5m_lconv_A(iteration), spd_3m_lconv_A(iteration), spd_4_5m_lconv_A(iteration), spd_6m_lconv_A(iteration), spd_8_5m_lconv_A(iteration), spd_10m_lconv_A(iteration), spd_15m_lconv_A(iteration), spd_20m_lconv_A(iteration)];
    %
    %         plot(x_arr, y_arr, 'Color', c.(names(iteration - 7)), 'LineStyle', '--', 'Marker', 'o')
    %
    %         hold on
    %     end
    %
    %     hold off
    %     %pbaspect([1,0.252676659528908,0.252676659528908])
    %     %set(gca, 'DataAspectRatioMode', 'auto')
    %     % MaximizeFigureWindow()
    %     set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.5, 0.45]);
    %     % daspect([1.75,5,1])
    %     %axis fill
    %     xlabel('V (m/s)')
    %     ylabel('z (m)')
    %     %legend(CDT_Time(1), CDT_Time(2), CDT_Time(3), CDT_Time(4), CDT_Time(5), CDT_Time(6), CDT_Time(7), CDT_Time(8), CDT_Time(9), CDT_Time(10), CDT_Time(11), CDT_Time(12))
    %     tempLegend = legend(char(CDT_Time((1+(hours-1)*12):12+(hours-1)*12)));
    %     set(tempLegend, 'Location', 'best')
    %
    %     temp_tag = char(CDT_Time((1+(hours-1)*12)));
    %     if temp_tag(1)== '0'
    %         title(strcat(targetDate, ' Lower Conv Tower @ ', temp_tag(2), " o'clock"))
    %         print(gcf, strcat(targetDate, '_lconv_', temp_tag(1:2), '.png'), '-dpng','-r350');
    %         movefile(strcat(targetDate, '_lconv_', temp_tag(1:2), '.png'), strcat('v_VS_z\', targetDate, '_lconv_', temp_tag(1:2), '.png'));
    %     else
    %         title(strcat(preDate, ' Lower Conv Tower @ ', temp_tag(1:2), " o'clock"))
    %         print(gcf, strcat(preDate, '_lconv_', temp_tag(1:2),'.png'), '-dpng','-r350');
    %         movefile(strcat(preDate, '_lconv_', temp_tag(1:2),'.png'), strcat('v_VS_z\', preDate, '_lconv_', temp_tag(1:2),'.png'));
    %     end
    %
    %     %print(gcf, strcat(targetDate, '_lconv_', '.png'), '-dpng','-r800');
    %
    %
    % end
    %
    %
    %     end
    %
    %     close all
    %
    
    
    
    % This section is for the dV/dZ versus Z plot
    
    figure
    for hours = 1:5
        y_arr = [0.85, 2.25, 3.75, 5.25, 7.25, 9.25, 12.5, 17.5];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(dspd_0_85m_lconv_A((tempStart+ (hours-1) * 12):(tempStart + (hours) * 12 - 1))),...
            mean(dspd_2_25m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_7_25m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_9_25m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_12_5m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_17_5m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [0.85, 2.25, 3.75, 5.25, 7.25, 9.25, 12.5, 17.5];
        hours = hours - 5;
        x_arr = [mean(dspd_0_85m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_2_25m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_7_25m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_9_25m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_12_5m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_17_5m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Lower Conv Tower dV/dZ - Z', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly_dVdZ', '_lconv_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly_dVdZ', '_lconv_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly_dVdZ', '_lconv_' ,'.png'));
    
    
    figure
    for hours = 1:5
        y_arr = [0.85, 2.25, 3.75, 5.25, 7.25, 9.25, 12.5, 17.5];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(dspd_0_85m_rel_A((tempStart+ (hours-1) * 12):(tempStart + (hours) * 12 - 1))),...
            mean(dspd_2_25m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_7_25m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_9_25m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_12_5m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_17_5m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [0.85, 2.25, 3.75, 5.25, 7.25, 9.25, 12.5, 17.5];
        hours = hours - 5;
        x_arr = [mean(dspd_0_85m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_2_25m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_7_25m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_9_25m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_12_5m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_17_5m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Release Tower dV/dZ - Z', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly_dVdZ', '_rel_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly_dVdZ', '_rel_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly_dVdZ', '_rel_' ,'.png'));
    
    
    
    
    figure
    for hours = 1:5
        y_arr = [0.85, 2.25, 3.75, 5.25, 8.00];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(dspd_0_85m_init_A((tempStart+ (hours-1) * 12):(tempStart + (hours) * 12 - 1))),...
            mean(dspd_2_25m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_8m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [0.85, 2.25, 3.75, 5.25, 8.00];
        hours = hours - 5;
        x_arr = [mean(dspd_0_85m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_2_25m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_8m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Initiation Tower dV/dZ - Z', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly_dVdZ', '_init_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly_dVdZ', '_init_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly_dVdZ', '_init_' ,'.png'));
    
    
    
    figure
    for hours = 1:5
        y_arr = [0.85, 2.25, 3.75, 5.25, 8.00];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(dspd_0_85m_uconv_A((tempStart+ (hours-1) * 12):(tempStart + (hours) * 12 - 1))),...
            mean(dspd_2_25m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_8m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [0.85, 2.25, 3.75, 5.25, 8.00];
        hours = hours - 5;
        x_arr = [mean(dspd_0_85m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_2_25m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_8m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Upper Conv Tower dV/dZ - Z', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly_dVdZ', '_uconv_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly_dVdZ', '_uconv_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly_dVdZ', '_uconv_' ,'.png'));
    
    
        figure
    for hours = 1:5
        y_arr = [2.25, 3.75, 5.25, 7.25, 9.25, 12.5, 17.5];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(dspd_2_25m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_7_25m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_9_25m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_12_5m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_17_5m_lconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [2.25, 3.75, 5.25, 7.25, 9.25, 12.5, 17.5];
        hours = hours - 5;
        x_arr = [mean(dspd_2_25m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_7_25m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_9_25m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_12_5m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_17_5m_lconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Lower Conv Tower dTheta/dZ - Z', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly_dThetadZ', '_lconv_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly_dThetadZ', '_lconv_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly_dThetadZ', '_lconv_' ,'.png'));
    
    
    figure
    for hours = 1:5
        y_arr = [2.25, 3.75, 5.25, 7.25, 9.25, 12.5, 17.5];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [ mean(dspd_2_25m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_7_25m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_9_25m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_12_5m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_17_5m_rel_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [ 2.25, 3.75, 5.25, 7.25, 9.25, 12.5, 17.5];
        hours = hours - 5;
        x_arr = [mean(dspd_2_25m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_7_25m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_9_25m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_12_5m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_17_5m_rel_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Release Tower dTheta/dZ - Z', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly_dThetadZ', '_rel_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly_dThetadZ', '_rel_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly_dThetadZ', '_rel_' ,'.png'));
    
    
    
    
    figure
    for hours = 1:5
        y_arr = [2.25, 3.75, 5.25, 8.00];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(dspd_2_25m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_8m_init_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
        
    end
    
    
    for hours = 6:12
        y_arr = [2.25, 3.75, 5.25, 8.00];
        hours = hours - 5;
        x_arr = [mean(dspd_2_25m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_8m_init_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Initiation Tower dTheta/dZ - Z', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly_dThetadZ', '_init_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly_dThetadZ', '_init_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly_dThetadZ', '_init_' ,'.png'));
    
    
    
    figure
    for hours = 1:5
        y_arr = [2.25, 3.75, 5.25, 8.00];
        %set(gca, 'DataAspectRatioMode', 'auto')
        
        %daspect([1.75,5,1])
        
        
        x_arr = [mean(dspd_2_25m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_8m_uconv_A((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'Marker', '*')
        
        hold on
    end
    
    for hours = 6:12
        y_arr = [2.25, 3.75, 5.25, 8.00];
        hours = hours - 5;
        x_arr = [mean(dspd_2_25m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_3_75m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_5_25m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1))),...
            mean(dspd_8m_uconv_B((tempStart+ (hours-1) * 12):(tempStart+ (hours) * 12 - 1)))];
        
        plot(x_arr, y_arr, 'Color', c.(names(hours)), 'LineStyle', '--', 'Marker', 'o')
        
        hold on
        
    end
    hold off
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
    xlabel('V (m/s)')
    ylabel('z (m)')
    tempLegend = legend('19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 00:00',...
        '00:00 - 01:00', '01:00 - 02:00', '02:00 - 03:00', '03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00', '06:00 - 07:00');
    set(tempLegend, 'Location', 'best')
    title(strcat(num2str(daterange - 1), ' to' , {' '}, targetDate, ' Upper Conv Tower dTheta/dZ - Z', ' Hourly Average'))
    print(gcf, strcat(targetDate,'_hourly_dThetadZ', '_uconv_' ,'.png'), '-dpng','-r500');
    movefile(strcat(targetDate,'_hourly_dThetadZ', '_uconv_' ,'.png'), strcat('v_VS_z\',targetDate,'_hourly_dThetadZ', '_uconv_' ,'.png'));
    
    
    
    
    
    
    
    
    
    
    
end
