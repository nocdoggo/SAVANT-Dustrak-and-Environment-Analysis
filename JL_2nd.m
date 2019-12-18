% This is for Jielun's paper calculation
% Initialize memory space
clc, clear ALL; close all

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

R_Bulk_init_1_5_ALL = [];
L_init_1_5_ALL = [];
Term_3_init_1_5_ALL = [];
R_Bulk_init_3_ALL = [];
L_init_3_ALL = [];
Term_3_init_3_ALL = [];
R_Bulk_init_4_5_ALL = [];
L_init_4_5_ALL = [];
Term_3_init_4_5_ALL = [];
R_Bulk_init_6_ALL = [];
L_init_6_ALL = [];
Term_3_init_6_ALL = [];
R_Bulk_init_10_ALL = [];
L_init_10_ALL = [];
Term_3_init_10_ALL = [];

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

R_Bulk_uconv_1_5_ALL = [];
L_uconv_1_5_ALL = [];
Term_3_uconv_1_5_ALL = [];
R_Bulk_uconv_3_ALL = [];
L_uconv_3_ALL = [];
Term_3_uconv_3_ALL = [];
R_Bulk_uconv_4_5_ALL = [];
L_uconv_4_5_ALL = [];
Term_3_uconv_4_5_ALL = [];
R_Bulk_uconv_6_ALL = [];
L_uconv_6_ALL = [];
Term_3_uconv_6_ALL = [];
R_Bulk_uconv_10_ALL = [];
L_uconv_10_ALL = [];
Term_3_uconv_10_ALL = [];

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

R_Bulk_rel_1_5_ALL = [];
L_rel_1_5_ALL = [];
Term_3_rel_1_5_ALL = [];
R_Bulk_rel_3_ALL = [];
L_rel_3_ALL = [];
Term_3_rel_3_ALL = [];
R_Bulk_rel_4_5_ALL = [];
L_rel_4_5_ALL = [];
Term_3_rel_4_5_ALL = [];
R_Bulk_rel_6_ALL = [];
L_rel_6_ALL = [];
Term_3_rel_6_ALL = [];
R_Bulk_rel_8_5_ALL = [];
L_rel_8_5_ALL = [];
Term_3_rel_8_5_ALL = [];
R_Bulk_rel_10_ALL = [];
L_rel_10_ALL = [];
Term_3_rel_10_ALL = [];
R_Bulk_rel_15_ALL = [];
L_rel_15_ALL = [];
Term_3_rel_15_ALL = [];
R_Bulk_rel_20_ALL = [];
L_rel_20_ALL = [];
Term_3_rel_20_ALL = [];

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

R_Bulk_lconv_1_5_ALL = [];
L_lconv_1_5_ALL = [];
Term_3_lconv_1_5_ALL = [];
R_Bulk_lconv_3_ALL = [];
L_lconv_3_ALL = [];
Term_3_lconv_3_ALL = [];
R_Bulk_lconv_4_5_ALL = [];
L_lconv_4_5_ALL = [];
Term_3_lconv_4_5_ALL = [];
R_Bulk_lconv_6_ALL = [];
L_lconv_6_ALL = [];
Term_3_lconv_6_ALL = [];
R_Bulk_lconv_8_5_ALL = [];
L_lconv_8_5_ALL = [];
Term_3_lconv_8_5_ALL = [];
R_Bulk_lconv_10_ALL = [];
L_lconv_10_ALL = [];
Term_3_lconv_10_ALL = [];
R_Bulk_lconv_15_ALL = [];
L_lconv_15_ALL = [];
Term_3_lconv_15_ALL = [];
R_Bulk_lconv_20_ALL = [];
L_lconv_20_ALL = [];
Term_3_lconv_20_ALL = [];

% September
for daterange = 910:930
    %daterange = 1018;
    
    targetDate = num2str(daterange);
    dateStamp = str2double(targetDate);
    targetDate = strcat('0', targetDate);
    
    % Create file list
    speedfile = strcat(file_dir, filesep, strcat(targetDate, '_Speed.csv'));
    %     directionfile = strcat(file_dir, filesep, strcat(targetDate, '_Direction.csv'));
    temperaturefile = strcat(file_dir, filesep, strcat(targetDate, '_Temperature.csv'));
    windfile = strcat(file_dir, filesep, strcat(targetDate, '_3DWind.csv'));
    %     dustfile = strcat(file_dir, filesep, strcat(targetDate, '_Dustrak.csv'));
    
    % Check the list of the R_Bulk calculations
    init_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    init_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    init_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    init_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
    
    uconv_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    uconv_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    uconv_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    uconv_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
    
    rel_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    rel_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    rel_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    rel_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_6.0-8.5.csv'));   % For 6.0 m to 8.5 m
    rel_E_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_8.5-10.0.csv'));   % For 8.5 m to 10.0 m
    rel_F_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_10.0-15.0.csv'));   % For 10.0 m to 15.0 m
    rel_G_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_15.0-20.0.csv'));   % For 15.0 m to 20.0 m
    
    lconv_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    lconv_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    lconv_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    lconv_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_6.0-8.5.csv'));   % For 6.0 m to 8.5 m
    lconv_E_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_8.5-10.0.csv'));   % For 8.5 m to 10.0 m
    lconv_F_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_10.0-15.0.csv'));   % For 10.0 m to 15.0 m
    lconv_G_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_15.0-20.0.csv'));   % For 15.0 m to 20.0 m
    
    
    
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
    
    
    % Most importantly check on the R_Bulk and other calculations
    
    
    
    
    
    
    
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
        
        
        % Initiation tower
        
        init_A = readtable(init_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        init_B = readtable(init_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        init_C = readtable(init_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        init_D = readtable(init_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        
        uconv_A = readtable(uconv_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        uconv_B = readtable(uconv_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        uconv_C = readtable(uconv_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        uconv_D = readtable(uconv_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        
        rel_A = readtable(rel_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        rel_B = readtable(rel_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        rel_C = readtable(rel_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        rel_D = readtable(rel_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        rel_E = readtable(rel_E_file);
        rel_F = readtable(rel_F_file);
        rel_G = readtable(rel_G_file);
        
        lconv_A = readtable(lconv_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        lconv_B = readtable(lconv_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        lconv_C = readtable(lconv_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        lconv_D = readtable(lconv_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        lconv_E = readtable(lconv_E_file);
        lconv_F = readtable(lconv_F_file);
        lconv_G = readtable(lconv_G_file);
        
        R_Bulk_lconv_1_5 = lconv_A{:, 3};
        L_lconv_1_5 = lconv_A{:, 4};
        Term_3_lconv_1_5 = lconv_A{:, 6};
        
        R_Bulk_lconv_3 = lconv_B{:, 3};
        L_lconv_3 = lconv_B{:, 4};
        Term_3_lconv_3 = lconv_B{:, 6};
        
        R_Bulk_lconv_4_5 = lconv_C{:, 3};
        L_lconv_4_5 = lconv_C{:, 4};
        Term_3_lconv_4_5 = lconv_C{:, 6};
        
        R_Bulk_lconv_6 = lconv_D{:, 3};
        L_lconv_6 = lconv_D{:, 4};
        Term_3_lconv_6 = lconv_D{:, 6};
        
        R_Bulk_lconv_8_5 = lconv_E{:, 3};
        L_lconv_8_5 = lconv_E{:, 4};
        Term_3_lconv_8_5 = lconv_E{:, 6};
        
        R_Bulk_lconv_10 = lconv_F{:, 3};
        L_lconv_10 = lconv_F{:, 4};
        Term_3_lconv_10 = lconv_F{:, 6};
        
        R_Bulk_lconv_15 = lconv_G{:, 3};
        L_lconv_15 = lconv_G{:, 4};
        Term_3_lconv_15 = lconv_G{:, 6};
        
        R_Bulk_lconv_20 = lconv_G{:, 3};
        L_lconv_20 = lconv_G{:, 5};
        Term_3_lconv_20 = lconv_G{:, 7};
        
        R_Bulk_rel_1_5 = rel_A{:, 3};
        L_rel_1_5 = rel_A{:, 4};
        Term_3_rel_1_5 = rel_A{:, 6};
        
        R_Bulk_rel_3 = rel_B{:, 3};
        L_rel_3 = rel_B{:, 4};
        Term_3_rel_3 = rel_B{:, 6};
        
        R_Bulk_rel_4_5 = rel_C{:, 3};
        L_rel_4_5 = rel_C{:, 4};
        Term_3_rel_4_5 = rel_C{:, 6};
        
        R_Bulk_rel_6 = rel_D{:, 3};
        L_rel_6 = rel_D{:, 4};
        Term_3_rel_6 = rel_D{:, 6};
        
        R_Bulk_rel_8_5 = rel_E{:, 3};
        L_rel_8_5 = rel_E{:, 4};
        Term_3_rel_8_5 = rel_E{:, 6};
        
        R_Bulk_rel_10 = rel_F{:, 3};
        L_rel_10 = rel_F{:, 4};
        Term_3_rel_10 = rel_F{:, 6};
        
        R_Bulk_rel_15 = rel_G{:, 3};
        L_rel_15 = rel_G{:, 4};
        Term_3_rel_15 = rel_G{:, 6};
        
        R_Bulk_rel_20 = rel_G{:, 3};
        L_rel_20 = rel_G{:, 5};
        Term_3_rel_20 = rel_G{:, 7};
        
        R_Bulk_init_1_5 = init_A{:, 3};
        L_init_1_5 = init_A{:, 4};
        Term_3_init_1_5 = init_A{:, 6};
        
        R_Bulk_init_3 = init_B{:, 3};
        L_init_3 = init_B{:, 4};
        Term_3_init_3 = init_B{:, 6};
        
        R_Bulk_init_4_5 = init_C{:, 3};
        L_init_4_5 = init_C{:, 4};
        Term_3_init_4_5 = init_C{:, 6};
        
        R_Bulk_init_6 = init_D{:, 3};
        L_init_6 = init_D{:, 4};
        Term_3_init_6 = init_D{:, 6};
        
        R_Bulk_init_10 = init_D{:, 3};
        L_init_10 = init_D{:, 5};
        Term_3_init_10 = init_D{:, 7};
        
        R_Bulk_uconv_1_5 = uconv_A{:, 3};
        L_uconv_1_5 = uconv_A{:, 4};
        Term_3_uconv_1_5 = uconv_A{:, 6};
        
        R_Bulk_uconv_3 = uconv_B{:, 3};
        L_uconv_3 = uconv_B{:, 4};
        Term_3_uconv_3 = uconv_B{:, 6};
        
        R_Bulk_uconv_4_5 = uconv_C{:, 3};
        L_uconv_4_5 = uconv_C{:, 4};
        Term_3_uconv_4_5 = uconv_C{:, 6};
        
        R_Bulk_uconv_6 = uconv_D{:, 3};
        L_uconv_6 = uconv_D{:, 4};
        Term_3_uconv_6 = uconv_D{:, 6};
        
        R_Bulk_uconv_10 = uconv_D{:, 3};
        L_uconv_10 = uconv_D{:, 5};
        Term_3_uconv_10 = uconv_D{:, 7};
        
        
        [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5, R_Bulk_init_1_5, L_init_1_5, Term_3_init_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 213}, windTable{varStartIdx:varEndIdx, 243}, windTable{varStartIdx:varEndIdx, 273}, speedTable{varStartIdx:varEndIdx, 4}, R_Bulk_init_1_5, L_init_1_5, Term_3_init_1_5);
        [Vtke_init_3, TKE_init_3, spd_init_3, R_Bulk_init_3, L_init_3, Term_3_init_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 214}, windTable{varStartIdx:varEndIdx, 244}, windTable{varStartIdx:varEndIdx, 274}, speedTable{varStartIdx:varEndIdx, 5}, R_Bulk_init_3, L_init_3, Term_3_init_3);
        [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5, R_Bulk_init_4_5, L_init_4_5, Term_3_init_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 215}, windTable{varStartIdx:varEndIdx, 245}, windTable{varStartIdx:varEndIdx, 275}, speedTable{varStartIdx:varEndIdx, 6}, R_Bulk_init_4_5, L_init_4_5, Term_3_init_4_5);
        [Vtke_init_6, TKE_init_6, spd_init_6, R_Bulk_init_6, L_init_6, Term_3_init_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 216}, windTable{varStartIdx:varEndIdx, 246}, windTable{varStartIdx:varEndIdx, 276}, speedTable{varStartIdx:varEndIdx, 7}, R_Bulk_init_6, L_init_6, Term_3_init_6);
        [Vtke_init_10, TKE_init_10, spd_init_10, R_Bulk_init_10, L_init_10, Term_3_init_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 217}, windTable{varStartIdx:varEndIdx, 247}, windTable{varStartIdx:varEndIdx, 277}, speedTable{varStartIdx:varEndIdx, 8}, R_Bulk_init_10, L_init_10, Term_3_init_10);
        
        Vtke_init_1_5_ALL = [Vtke_init_1_5_ALL; Vtke_init_1_5];
        TKE_init_1_5_ALL = [TKE_init_1_5_ALL; TKE_init_1_5];
        spd_init_1_5_ALL = [spd_init_1_5_ALL; spd_init_1_5];
        R_Bulk_init_1_5_ALL = [R_Bulk_init_1_5_ALL; R_Bulk_init_1_5];
        L_init_1_5_ALL = [L_init_1_5_ALL; L_init_1_5];
        Term_3_init_1_5_ALL = [Term_3_init_1_5_ALL; Term_3_init_1_5];
        
        Vtke_init_3_ALL = [Vtke_init_3_ALL; Vtke_init_3];
        TKE_init_3_ALL = [TKE_init_3_ALL; TKE_init_3];
        spd_init_3_ALL = [spd_init_3_ALL; spd_init_3];
        R_Bulk_init_3_ALL = [R_Bulk_init_3_ALL; R_Bulk_init_3];
        L_init_3_ALL = [L_init_3_ALL; L_init_3];
        Term_3_init_3_ALL = [Term_3_init_3_ALL; Term_3_init_3];
        
        Vtke_init_4_5_ALL = [Vtke_init_4_5_ALL; Vtke_init_4_5];
        TKE_init_4_5_ALL = [TKE_init_4_5_ALL; TKE_init_4_5];
        spd_init_4_5_ALL = [spd_init_4_5_ALL; spd_init_4_5];
        R_Bulk_init_4_5_ALL = [R_Bulk_init_4_5_ALL; R_Bulk_init_4_5];
        L_init_4_5_ALL = [L_init_4_5_ALL; L_init_4_5];
        Term_3_init_4_5_ALL = [Term_3_init_4_5_ALL; Term_3_init_4_5];
        
        Vtke_init_6_ALL = [Vtke_init_6_ALL; Vtke_init_6];
        TKE_init_6_ALL = [TKE_init_6_ALL; TKE_init_6];
        spd_init_6_ALL = [spd_init_6_ALL; spd_init_6];
        R_Bulk_init_6_ALL = [R_Bulk_init_6_ALL; R_Bulk_init_6];
        L_init_6_ALL = [L_init_6_ALL; L_init_6];
        Term_3_init_6_ALL = [Term_3_init_6_ALL; Term_3_init_6];
        
        Vtke_init_10_ALL = [Vtke_init_10_ALL; Vtke_init_10];
        TKE_init_10_ALL = [TKE_init_10_ALL; TKE_init_10];
        spd_init_10_ALL = [spd_init_10_ALL; spd_init_10];
        R_Bulk_init_10_ALL = [R_Bulk_init_10_ALL; R_Bulk_init_10];
        L_init_10_ALL = [L_init_10_ALL; L_init_10];
        Term_3_init_10_ALL = [Term_3_init_10_ALL; Term_3_init_10];
        
        
        
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
        [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5, R_Bulk_rel_1_5, L_rel_1_5, Term_3_rel_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 219}, windTable{varStartIdx:varEndIdx, 249}, windTable{varStartIdx:varEndIdx, 279}, speedTable{varStartIdx:varEndIdx, 11}, R_Bulk_rel_1_5, L_rel_1_5, Term_3_rel_1_5);
        [Vtke_rel_3, TKE_rel_3, spd_rel_3, R_Bulk_rel_3, L_rel_3, Term_3_rel_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 220}, windTable{varStartIdx:varEndIdx, 250}, windTable{varStartIdx:varEndIdx, 280}, speedTable{varStartIdx:varEndIdx, 12}, R_Bulk_rel_3, L_rel_3, Term_3_rel_3);
        [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5, R_Bulk_rel_4_5, L_rel_4_5, Term_3_rel_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 221}, windTable{varStartIdx:varEndIdx, 251}, windTable{varStartIdx:varEndIdx, 281}, speedTable{varStartIdx:varEndIdx, 13}, R_Bulk_rel_4_5, L_rel_4_5, Term_3_rel_4_5);
        [Vtke_rel_6, TKE_rel_6, spd_rel_6, R_Bulk_rel_6, L_rel_6, Term_3_rel_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 222}, windTable{varStartIdx:varEndIdx, 252}, windTable{varStartIdx:varEndIdx, 282}, speedTable{varStartIdx:varEndIdx, 14}, R_Bulk_rel_6, L_rel_6, Term_3_rel_6);
        [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5, R_Bulk_rel_8_5, L_rel_8_5, Term_3_rel_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 223}, windTable{varStartIdx:varEndIdx, 253}, windTable{varStartIdx:varEndIdx, 283}, speedTable{varStartIdx:varEndIdx, 31}, R_Bulk_rel_8_5, L_rel_8_5, Term_3_rel_8_5);
        [Vtke_rel_10, TKE_rel_10, spd_rel_10, R_Bulk_rel_10, L_rel_10, Term_3_rel_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 224}, windTable{varStartIdx:varEndIdx, 254}, windTable{varStartIdx:varEndIdx, 284}, speedTable{varStartIdx:varEndIdx, 15}, R_Bulk_rel_10, L_rel_10, Term_3_rel_10);
        [Vtke_rel_15, TKE_rel_15, spd_rel_15, R_Bulk_rel_15, L_rel_15, Term_3_rel_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 225}, windTable{varStartIdx:varEndIdx, 255}, windTable{varStartIdx:varEndIdx, 285}, speedTable{varStartIdx:varEndIdx, 33}, R_Bulk_rel_15, L_rel_15, Term_3_rel_15);
        [Vtke_rel_20, TKE_rel_20, spd_rel_20, R_Bulk_rel_20, L_rel_20, Term_3_rel_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 226}, windTable{varStartIdx:varEndIdx, 256}, windTable{varStartIdx:varEndIdx, 286}, speedTable{varStartIdx:varEndIdx, 35}, R_Bulk_rel_20, L_rel_20, Term_3_rel_20);
        
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
        
        R_Bulk_rel_1_5_ALL = [R_Bulk_rel_1_5_ALL; R_Bulk_rel_1_5];
        L_rel_1_5_ALL = [L_rel_1_5_ALL; L_rel_1_5];
        Term_3_rel_1_5_ALL = [Term_3_rel_1_5_ALL; Term_3_rel_1_5];
        R_Bulk_rel_3_ALL = [R_Bulk_rel_3_ALL; R_Bulk_rel_3];
        L_rel_3_ALL = [L_rel_3_ALL; L_rel_3];
        Term_3_rel_3_ALL = [Term_3_rel_3_ALL; Term_3_rel_3];
        R_Bulk_rel_4_5_ALL = [R_Bulk_rel_4_5_ALL; R_Bulk_rel_4_5];
        L_rel_4_5_ALL = [L_rel_4_5_ALL; L_rel_4_5];
        Term_3_rel_4_5_ALL = [Term_3_rel_4_5_ALL; Term_3_rel_4_5];
        R_Bulk_rel_6_ALL = [R_Bulk_rel_6_ALL; R_Bulk_rel_6];
        L_rel_6_ALL = [L_rel_6_ALL; L_rel_6];
        Term_3_rel_6_ALL = [Term_3_rel_6_ALL; Term_3_rel_6];
        R_Bulk_rel_8_5_ALL = [R_Bulk_rel_8_5_ALL; R_Bulk_rel_8_5];
        L_rel_8_5_ALL = [L_rel_8_5_ALL; L_rel_8_5];
        Term_3_rel_8_5_ALL = [Term_3_rel_8_5_ALL; Term_3_rel_8_5];
        R_Bulk_rel_10_ALL = [R_Bulk_rel_10_ALL; R_Bulk_rel_10];
        L_rel_10_ALL = [L_rel_10_ALL; L_rel_10];
        Term_3_rel_10_ALL = [Term_3_rel_10_ALL; Term_3_rel_10];
        R_Bulk_rel_15_ALL = [R_Bulk_rel_15_ALL; R_Bulk_rel_15];
        L_rel_15_ALL = [L_rel_15_ALL; L_rel_15];
        Term_3_rel_15_ALL = [Term_3_rel_15_ALL; Term_3_rel_15];
        R_Bulk_rel_20_ALL = [R_Bulk_rel_20_ALL; R_Bulk_rel_20];
        L_rel_20_ALL = [L_rel_20_ALL; L_rel_20];
        Term_3_rel_20_ALL = [Term_3_rel_20_ALL; Term_3_rel_20];
        
        
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
        [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5, R_Bulk_uconv_1_5, L_uconv_1_5, Term_3_uconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 228}, windTable{varStartIdx:varEndIdx, 258}, windTable{varStartIdx:varEndIdx, 288}, speedTable{varStartIdx:varEndIdx, 18}, R_Bulk_uconv_1_5, L_uconv_1_5, Term_3_uconv_1_5);
        [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3, R_Bulk_uconv_3, L_uconv_3, Term_3_uconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 229}, windTable{varStartIdx:varEndIdx, 259}, windTable{varStartIdx:varEndIdx, 289}, speedTable{varStartIdx:varEndIdx, 19}, R_Bulk_uconv_3, L_uconv_3, Term_3_uconv_3);
        [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5, R_Bulk_uconv_4_5, L_uconv_4_5, Term_3_uconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 230}, windTable{varStartIdx:varEndIdx, 260}, windTable{varStartIdx:varEndIdx, 290}, speedTable{varStartIdx:varEndIdx, 20}, R_Bulk_uconv_4_5, L_uconv_4_5, Term_3_uconv_4_5);
        [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6, R_Bulk_uconv_6, L_uconv_6, Term_3_uconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 231}, windTable{varStartIdx:varEndIdx, 261}, windTable{varStartIdx:varEndIdx, 291}, speedTable{varStartIdx:varEndIdx, 21}, R_Bulk_uconv_6, L_uconv_6, Term_3_uconv_6);
        [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10, R_Bulk_uconv_10, L_uconv_10, Term_3_uconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 232}, windTable{varStartIdx:varEndIdx, 262}, windTable{varStartIdx:varEndIdx, 292}, speedTable{varStartIdx:varEndIdx, 22}, R_Bulk_uconv_10, L_uconv_10, Term_3_uconv_10);
        
        
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
        
        R_Bulk_uconv_1_5_ALL = [R_Bulk_uconv_1_5_ALL; R_Bulk_uconv_1_5];
        L_uconv_1_5_ALL = [L_uconv_1_5_ALL; L_uconv_1_5];
        Term_3_uconv_1_5_ALL = [Term_3_uconv_1_5_ALL; Term_3_uconv_1_5];
        R_Bulk_uconv_3_ALL = [R_Bulk_uconv_3_ALL; R_Bulk_uconv_3];
        L_uconv_3_ALL = [L_uconv_3_ALL; L_uconv_3];
        Term_3_uconv_3_ALL = [Term_3_uconv_3_ALL; Term_3_uconv_3];
        R_Bulk_uconv_4_5_ALL = [R_Bulk_uconv_4_5_ALL; R_Bulk_uconv_4_5];
        L_uconv_4_5_ALL = [L_uconv_4_5_ALL; L_uconv_4_5];
        Term_3_uconv_4_5_ALL = [Term_3_uconv_4_5_ALL; Term_3_uconv_4_5];
        R_Bulk_uconv_6_ALL = [R_Bulk_uconv_6_ALL; R_Bulk_uconv_6];
        L_uconv_6_ALL = [L_uconv_6_ALL; L_uconv_6];
        Term_3_uconv_6_ALL = [Term_3_uconv_6_ALL; Term_3_uconv_6];
        R_Bulk_uconv_10_ALL = [R_Bulk_uconv_10_ALL; R_Bulk_uconv_10];
        L_uconv_10_ALL = [L_uconv_10_ALL; L_uconv_10];
        Term_3_uconv_10_ALL = [Term_3_uconv_10_ALL; Term_3_uconv_10];
        
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
        [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5, R_Bulk_lconv_1_5, L_lconv_1_5, Term_3_lconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 234}, windTable{varStartIdx:varEndIdx, 264}, windTable{varStartIdx:varEndIdx, 294}, speedTable{varStartIdx:varEndIdx, 25}, R_Bulk_lconv_1_5, L_lconv_1_5, Term_3_lconv_1_5);
        [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3, R_Bulk_lconv_3, L_lconv_3, Term_3_lconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 235}, windTable{varStartIdx:varEndIdx, 265}, windTable{varStartIdx:varEndIdx, 295}, speedTable{varStartIdx:varEndIdx, 26}, R_Bulk_lconv_3, L_lconv_3, Term_3_lconv_3);
        [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5, R_Bulk_lconv_4_5, L_lconv_4_5, Term_3_lconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 236}, windTable{varStartIdx:varEndIdx, 266}, windTable{varStartIdx:varEndIdx, 296}, speedTable{varStartIdx:varEndIdx, 27}, R_Bulk_lconv_4_5, L_lconv_4_5, Term_3_lconv_4_5);
        [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6, R_Bulk_lconv_6, L_lconv_6, Term_3_lconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 237}, windTable{varStartIdx:varEndIdx, 267}, windTable{varStartIdx:varEndIdx, 297}, speedTable{varStartIdx:varEndIdx, 28}, R_Bulk_lconv_6, L_lconv_6, Term_3_lconv_6);
        [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5, R_Bulk_lconv_8_5, L_lconv_8_5, Term_3_lconv_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 238}, windTable{varStartIdx:varEndIdx, 268}, windTable{varStartIdx:varEndIdx, 298}, speedTable{varStartIdx:varEndIdx, 32}, R_Bulk_lconv_8_5, L_lconv_8_5, Term_3_lconv_8_5);
        [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10, R_Bulk_lconv_10, L_lconv_10, Term_3_lconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 239}, windTable{varStartIdx:varEndIdx, 269}, windTable{varStartIdx:varEndIdx, 299}, speedTable{varStartIdx:varEndIdx, 29}, R_Bulk_lconv_10, L_lconv_10, Term_3_lconv_10);
        [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15, R_Bulk_lconv_15, L_lconv_15, Term_3_lconv_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 240}, windTable{varStartIdx:varEndIdx, 270}, windTable{varStartIdx:varEndIdx, 300}, speedTable{varStartIdx:varEndIdx, 34}, R_Bulk_lconv_15, L_lconv_15, Term_3_lconv_15);
        [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20, R_Bulk_lconv_20, L_lconv_20, Term_3_lconv_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 241}, windTable{varStartIdx:varEndIdx, 271}, windTable{varStartIdx:varEndIdx, 301}, speedTable{varStartIdx:varEndIdx, 36}, R_Bulk_lconv_20, L_lconv_20, Term_3_lconv_20);
        
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
        
        R_Bulk_lconv_1_5_ALL = [R_Bulk_lconv_1_5_ALL; R_Bulk_lconv_1_5];
        L_lconv_1_5_ALL = [L_lconv_1_5_ALL; L_lconv_1_5];
        Term_3_lconv_1_5_ALL = [Term_3_lconv_1_5_ALL; Term_3_lconv_1_5];
        R_Bulk_lconv_3_ALL = [R_Bulk_lconv_3_ALL; R_Bulk_lconv_3];
        L_lconv_3_ALL = [L_lconv_3_ALL; L_lconv_3];
        Term_3_lconv_3_ALL = [Term_3_lconv_3_ALL; Term_3_lconv_3];
        R_Bulk_lconv_4_5_ALL = [R_Bulk_lconv_4_5_ALL; R_Bulk_lconv_4_5];
        L_lconv_4_5_ALL = [L_lconv_4_5_ALL; L_lconv_4_5];
        Term_3_lconv_4_5_ALL = [Term_3_lconv_4_5_ALL; Term_3_lconv_4_5];
        R_Bulk_lconv_6_ALL = [R_Bulk_lconv_6_ALL; R_Bulk_lconv_6];
        L_lconv_6_ALL = [L_lconv_6_ALL; L_lconv_6];
        Term_3_lconv_6_ALL = [Term_3_lconv_6_ALL; Term_3_lconv_6];
        R_Bulk_lconv_8_5_ALL = [R_Bulk_lconv_8_5_ALL; R_Bulk_lconv_8_5];
        L_lconv_8_5_ALL = [L_lconv_8_5_ALL; L_lconv_8_5];
        Term_3_lconv_8_5_ALL = [Term_3_lconv_8_5_ALL; Term_3_lconv_8_5];
        R_Bulk_lconv_10_ALL = [R_Bulk_lconv_10_ALL; R_Bulk_lconv_10];
        L_lconv_10_ALL = [L_lconv_10_ALL; L_lconv_10];
        Term_3_lconv_10_ALL = [Term_3_lconv_10_ALL; Term_3_lconv_10];
        R_Bulk_lconv_15_ALL = [R_Bulk_lconv_15_ALL; R_Bulk_lconv_15];
        L_lconv_15_ALL = [L_lconv_15_ALL; L_lconv_15];
        Term_3_lconv_15_ALL = [Term_3_lconv_15_ALL; Term_3_lconv_15];
        R_Bulk_lconv_20_ALL = [R_Bulk_lconv_20_ALL; R_Bulk_lconv_20];
        L_lconv_20_ALL = [L_lconv_20_ALL; L_lconv_20];
        Term_3_lconv_20_ALL = [Term_3_lconv_20_ALL; Term_3_lconv_20];
        
        
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

% October
for daterange = 1001:1031
    %daterange = 1018;
    
    targetDate = num2str(daterange);
    dateStamp = str2double(targetDate);
    %targetDate = strcat('0', targetDate);
    
    % Create file list
    speedfile = strcat(file_dir, filesep, strcat(targetDate, '_Speed.csv'));
    %     directionfile = strcat(file_dir, filesep, strcat(targetDate, '_Direction.csv'));
    temperaturefile = strcat(file_dir, filesep, strcat(targetDate, '_Temperature.csv'));
    windfile = strcat(file_dir, filesep, strcat(targetDate, '_3DWind.csv'));
    %     dustfile = strcat(file_dir, filesep, strcat(targetDate, '_Dustrak.csv'));
    
    % Check the list of the R_Bulk calculations
    init_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    init_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    init_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    init_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
    
    uconv_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    uconv_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    uconv_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    uconv_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
    
    rel_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    rel_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    rel_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    rel_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_6.0-8.5.csv'));   % For 6.0 m to 8.5 m
    rel_E_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_8.5-10.0.csv'));   % For 8.5 m to 10.0 m
    rel_F_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_10.0-15.0.csv'));   % For 10.0 m to 15.0 m
    rel_G_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_15.0-20.0.csv'));   % For 15.0 m to 20.0 m
    
    lconv_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    lconv_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    lconv_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    lconv_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_6.0-8.5.csv'));   % For 6.0 m to 8.5 m
    lconv_E_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_8.5-10.0.csv'));   % For 8.5 m to 10.0 m
    lconv_F_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_10.0-15.0.csv'));   % For 10.0 m to 15.0 m
    lconv_G_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_15.0-20.0.csv'));   % For 15.0 m to 20.0 m
    
    
    
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
    
    
    % Most importantly check on the R_Bulk and other calculations
    
    
    
    
    
    
    
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
        
        
        % Initiation tower
        
        init_A = readtable(init_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        init_B = readtable(init_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        init_C = readtable(init_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        init_D = readtable(init_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        
        uconv_A = readtable(uconv_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        uconv_B = readtable(uconv_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        uconv_C = readtable(uconv_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        uconv_D = readtable(uconv_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        
        rel_A = readtable(rel_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        rel_B = readtable(rel_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        rel_C = readtable(rel_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        rel_D = readtable(rel_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        rel_E = readtable(rel_E_file);
        rel_F = readtable(rel_F_file);
        rel_G = readtable(rel_G_file);
        
        lconv_A = readtable(lconv_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        lconv_B = readtable(lconv_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        lconv_C = readtable(lconv_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        lconv_D = readtable(lconv_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        lconv_E = readtable(lconv_E_file);
        lconv_F = readtable(lconv_F_file);
        lconv_G = readtable(lconv_G_file);
        
        R_Bulk_lconv_1_5 = lconv_A{:, 3};
        L_lconv_1_5 = lconv_A{:, 4};
        Term_3_lconv_1_5 = lconv_A{:, 6};
        
        R_Bulk_lconv_3 = lconv_B{:, 3};
        L_lconv_3 = lconv_B{:, 4};
        Term_3_lconv_3 = lconv_B{:, 6};
        
        R_Bulk_lconv_4_5 = lconv_C{:, 3};
        L_lconv_4_5 = lconv_C{:, 4};
        Term_3_lconv_4_5 = lconv_C{:, 6};
        
        R_Bulk_lconv_6 = lconv_D{:, 3};
        L_lconv_6 = lconv_D{:, 4};
        Term_3_lconv_6 = lconv_D{:, 6};
        
        R_Bulk_lconv_8_5 = lconv_E{:, 3};
        L_lconv_8_5 = lconv_E{:, 4};
        Term_3_lconv_8_5 = lconv_E{:, 6};
        
        R_Bulk_lconv_10 = lconv_F{:, 3};
        L_lconv_10 = lconv_F{:, 4};
        Term_3_lconv_10 = lconv_F{:, 6};
        
        R_Bulk_lconv_15 = lconv_G{:, 3};
        L_lconv_15 = lconv_G{:, 4};
        Term_3_lconv_15 = lconv_G{:, 6};
        
        R_Bulk_lconv_20 = lconv_G{:, 3};
        L_lconv_20 = lconv_G{:, 5};
        Term_3_lconv_20 = lconv_G{:, 7};
        
        R_Bulk_rel_1_5 = rel_A{:, 3};
        L_rel_1_5 = rel_A{:, 4};
        Term_3_rel_1_5 = rel_A{:, 6};
        
        R_Bulk_rel_3 = rel_B{:, 3};
        L_rel_3 = rel_B{:, 4};
        Term_3_rel_3 = rel_B{:, 6};
        
        R_Bulk_rel_4_5 = rel_C{:, 3};
        L_rel_4_5 = rel_C{:, 4};
        Term_3_rel_4_5 = rel_C{:, 6};
        
        R_Bulk_rel_6 = rel_D{:, 3};
        L_rel_6 = rel_D{:, 4};
        Term_3_rel_6 = rel_D{:, 6};
        
        R_Bulk_rel_8_5 = rel_E{:, 3};
        L_rel_8_5 = rel_E{:, 4};
        Term_3_rel_8_5 = rel_E{:, 6};
        
        R_Bulk_rel_10 = rel_F{:, 3};
        L_rel_10 = rel_F{:, 4};
        Term_3_rel_10 = rel_F{:, 6};
        
        R_Bulk_rel_15 = rel_G{:, 3};
        L_rel_15 = rel_G{:, 4};
        Term_3_rel_15 = rel_G{:, 6};
        
        R_Bulk_rel_20 = rel_G{:, 3};
        L_rel_20 = rel_G{:, 5};
        Term_3_rel_20 = rel_G{:, 7};
        
        R_Bulk_init_1_5 = init_A{:, 3};
        L_init_1_5 = init_A{:, 4};
        Term_3_init_1_5 = init_A{:, 6};
        
        R_Bulk_init_3 = init_B{:, 3};
        L_init_3 = init_B{:, 4};
        Term_3_init_3 = init_B{:, 6};
        
        R_Bulk_init_4_5 = init_C{:, 3};
        L_init_4_5 = init_C{:, 4};
        Term_3_init_4_5 = init_C{:, 6};
        
        R_Bulk_init_6 = init_D{:, 3};
        L_init_6 = init_D{:, 4};
        Term_3_init_6 = init_D{:, 6};
        
        R_Bulk_init_10 = init_D{:, 3};
        L_init_10 = init_D{:, 5};
        Term_3_init_10 = init_D{:, 7};
        
        R_Bulk_uconv_1_5 = uconv_A{:, 3};
        L_uconv_1_5 = uconv_A{:, 4};
        Term_3_uconv_1_5 = uconv_A{:, 6};
        
        R_Bulk_uconv_3 = uconv_B{:, 3};
        L_uconv_3 = uconv_B{:, 4};
        Term_3_uconv_3 = uconv_B{:, 6};
        
        R_Bulk_uconv_4_5 = uconv_C{:, 3};
        L_uconv_4_5 = uconv_C{:, 4};
        Term_3_uconv_4_5 = uconv_C{:, 6};
        
        R_Bulk_uconv_6 = uconv_D{:, 3};
        L_uconv_6 = uconv_D{:, 4};
        Term_3_uconv_6 = uconv_D{:, 6};
        
        R_Bulk_uconv_10 = uconv_D{:, 3};
        L_uconv_10 = uconv_D{:, 5};
        Term_3_uconv_10 = uconv_D{:, 7};
        
        
        [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5, R_Bulk_init_1_5, L_init_1_5, Term_3_init_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 213}, windTable{varStartIdx:varEndIdx, 243}, windTable{varStartIdx:varEndIdx, 273}, speedTable{varStartIdx:varEndIdx, 4}, R_Bulk_init_1_5, L_init_1_5, Term_3_init_1_5);
        [Vtke_init_3, TKE_init_3, spd_init_3, R_Bulk_init_3, L_init_3, Term_3_init_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 214}, windTable{varStartIdx:varEndIdx, 244}, windTable{varStartIdx:varEndIdx, 274}, speedTable{varStartIdx:varEndIdx, 5}, R_Bulk_init_3, L_init_3, Term_3_init_3);
        [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5, R_Bulk_init_4_5, L_init_4_5, Term_3_init_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 215}, windTable{varStartIdx:varEndIdx, 245}, windTable{varStartIdx:varEndIdx, 275}, speedTable{varStartIdx:varEndIdx, 6}, R_Bulk_init_4_5, L_init_4_5, Term_3_init_4_5);
        [Vtke_init_6, TKE_init_6, spd_init_6, R_Bulk_init_6, L_init_6, Term_3_init_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 216}, windTable{varStartIdx:varEndIdx, 246}, windTable{varStartIdx:varEndIdx, 276}, speedTable{varStartIdx:varEndIdx, 7}, R_Bulk_init_6, L_init_6, Term_3_init_6);
        [Vtke_init_10, TKE_init_10, spd_init_10, R_Bulk_init_10, L_init_10, Term_3_init_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 217}, windTable{varStartIdx:varEndIdx, 247}, windTable{varStartIdx:varEndIdx, 277}, speedTable{varStartIdx:varEndIdx, 8}, R_Bulk_init_10, L_init_10, Term_3_init_10);
        
        Vtke_init_1_5_ALL = [Vtke_init_1_5_ALL; Vtke_init_1_5];
        TKE_init_1_5_ALL = [TKE_init_1_5_ALL; TKE_init_1_5];
        spd_init_1_5_ALL = [spd_init_1_5_ALL; spd_init_1_5];
        R_Bulk_init_1_5_ALL = [R_Bulk_init_1_5_ALL; R_Bulk_init_1_5];
        L_init_1_5_ALL = [L_init_1_5_ALL; L_init_1_5];
        Term_3_init_1_5_ALL = [Term_3_init_1_5_ALL; Term_3_init_1_5];
        
        Vtke_init_3_ALL = [Vtke_init_3_ALL; Vtke_init_3];
        TKE_init_3_ALL = [TKE_init_3_ALL; TKE_init_3];
        spd_init_3_ALL = [spd_init_3_ALL; spd_init_3];
        R_Bulk_init_3_ALL = [R_Bulk_init_3_ALL; R_Bulk_init_3];
        L_init_3_ALL = [L_init_3_ALL; L_init_3];
        Term_3_init_3_ALL = [Term_3_init_3_ALL; Term_3_init_3];
        
        Vtke_init_4_5_ALL = [Vtke_init_4_5_ALL; Vtke_init_4_5];
        TKE_init_4_5_ALL = [TKE_init_4_5_ALL; TKE_init_4_5];
        spd_init_4_5_ALL = [spd_init_4_5_ALL; spd_init_4_5];
        R_Bulk_init_4_5_ALL = [R_Bulk_init_4_5_ALL; R_Bulk_init_4_5];
        L_init_4_5_ALL = [L_init_4_5_ALL; L_init_4_5];
        Term_3_init_4_5_ALL = [Term_3_init_4_5_ALL; Term_3_init_4_5];
        
        Vtke_init_6_ALL = [Vtke_init_6_ALL; Vtke_init_6];
        TKE_init_6_ALL = [TKE_init_6_ALL; TKE_init_6];
        spd_init_6_ALL = [spd_init_6_ALL; spd_init_6];
        R_Bulk_init_6_ALL = [R_Bulk_init_6_ALL; R_Bulk_init_6];
        L_init_6_ALL = [L_init_6_ALL; L_init_6];
        Term_3_init_6_ALL = [Term_3_init_6_ALL; Term_3_init_6];
        
        Vtke_init_10_ALL = [Vtke_init_10_ALL; Vtke_init_10];
        TKE_init_10_ALL = [TKE_init_10_ALL; TKE_init_10];
        spd_init_10_ALL = [spd_init_10_ALL; spd_init_10];
        R_Bulk_init_10_ALL = [R_Bulk_init_10_ALL; R_Bulk_init_10];
        L_init_10_ALL = [L_init_10_ALL; L_init_10];
        Term_3_init_10_ALL = [Term_3_init_10_ALL; Term_3_init_10];
        
        
        
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
        [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5, R_Bulk_rel_1_5, L_rel_1_5, Term_3_rel_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 219}, windTable{varStartIdx:varEndIdx, 249}, windTable{varStartIdx:varEndIdx, 279}, speedTable{varStartIdx:varEndIdx, 11}, R_Bulk_rel_1_5, L_rel_1_5, Term_3_rel_1_5);
        [Vtke_rel_3, TKE_rel_3, spd_rel_3, R_Bulk_rel_3, L_rel_3, Term_3_rel_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 220}, windTable{varStartIdx:varEndIdx, 250}, windTable{varStartIdx:varEndIdx, 280}, speedTable{varStartIdx:varEndIdx, 12}, R_Bulk_rel_3, L_rel_3, Term_3_rel_3);
        [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5, R_Bulk_rel_4_5, L_rel_4_5, Term_3_rel_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 221}, windTable{varStartIdx:varEndIdx, 251}, windTable{varStartIdx:varEndIdx, 281}, speedTable{varStartIdx:varEndIdx, 13}, R_Bulk_rel_4_5, L_rel_4_5, Term_3_rel_4_5);
        [Vtke_rel_6, TKE_rel_6, spd_rel_6, R_Bulk_rel_6, L_rel_6, Term_3_rel_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 222}, windTable{varStartIdx:varEndIdx, 252}, windTable{varStartIdx:varEndIdx, 282}, speedTable{varStartIdx:varEndIdx, 14}, R_Bulk_rel_6, L_rel_6, Term_3_rel_6);
        [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5, R_Bulk_rel_8_5, L_rel_8_5, Term_3_rel_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 223}, windTable{varStartIdx:varEndIdx, 253}, windTable{varStartIdx:varEndIdx, 283}, speedTable{varStartIdx:varEndIdx, 31}, R_Bulk_rel_8_5, L_rel_8_5, Term_3_rel_8_5);
        [Vtke_rel_10, TKE_rel_10, spd_rel_10, R_Bulk_rel_10, L_rel_10, Term_3_rel_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 224}, windTable{varStartIdx:varEndIdx, 254}, windTable{varStartIdx:varEndIdx, 284}, speedTable{varStartIdx:varEndIdx, 15}, R_Bulk_rel_10, L_rel_10, Term_3_rel_10);
        [Vtke_rel_15, TKE_rel_15, spd_rel_15, R_Bulk_rel_15, L_rel_15, Term_3_rel_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 225}, windTable{varStartIdx:varEndIdx, 255}, windTable{varStartIdx:varEndIdx, 285}, speedTable{varStartIdx:varEndIdx, 33}, R_Bulk_rel_15, L_rel_15, Term_3_rel_15);
        [Vtke_rel_20, TKE_rel_20, spd_rel_20, R_Bulk_rel_20, L_rel_20, Term_3_rel_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 226}, windTable{varStartIdx:varEndIdx, 256}, windTable{varStartIdx:varEndIdx, 286}, speedTable{varStartIdx:varEndIdx, 35}, R_Bulk_rel_20, L_rel_20, Term_3_rel_20);
        
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
        
        R_Bulk_rel_1_5_ALL = [R_Bulk_rel_1_5_ALL; R_Bulk_rel_1_5];
        L_rel_1_5_ALL = [L_rel_1_5_ALL; L_rel_1_5];
        Term_3_rel_1_5_ALL = [Term_3_rel_1_5_ALL; Term_3_rel_1_5];
        R_Bulk_rel_3_ALL = [R_Bulk_rel_3_ALL; R_Bulk_rel_3];
        L_rel_3_ALL = [L_rel_3_ALL; L_rel_3];
        Term_3_rel_3_ALL = [Term_3_rel_3_ALL; Term_3_rel_3];
        R_Bulk_rel_4_5_ALL = [R_Bulk_rel_4_5_ALL; R_Bulk_rel_4_5];
        L_rel_4_5_ALL = [L_rel_4_5_ALL; L_rel_4_5];
        Term_3_rel_4_5_ALL = [Term_3_rel_4_5_ALL; Term_3_rel_4_5];
        R_Bulk_rel_6_ALL = [R_Bulk_rel_6_ALL; R_Bulk_rel_6];
        L_rel_6_ALL = [L_rel_6_ALL; L_rel_6];
        Term_3_rel_6_ALL = [Term_3_rel_6_ALL; Term_3_rel_6];
        R_Bulk_rel_8_5_ALL = [R_Bulk_rel_8_5_ALL; R_Bulk_rel_8_5];
        L_rel_8_5_ALL = [L_rel_8_5_ALL; L_rel_8_5];
        Term_3_rel_8_5_ALL = [Term_3_rel_8_5_ALL; Term_3_rel_8_5];
        R_Bulk_rel_10_ALL = [R_Bulk_rel_10_ALL; R_Bulk_rel_10];
        L_rel_10_ALL = [L_rel_10_ALL; L_rel_10];
        Term_3_rel_10_ALL = [Term_3_rel_10_ALL; Term_3_rel_10];
        R_Bulk_rel_15_ALL = [R_Bulk_rel_15_ALL; R_Bulk_rel_15];
        L_rel_15_ALL = [L_rel_15_ALL; L_rel_15];
        Term_3_rel_15_ALL = [Term_3_rel_15_ALL; Term_3_rel_15];
        R_Bulk_rel_20_ALL = [R_Bulk_rel_20_ALL; R_Bulk_rel_20];
        L_rel_20_ALL = [L_rel_20_ALL; L_rel_20];
        Term_3_rel_20_ALL = [Term_3_rel_20_ALL; Term_3_rel_20];
        
        
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
        [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5, R_Bulk_uconv_1_5, L_uconv_1_5, Term_3_uconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 228}, windTable{varStartIdx:varEndIdx, 258}, windTable{varStartIdx:varEndIdx, 288}, speedTable{varStartIdx:varEndIdx, 18}, R_Bulk_uconv_1_5, L_uconv_1_5, Term_3_uconv_1_5);
        [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3, R_Bulk_uconv_3, L_uconv_3, Term_3_uconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 229}, windTable{varStartIdx:varEndIdx, 259}, windTable{varStartIdx:varEndIdx, 289}, speedTable{varStartIdx:varEndIdx, 19}, R_Bulk_uconv_3, L_uconv_3, Term_3_uconv_3);
        [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5, R_Bulk_uconv_4_5, L_uconv_4_5, Term_3_uconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 230}, windTable{varStartIdx:varEndIdx, 260}, windTable{varStartIdx:varEndIdx, 290}, speedTable{varStartIdx:varEndIdx, 20}, R_Bulk_uconv_4_5, L_uconv_4_5, Term_3_uconv_4_5);
        [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6, R_Bulk_uconv_6, L_uconv_6, Term_3_uconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 231}, windTable{varStartIdx:varEndIdx, 261}, windTable{varStartIdx:varEndIdx, 291}, speedTable{varStartIdx:varEndIdx, 21}, R_Bulk_uconv_6, L_uconv_6, Term_3_uconv_6);
        [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10, R_Bulk_uconv_10, L_uconv_10, Term_3_uconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 232}, windTable{varStartIdx:varEndIdx, 262}, windTable{varStartIdx:varEndIdx, 292}, speedTable{varStartIdx:varEndIdx, 22}, R_Bulk_uconv_10, L_uconv_10, Term_3_uconv_10);
        
        
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
        
        R_Bulk_uconv_1_5_ALL = [R_Bulk_uconv_1_5_ALL; R_Bulk_uconv_1_5];
        L_uconv_1_5_ALL = [L_uconv_1_5_ALL; L_uconv_1_5];
        Term_3_uconv_1_5_ALL = [Term_3_uconv_1_5_ALL; Term_3_uconv_1_5];
        R_Bulk_uconv_3_ALL = [R_Bulk_uconv_3_ALL; R_Bulk_uconv_3];
        L_uconv_3_ALL = [L_uconv_3_ALL; L_uconv_3];
        Term_3_uconv_3_ALL = [Term_3_uconv_3_ALL; Term_3_uconv_3];
        R_Bulk_uconv_4_5_ALL = [R_Bulk_uconv_4_5_ALL; R_Bulk_uconv_4_5];
        L_uconv_4_5_ALL = [L_uconv_4_5_ALL; L_uconv_4_5];
        Term_3_uconv_4_5_ALL = [Term_3_uconv_4_5_ALL; Term_3_uconv_4_5];
        R_Bulk_uconv_6_ALL = [R_Bulk_uconv_6_ALL; R_Bulk_uconv_6];
        L_uconv_6_ALL = [L_uconv_6_ALL; L_uconv_6];
        Term_3_uconv_6_ALL = [Term_3_uconv_6_ALL; Term_3_uconv_6];
        R_Bulk_uconv_10_ALL = [R_Bulk_uconv_10_ALL; R_Bulk_uconv_10];
        L_uconv_10_ALL = [L_uconv_10_ALL; L_uconv_10];
        Term_3_uconv_10_ALL = [Term_3_uconv_10_ALL; Term_3_uconv_10];
        
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
        [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5, R_Bulk_lconv_1_5, L_lconv_1_5, Term_3_lconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 234}, windTable{varStartIdx:varEndIdx, 264}, windTable{varStartIdx:varEndIdx, 294}, speedTable{varStartIdx:varEndIdx, 25}, R_Bulk_lconv_1_5, L_lconv_1_5, Term_3_lconv_1_5);
        [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3, R_Bulk_lconv_3, L_lconv_3, Term_3_lconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 235}, windTable{varStartIdx:varEndIdx, 265}, windTable{varStartIdx:varEndIdx, 295}, speedTable{varStartIdx:varEndIdx, 26}, R_Bulk_lconv_3, L_lconv_3, Term_3_lconv_3);
        [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5, R_Bulk_lconv_4_5, L_lconv_4_5, Term_3_lconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 236}, windTable{varStartIdx:varEndIdx, 266}, windTable{varStartIdx:varEndIdx, 296}, speedTable{varStartIdx:varEndIdx, 27}, R_Bulk_lconv_4_5, L_lconv_4_5, Term_3_lconv_4_5);
        [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6, R_Bulk_lconv_6, L_lconv_6, Term_3_lconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 237}, windTable{varStartIdx:varEndIdx, 267}, windTable{varStartIdx:varEndIdx, 297}, speedTable{varStartIdx:varEndIdx, 28}, R_Bulk_lconv_6, L_lconv_6, Term_3_lconv_6);
        [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5, R_Bulk_lconv_8_5, L_lconv_8_5, Term_3_lconv_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 238}, windTable{varStartIdx:varEndIdx, 268}, windTable{varStartIdx:varEndIdx, 298}, speedTable{varStartIdx:varEndIdx, 32}, R_Bulk_lconv_8_5, L_lconv_8_5, Term_3_lconv_8_5);
        [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10, R_Bulk_lconv_10, L_lconv_10, Term_3_lconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 239}, windTable{varStartIdx:varEndIdx, 269}, windTable{varStartIdx:varEndIdx, 299}, speedTable{varStartIdx:varEndIdx, 29}, R_Bulk_lconv_10, L_lconv_10, Term_3_lconv_10);
        [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15, R_Bulk_lconv_15, L_lconv_15, Term_3_lconv_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 240}, windTable{varStartIdx:varEndIdx, 270}, windTable{varStartIdx:varEndIdx, 300}, speedTable{varStartIdx:varEndIdx, 34}, R_Bulk_lconv_15, L_lconv_15, Term_3_lconv_15);
        [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20, R_Bulk_lconv_20, L_lconv_20, Term_3_lconv_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 241}, windTable{varStartIdx:varEndIdx, 271}, windTable{varStartIdx:varEndIdx, 301}, speedTable{varStartIdx:varEndIdx, 36}, R_Bulk_lconv_20, L_lconv_20, Term_3_lconv_20);
        
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
        
        R_Bulk_lconv_1_5_ALL = [R_Bulk_lconv_1_5_ALL; R_Bulk_lconv_1_5];
        L_lconv_1_5_ALL = [L_lconv_1_5_ALL; L_lconv_1_5];
        Term_3_lconv_1_5_ALL = [Term_3_lconv_1_5_ALL; Term_3_lconv_1_5];
        R_Bulk_lconv_3_ALL = [R_Bulk_lconv_3_ALL; R_Bulk_lconv_3];
        L_lconv_3_ALL = [L_lconv_3_ALL; L_lconv_3];
        Term_3_lconv_3_ALL = [Term_3_lconv_3_ALL; Term_3_lconv_3];
        R_Bulk_lconv_4_5_ALL = [R_Bulk_lconv_4_5_ALL; R_Bulk_lconv_4_5];
        L_lconv_4_5_ALL = [L_lconv_4_5_ALL; L_lconv_4_5];
        Term_3_lconv_4_5_ALL = [Term_3_lconv_4_5_ALL; Term_3_lconv_4_5];
        R_Bulk_lconv_6_ALL = [R_Bulk_lconv_6_ALL; R_Bulk_lconv_6];
        L_lconv_6_ALL = [L_lconv_6_ALL; L_lconv_6];
        Term_3_lconv_6_ALL = [Term_3_lconv_6_ALL; Term_3_lconv_6];
        R_Bulk_lconv_8_5_ALL = [R_Bulk_lconv_8_5_ALL; R_Bulk_lconv_8_5];
        L_lconv_8_5_ALL = [L_lconv_8_5_ALL; L_lconv_8_5];
        Term_3_lconv_8_5_ALL = [Term_3_lconv_8_5_ALL; Term_3_lconv_8_5];
        R_Bulk_lconv_10_ALL = [R_Bulk_lconv_10_ALL; R_Bulk_lconv_10];
        L_lconv_10_ALL = [L_lconv_10_ALL; L_lconv_10];
        Term_3_lconv_10_ALL = [Term_3_lconv_10_ALL; Term_3_lconv_10];
        R_Bulk_lconv_15_ALL = [R_Bulk_lconv_15_ALL; R_Bulk_lconv_15];
        L_lconv_15_ALL = [L_lconv_15_ALL; L_lconv_15];
        Term_3_lconv_15_ALL = [Term_3_lconv_15_ALL; Term_3_lconv_15];
        R_Bulk_lconv_20_ALL = [R_Bulk_lconv_20_ALL; R_Bulk_lconv_20];
        L_lconv_20_ALL = [L_lconv_20_ALL; L_lconv_20];
        Term_3_lconv_20_ALL = [Term_3_lconv_20_ALL; Term_3_lconv_20];
        
        
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

% Half November
for daterange = 1101:1112
    %daterange = 1018;
    
    targetDate = num2str(daterange);
    dateStamp = str2double(targetDate);
    %targetDate = strcat('0', targetDate);
    
    % Create file list
    speedfile = strcat(file_dir, filesep, strcat(targetDate, '_Speed.csv'));
    %     directionfile = strcat(file_dir, filesep, strcat(targetDate, '_Direction.csv'));
    temperaturefile = strcat(file_dir, filesep, strcat(targetDate, '_Temperature.csv'));
    windfile = strcat(file_dir, filesep, strcat(targetDate, '_3DWind.csv'));
    %     dustfile = strcat(file_dir, filesep, strcat(targetDate, '_Dustrak.csv'));
    
    % Check the list of the R_Bulk calculations
    init_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    init_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    init_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    init_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
    
    uconv_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    uconv_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    uconv_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    uconv_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
    
    rel_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    rel_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    rel_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    rel_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_6.0-8.5.csv'));   % For 6.0 m to 8.5 m
    rel_E_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_8.5-10.0.csv'));   % For 8.5 m to 10.0 m
    rel_F_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_10.0-15.0.csv'));   % For 10.0 m to 15.0 m
    rel_G_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_15.0-20.0.csv'));   % For 15.0 m to 20.0 m
    
    lconv_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    lconv_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    lconv_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    lconv_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_6.0-8.5.csv'));   % For 6.0 m to 8.5 m
    lconv_E_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_8.5-10.0.csv'));   % For 8.5 m to 10.0 m
    lconv_F_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_10.0-15.0.csv'));   % For 10.0 m to 15.0 m
    lconv_G_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_15.0-20.0.csv'));   % For 15.0 m to 20.0 m
    
    
    
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
    
    
    % Most importantly check on the R_Bulk and other calculations
    
    
    
    
    
    
    
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
        
        
        % Initiation tower
        
        init_A = readtable(init_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        init_B = readtable(init_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        init_C = readtable(init_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        init_D = readtable(init_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        
        uconv_A = readtable(uconv_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        uconv_B = readtable(uconv_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        uconv_C = readtable(uconv_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        uconv_D = readtable(uconv_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        
        rel_A = readtable(rel_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        rel_B = readtable(rel_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        rel_C = readtable(rel_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        rel_D = readtable(rel_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        rel_E = readtable(rel_E_file);
        rel_F = readtable(rel_F_file);
        rel_G = readtable(rel_G_file);
        
        lconv_A = readtable(lconv_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        lconv_B = readtable(lconv_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        lconv_C = readtable(lconv_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        lconv_D = readtable(lconv_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        lconv_E = readtable(lconv_E_file);
        lconv_F = readtable(lconv_F_file);
        lconv_G = readtable(lconv_G_file);
        
        R_Bulk_lconv_1_5 = lconv_A{:, 3};
        L_lconv_1_5 = lconv_A{:, 4};
        Term_3_lconv_1_5 = lconv_A{:, 6};
        
        R_Bulk_lconv_3 = lconv_B{:, 3};
        L_lconv_3 = lconv_B{:, 4};
        Term_3_lconv_3 = lconv_B{:, 6};
        
        R_Bulk_lconv_4_5 = lconv_C{:, 3};
        L_lconv_4_5 = lconv_C{:, 4};
        Term_3_lconv_4_5 = lconv_C{:, 6};
        
        R_Bulk_lconv_6 = lconv_D{:, 3};
        L_lconv_6 = lconv_D{:, 4};
        Term_3_lconv_6 = lconv_D{:, 6};
        
        R_Bulk_lconv_8_5 = lconv_E{:, 3};
        L_lconv_8_5 = lconv_E{:, 4};
        Term_3_lconv_8_5 = lconv_E{:, 6};
        
        R_Bulk_lconv_10 = lconv_F{:, 3};
        L_lconv_10 = lconv_F{:, 4};
        Term_3_lconv_10 = lconv_F{:, 6};
        
        R_Bulk_lconv_15 = lconv_G{:, 3};
        L_lconv_15 = lconv_G{:, 4};
        Term_3_lconv_15 = lconv_G{:, 6};
        
        R_Bulk_lconv_20 = lconv_G{:, 3};
        L_lconv_20 = lconv_G{:, 5};
        Term_3_lconv_20 = lconv_G{:, 7};
        
        R_Bulk_rel_1_5 = rel_A{:, 3};
        L_rel_1_5 = rel_A{:, 4};
        Term_3_rel_1_5 = rel_A{:, 6};
        
        R_Bulk_rel_3 = rel_B{:, 3};
        L_rel_3 = rel_B{:, 4};
        Term_3_rel_3 = rel_B{:, 6};
        
        R_Bulk_rel_4_5 = rel_C{:, 3};
        L_rel_4_5 = rel_C{:, 4};
        Term_3_rel_4_5 = rel_C{:, 6};
        
        R_Bulk_rel_6 = rel_D{:, 3};
        L_rel_6 = rel_D{:, 4};
        Term_3_rel_6 = rel_D{:, 6};
        
        R_Bulk_rel_8_5 = rel_E{:, 3};
        L_rel_8_5 = rel_E{:, 4};
        Term_3_rel_8_5 = rel_E{:, 6};
        
        R_Bulk_rel_10 = rel_F{:, 3};
        L_rel_10 = rel_F{:, 4};
        Term_3_rel_10 = rel_F{:, 6};
        
        R_Bulk_rel_15 = rel_G{:, 3};
        L_rel_15 = rel_G{:, 4};
        Term_3_rel_15 = rel_G{:, 6};
        
        R_Bulk_rel_20 = rel_G{:, 3};
        L_rel_20 = rel_G{:, 5};
        Term_3_rel_20 = rel_G{:, 7};
        
        R_Bulk_init_1_5 = init_A{:, 3};
        L_init_1_5 = init_A{:, 4};
        Term_3_init_1_5 = init_A{:, 6};
        
        R_Bulk_init_3 = init_B{:, 3};
        L_init_3 = init_B{:, 4};
        Term_3_init_3 = init_B{:, 6};
        
        R_Bulk_init_4_5 = init_C{:, 3};
        L_init_4_5 = init_C{:, 4};
        Term_3_init_4_5 = init_C{:, 6};
        
        R_Bulk_init_6 = init_D{:, 3};
        L_init_6 = init_D{:, 4};
        Term_3_init_6 = init_D{:, 6};
        
        R_Bulk_init_10 = init_D{:, 3};
        L_init_10 = init_D{:, 5};
        Term_3_init_10 = init_D{:, 7};
        
        R_Bulk_uconv_1_5 = uconv_A{:, 3};
        L_uconv_1_5 = uconv_A{:, 4};
        Term_3_uconv_1_5 = uconv_A{:, 6};
        
        R_Bulk_uconv_3 = uconv_B{:, 3};
        L_uconv_3 = uconv_B{:, 4};
        Term_3_uconv_3 = uconv_B{:, 6};
        
        R_Bulk_uconv_4_5 = uconv_C{:, 3};
        L_uconv_4_5 = uconv_C{:, 4};
        Term_3_uconv_4_5 = uconv_C{:, 6};
        
        R_Bulk_uconv_6 = uconv_D{:, 3};
        L_uconv_6 = uconv_D{:, 4};
        Term_3_uconv_6 = uconv_D{:, 6};
        
        R_Bulk_uconv_10 = uconv_D{:, 3};
        L_uconv_10 = uconv_D{:, 5};
        Term_3_uconv_10 = uconv_D{:, 7};
        
        
        [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5, R_Bulk_init_1_5, L_init_1_5, Term_3_init_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 213}, windTable{varStartIdx:varEndIdx, 243}, windTable{varStartIdx:varEndIdx, 273}, speedTable{varStartIdx:varEndIdx, 4}, R_Bulk_init_1_5, L_init_1_5, Term_3_init_1_5);
        [Vtke_init_3, TKE_init_3, spd_init_3, R_Bulk_init_3, L_init_3, Term_3_init_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 214}, windTable{varStartIdx:varEndIdx, 244}, windTable{varStartIdx:varEndIdx, 274}, speedTable{varStartIdx:varEndIdx, 5}, R_Bulk_init_3, L_init_3, Term_3_init_3);
        [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5, R_Bulk_init_4_5, L_init_4_5, Term_3_init_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 215}, windTable{varStartIdx:varEndIdx, 245}, windTable{varStartIdx:varEndIdx, 275}, speedTable{varStartIdx:varEndIdx, 6}, R_Bulk_init_4_5, L_init_4_5, Term_3_init_4_5);
        [Vtke_init_6, TKE_init_6, spd_init_6, R_Bulk_init_6, L_init_6, Term_3_init_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 216}, windTable{varStartIdx:varEndIdx, 246}, windTable{varStartIdx:varEndIdx, 276}, speedTable{varStartIdx:varEndIdx, 7}, R_Bulk_init_6, L_init_6, Term_3_init_6);
        [Vtke_init_10, TKE_init_10, spd_init_10, R_Bulk_init_10, L_init_10, Term_3_init_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 217}, windTable{varStartIdx:varEndIdx, 247}, windTable{varStartIdx:varEndIdx, 277}, speedTable{varStartIdx:varEndIdx, 8}, R_Bulk_init_10, L_init_10, Term_3_init_10);
        
        Vtke_init_1_5_ALL = [Vtke_init_1_5_ALL; Vtke_init_1_5];
        TKE_init_1_5_ALL = [TKE_init_1_5_ALL; TKE_init_1_5];
        spd_init_1_5_ALL = [spd_init_1_5_ALL; spd_init_1_5];
        R_Bulk_init_1_5_ALL = [R_Bulk_init_1_5_ALL; R_Bulk_init_1_5];
        L_init_1_5_ALL = [L_init_1_5_ALL; L_init_1_5];
        Term_3_init_1_5_ALL = [Term_3_init_1_5_ALL; Term_3_init_1_5];
        
        Vtke_init_3_ALL = [Vtke_init_3_ALL; Vtke_init_3];
        TKE_init_3_ALL = [TKE_init_3_ALL; TKE_init_3];
        spd_init_3_ALL = [spd_init_3_ALL; spd_init_3];
        R_Bulk_init_3_ALL = [R_Bulk_init_3_ALL; R_Bulk_init_3];
        L_init_3_ALL = [L_init_3_ALL; L_init_3];
        Term_3_init_3_ALL = [Term_3_init_3_ALL; Term_3_init_3];
        
        Vtke_init_4_5_ALL = [Vtke_init_4_5_ALL; Vtke_init_4_5];
        TKE_init_4_5_ALL = [TKE_init_4_5_ALL; TKE_init_4_5];
        spd_init_4_5_ALL = [spd_init_4_5_ALL; spd_init_4_5];
        R_Bulk_init_4_5_ALL = [R_Bulk_init_4_5_ALL; R_Bulk_init_4_5];
        L_init_4_5_ALL = [L_init_4_5_ALL; L_init_4_5];
        Term_3_init_4_5_ALL = [Term_3_init_4_5_ALL; Term_3_init_4_5];
        
        Vtke_init_6_ALL = [Vtke_init_6_ALL; Vtke_init_6];
        TKE_init_6_ALL = [TKE_init_6_ALL; TKE_init_6];
        spd_init_6_ALL = [spd_init_6_ALL; spd_init_6];
        R_Bulk_init_6_ALL = [R_Bulk_init_6_ALL; R_Bulk_init_6];
        L_init_6_ALL = [L_init_6_ALL; L_init_6];
        Term_3_init_6_ALL = [Term_3_init_6_ALL; Term_3_init_6];
        
        Vtke_init_10_ALL = [Vtke_init_10_ALL; Vtke_init_10];
        TKE_init_10_ALL = [TKE_init_10_ALL; TKE_init_10];
        spd_init_10_ALL = [spd_init_10_ALL; spd_init_10];
        R_Bulk_init_10_ALL = [R_Bulk_init_10_ALL; R_Bulk_init_10];
        L_init_10_ALL = [L_init_10_ALL; L_init_10];
        Term_3_init_10_ALL = [Term_3_init_10_ALL; Term_3_init_10];
        
        
        
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
        [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5, R_Bulk_rel_1_5, L_rel_1_5, Term_3_rel_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 219}, windTable{varStartIdx:varEndIdx, 249}, windTable{varStartIdx:varEndIdx, 279}, speedTable{varStartIdx:varEndIdx, 11}, R_Bulk_rel_1_5, L_rel_1_5, Term_3_rel_1_5);
        [Vtke_rel_3, TKE_rel_3, spd_rel_3, R_Bulk_rel_3, L_rel_3, Term_3_rel_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 220}, windTable{varStartIdx:varEndIdx, 250}, windTable{varStartIdx:varEndIdx, 280}, speedTable{varStartIdx:varEndIdx, 12}, R_Bulk_rel_3, L_rel_3, Term_3_rel_3);
        [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5, R_Bulk_rel_4_5, L_rel_4_5, Term_3_rel_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 221}, windTable{varStartIdx:varEndIdx, 251}, windTable{varStartIdx:varEndIdx, 281}, speedTable{varStartIdx:varEndIdx, 13}, R_Bulk_rel_4_5, L_rel_4_5, Term_3_rel_4_5);
        [Vtke_rel_6, TKE_rel_6, spd_rel_6, R_Bulk_rel_6, L_rel_6, Term_3_rel_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 222}, windTable{varStartIdx:varEndIdx, 252}, windTable{varStartIdx:varEndIdx, 282}, speedTable{varStartIdx:varEndIdx, 14}, R_Bulk_rel_6, L_rel_6, Term_3_rel_6);
        [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5, R_Bulk_rel_8_5, L_rel_8_5, Term_3_rel_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 223}, windTable{varStartIdx:varEndIdx, 253}, windTable{varStartIdx:varEndIdx, 283}, speedTable{varStartIdx:varEndIdx, 31}, R_Bulk_rel_8_5, L_rel_8_5, Term_3_rel_8_5);
        [Vtke_rel_10, TKE_rel_10, spd_rel_10, R_Bulk_rel_10, L_rel_10, Term_3_rel_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 224}, windTable{varStartIdx:varEndIdx, 254}, windTable{varStartIdx:varEndIdx, 284}, speedTable{varStartIdx:varEndIdx, 15}, R_Bulk_rel_10, L_rel_10, Term_3_rel_10);
        [Vtke_rel_15, TKE_rel_15, spd_rel_15, R_Bulk_rel_15, L_rel_15, Term_3_rel_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 225}, windTable{varStartIdx:varEndIdx, 255}, windTable{varStartIdx:varEndIdx, 285}, speedTable{varStartIdx:varEndIdx, 33}, R_Bulk_rel_15, L_rel_15, Term_3_rel_15);
        [Vtke_rel_20, TKE_rel_20, spd_rel_20, R_Bulk_rel_20, L_rel_20, Term_3_rel_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 226}, windTable{varStartIdx:varEndIdx, 256}, windTable{varStartIdx:varEndIdx, 286}, speedTable{varStartIdx:varEndIdx, 35}, R_Bulk_rel_20, L_rel_20, Term_3_rel_20);
        
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
        
        R_Bulk_rel_1_5_ALL = [R_Bulk_rel_1_5_ALL; R_Bulk_rel_1_5];
        L_rel_1_5_ALL = [L_rel_1_5_ALL; L_rel_1_5];
        Term_3_rel_1_5_ALL = [Term_3_rel_1_5_ALL; Term_3_rel_1_5];
        R_Bulk_rel_3_ALL = [R_Bulk_rel_3_ALL; R_Bulk_rel_3];
        L_rel_3_ALL = [L_rel_3_ALL; L_rel_3];
        Term_3_rel_3_ALL = [Term_3_rel_3_ALL; Term_3_rel_3];
        R_Bulk_rel_4_5_ALL = [R_Bulk_rel_4_5_ALL; R_Bulk_rel_4_5];
        L_rel_4_5_ALL = [L_rel_4_5_ALL; L_rel_4_5];
        Term_3_rel_4_5_ALL = [Term_3_rel_4_5_ALL; Term_3_rel_4_5];
        R_Bulk_rel_6_ALL = [R_Bulk_rel_6_ALL; R_Bulk_rel_6];
        L_rel_6_ALL = [L_rel_6_ALL; L_rel_6];
        Term_3_rel_6_ALL = [Term_3_rel_6_ALL; Term_3_rel_6];
        R_Bulk_rel_8_5_ALL = [R_Bulk_rel_8_5_ALL; R_Bulk_rel_8_5];
        L_rel_8_5_ALL = [L_rel_8_5_ALL; L_rel_8_5];
        Term_3_rel_8_5_ALL = [Term_3_rel_8_5_ALL; Term_3_rel_8_5];
        R_Bulk_rel_10_ALL = [R_Bulk_rel_10_ALL; R_Bulk_rel_10];
        L_rel_10_ALL = [L_rel_10_ALL; L_rel_10];
        Term_3_rel_10_ALL = [Term_3_rel_10_ALL; Term_3_rel_10];
        R_Bulk_rel_15_ALL = [R_Bulk_rel_15_ALL; R_Bulk_rel_15];
        L_rel_15_ALL = [L_rel_15_ALL; L_rel_15];
        Term_3_rel_15_ALL = [Term_3_rel_15_ALL; Term_3_rel_15];
        R_Bulk_rel_20_ALL = [R_Bulk_rel_20_ALL; R_Bulk_rel_20];
        L_rel_20_ALL = [L_rel_20_ALL; L_rel_20];
        Term_3_rel_20_ALL = [Term_3_rel_20_ALL; Term_3_rel_20];
        
        
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
        [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5, R_Bulk_uconv_1_5, L_uconv_1_5, Term_3_uconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 228}, windTable{varStartIdx:varEndIdx, 258}, windTable{varStartIdx:varEndIdx, 288}, speedTable{varStartIdx:varEndIdx, 18}, R_Bulk_uconv_1_5, L_uconv_1_5, Term_3_uconv_1_5);
        [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3, R_Bulk_uconv_3, L_uconv_3, Term_3_uconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 229}, windTable{varStartIdx:varEndIdx, 259}, windTable{varStartIdx:varEndIdx, 289}, speedTable{varStartIdx:varEndIdx, 19}, R_Bulk_uconv_3, L_uconv_3, Term_3_uconv_3);
        [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5, R_Bulk_uconv_4_5, L_uconv_4_5, Term_3_uconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 230}, windTable{varStartIdx:varEndIdx, 260}, windTable{varStartIdx:varEndIdx, 290}, speedTable{varStartIdx:varEndIdx, 20}, R_Bulk_uconv_4_5, L_uconv_4_5, Term_3_uconv_4_5);
        [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6, R_Bulk_uconv_6, L_uconv_6, Term_3_uconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 231}, windTable{varStartIdx:varEndIdx, 261}, windTable{varStartIdx:varEndIdx, 291}, speedTable{varStartIdx:varEndIdx, 21}, R_Bulk_uconv_6, L_uconv_6, Term_3_uconv_6);
        [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10, R_Bulk_uconv_10, L_uconv_10, Term_3_uconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 232}, windTable{varStartIdx:varEndIdx, 262}, windTable{varStartIdx:varEndIdx, 292}, speedTable{varStartIdx:varEndIdx, 22}, R_Bulk_uconv_10, L_uconv_10, Term_3_uconv_10);
        
        
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
        
        R_Bulk_uconv_1_5_ALL = [R_Bulk_uconv_1_5_ALL; R_Bulk_uconv_1_5];
        L_uconv_1_5_ALL = [L_uconv_1_5_ALL; L_uconv_1_5];
        Term_3_uconv_1_5_ALL = [Term_3_uconv_1_5_ALL; Term_3_uconv_1_5];
        R_Bulk_uconv_3_ALL = [R_Bulk_uconv_3_ALL; R_Bulk_uconv_3];
        L_uconv_3_ALL = [L_uconv_3_ALL; L_uconv_3];
        Term_3_uconv_3_ALL = [Term_3_uconv_3_ALL; Term_3_uconv_3];
        R_Bulk_uconv_4_5_ALL = [R_Bulk_uconv_4_5_ALL; R_Bulk_uconv_4_5];
        L_uconv_4_5_ALL = [L_uconv_4_5_ALL; L_uconv_4_5];
        Term_3_uconv_4_5_ALL = [Term_3_uconv_4_5_ALL; Term_3_uconv_4_5];
        R_Bulk_uconv_6_ALL = [R_Bulk_uconv_6_ALL; R_Bulk_uconv_6];
        L_uconv_6_ALL = [L_uconv_6_ALL; L_uconv_6];
        Term_3_uconv_6_ALL = [Term_3_uconv_6_ALL; Term_3_uconv_6];
        R_Bulk_uconv_10_ALL = [R_Bulk_uconv_10_ALL; R_Bulk_uconv_10];
        L_uconv_10_ALL = [L_uconv_10_ALL; L_uconv_10];
        Term_3_uconv_10_ALL = [Term_3_uconv_10_ALL; Term_3_uconv_10];
        
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
        [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5, R_Bulk_lconv_1_5, L_lconv_1_5, Term_3_lconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 234}, windTable{varStartIdx:varEndIdx, 264}, windTable{varStartIdx:varEndIdx, 294}, speedTable{varStartIdx:varEndIdx, 25}, R_Bulk_lconv_1_5, L_lconv_1_5, Term_3_lconv_1_5);
        [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3, R_Bulk_lconv_3, L_lconv_3, Term_3_lconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 235}, windTable{varStartIdx:varEndIdx, 265}, windTable{varStartIdx:varEndIdx, 295}, speedTable{varStartIdx:varEndIdx, 26}, R_Bulk_lconv_3, L_lconv_3, Term_3_lconv_3);
        [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5, R_Bulk_lconv_4_5, L_lconv_4_5, Term_3_lconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 236}, windTable{varStartIdx:varEndIdx, 266}, windTable{varStartIdx:varEndIdx, 296}, speedTable{varStartIdx:varEndIdx, 27}, R_Bulk_lconv_4_5, L_lconv_4_5, Term_3_lconv_4_5);
        [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6, R_Bulk_lconv_6, L_lconv_6, Term_3_lconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 237}, windTable{varStartIdx:varEndIdx, 267}, windTable{varStartIdx:varEndIdx, 297}, speedTable{varStartIdx:varEndIdx, 28}, R_Bulk_lconv_6, L_lconv_6, Term_3_lconv_6);
        [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5, R_Bulk_lconv_8_5, L_lconv_8_5, Term_3_lconv_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 238}, windTable{varStartIdx:varEndIdx, 268}, windTable{varStartIdx:varEndIdx, 298}, speedTable{varStartIdx:varEndIdx, 32}, R_Bulk_lconv_8_5, L_lconv_8_5, Term_3_lconv_8_5);
        [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10, R_Bulk_lconv_10, L_lconv_10, Term_3_lconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 239}, windTable{varStartIdx:varEndIdx, 269}, windTable{varStartIdx:varEndIdx, 299}, speedTable{varStartIdx:varEndIdx, 29}, R_Bulk_lconv_10, L_lconv_10, Term_3_lconv_10);
        [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15, R_Bulk_lconv_15, L_lconv_15, Term_3_lconv_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 240}, windTable{varStartIdx:varEndIdx, 270}, windTable{varStartIdx:varEndIdx, 300}, speedTable{varStartIdx:varEndIdx, 34}, R_Bulk_lconv_15, L_lconv_15, Term_3_lconv_15);
        [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20, R_Bulk_lconv_20, L_lconv_20, Term_3_lconv_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 241}, windTable{varStartIdx:varEndIdx, 271}, windTable{varStartIdx:varEndIdx, 301}, speedTable{varStartIdx:varEndIdx, 36}, R_Bulk_lconv_20, L_lconv_20, Term_3_lconv_20);
        
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
        
        R_Bulk_lconv_1_5_ALL = [R_Bulk_lconv_1_5_ALL; R_Bulk_lconv_1_5];
        L_lconv_1_5_ALL = [L_lconv_1_5_ALL; L_lconv_1_5];
        Term_3_lconv_1_5_ALL = [Term_3_lconv_1_5_ALL; Term_3_lconv_1_5];
        R_Bulk_lconv_3_ALL = [R_Bulk_lconv_3_ALL; R_Bulk_lconv_3];
        L_lconv_3_ALL = [L_lconv_3_ALL; L_lconv_3];
        Term_3_lconv_3_ALL = [Term_3_lconv_3_ALL; Term_3_lconv_3];
        R_Bulk_lconv_4_5_ALL = [R_Bulk_lconv_4_5_ALL; R_Bulk_lconv_4_5];
        L_lconv_4_5_ALL = [L_lconv_4_5_ALL; L_lconv_4_5];
        Term_3_lconv_4_5_ALL = [Term_3_lconv_4_5_ALL; Term_3_lconv_4_5];
        R_Bulk_lconv_6_ALL = [R_Bulk_lconv_6_ALL; R_Bulk_lconv_6];
        L_lconv_6_ALL = [L_lconv_6_ALL; L_lconv_6];
        Term_3_lconv_6_ALL = [Term_3_lconv_6_ALL; Term_3_lconv_6];
        R_Bulk_lconv_8_5_ALL = [R_Bulk_lconv_8_5_ALL; R_Bulk_lconv_8_5];
        L_lconv_8_5_ALL = [L_lconv_8_5_ALL; L_lconv_8_5];
        Term_3_lconv_8_5_ALL = [Term_3_lconv_8_5_ALL; Term_3_lconv_8_5];
        R_Bulk_lconv_10_ALL = [R_Bulk_lconv_10_ALL; R_Bulk_lconv_10];
        L_lconv_10_ALL = [L_lconv_10_ALL; L_lconv_10];
        Term_3_lconv_10_ALL = [Term_3_lconv_10_ALL; Term_3_lconv_10];
        R_Bulk_lconv_15_ALL = [R_Bulk_lconv_15_ALL; R_Bulk_lconv_15];
        L_lconv_15_ALL = [L_lconv_15_ALL; L_lconv_15];
        Term_3_lconv_15_ALL = [Term_3_lconv_15_ALL; Term_3_lconv_15];
        R_Bulk_lconv_20_ALL = [R_Bulk_lconv_20_ALL; R_Bulk_lconv_20];
        L_lconv_20_ALL = [L_lconv_20_ALL; L_lconv_20];
        Term_3_lconv_20_ALL = [Term_3_lconv_20_ALL; Term_3_lconv_20];
        
        
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

% Half November
for daterange = 1114:1123
    %daterange = 1018;
    
    targetDate = num2str(daterange);
    dateStamp = str2double(targetDate);
    %targetDate = strcat('0', targetDate);
    
    % Create file list
    speedfile = strcat(file_dir, filesep, strcat(targetDate, '_Speed.csv'));
    %     directionfile = strcat(file_dir, filesep, strcat(targetDate, '_Direction.csv'));
    temperaturefile = strcat(file_dir, filesep, strcat(targetDate, '_Temperature.csv'));
    windfile = strcat(file_dir, filesep, strcat(targetDate, '_3DWind.csv'));
    %     dustfile = strcat(file_dir, filesep, strcat(targetDate, '_Dustrak.csv'));
    
    % Check the list of the R_Bulk calculations
    init_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    init_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    init_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    init_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
    
    uconv_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    uconv_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    uconv_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    uconv_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
    
    rel_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    rel_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    rel_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    rel_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_6.0-8.5.csv'));   % For 6.0 m to 8.5 m
    rel_E_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_8.5-10.0.csv'));   % For 8.5 m to 10.0 m
    rel_F_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_10.0-15.0.csv'));   % For 10.0 m to 15.0 m
    rel_G_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_15.0-20.0.csv'));   % For 15.0 m to 20.0 m
    
    lconv_A_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
    lconv_B_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
    lconv_C_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
    lconv_D_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_6.0-8.5.csv'));   % For 6.0 m to 8.5 m
    lconv_E_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_8.5-10.0.csv'));   % For 8.5 m to 10.0 m
    lconv_F_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_10.0-15.0.csv'));   % For 10.0 m to 15.0 m
    lconv_G_file = strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_15.0-20.0.csv'));   % For 15.0 m to 20.0 m
    
    
    
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
    
    
    % Most importantly check on the R_Bulk and other calculations
    
    
    
    
    
    
    
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
        
        
        % Initiation tower
        
        init_A = readtable(init_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        init_B = readtable(init_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        init_C = readtable(init_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        init_D = readtable(init_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_init_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        
        uconv_A = readtable(uconv_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        uconv_B = readtable(uconv_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        uconv_C = readtable(uconv_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        uconv_D = readtable(uconv_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_uconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        
        rel_A = readtable(rel_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        rel_B = readtable(rel_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        rel_C = readtable(rel_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        rel_D = readtable(rel_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_rel_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        rel_E = readtable(rel_E_file);
        rel_F = readtable(rel_F_file);
        rel_G = readtable(rel_G_file);
        
        lconv_A = readtable(lconv_A_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_1.5-3.0.csv'));   % For 1.5 m to 3.0 m
        lconv_B = readtable(lconv_B_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_3.0-4.5.csv'));   % For 3.0 m to 4.5 m
        lconv_C = readtable(lconv_C_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_4.5-6.0.csv'));   % For 4.5 m to 6.0 m
        lconv_D = readtable(lconv_D_file); %= strcat(file_dir, filesep, strcat(targetDate, '_calculation_lconv_6.0-10.0.csv'));   % For 6.0 m to 10.0 m
        lconv_E = readtable(lconv_E_file);
        lconv_F = readtable(lconv_F_file);
        lconv_G = readtable(lconv_G_file);
        
        R_Bulk_lconv_1_5 = lconv_A{:, 3};
        L_lconv_1_5 = lconv_A{:, 4};
        Term_3_lconv_1_5 = lconv_A{:, 6};
        
        R_Bulk_lconv_3 = lconv_B{:, 3};
        L_lconv_3 = lconv_B{:, 4};
        Term_3_lconv_3 = lconv_B{:, 6};
        
        R_Bulk_lconv_4_5 = lconv_C{:, 3};
        L_lconv_4_5 = lconv_C{:, 4};
        Term_3_lconv_4_5 = lconv_C{:, 6};
        
        R_Bulk_lconv_6 = lconv_D{:, 3};
        L_lconv_6 = lconv_D{:, 4};
        Term_3_lconv_6 = lconv_D{:, 6};
        
        R_Bulk_lconv_8_5 = lconv_E{:, 3};
        L_lconv_8_5 = lconv_E{:, 4};
        Term_3_lconv_8_5 = lconv_E{:, 6};
        
        R_Bulk_lconv_10 = lconv_F{:, 3};
        L_lconv_10 = lconv_F{:, 4};
        Term_3_lconv_10 = lconv_F{:, 6};
        
        R_Bulk_lconv_15 = lconv_G{:, 3};
        L_lconv_15 = lconv_G{:, 4};
        Term_3_lconv_15 = lconv_G{:, 6};
        
        R_Bulk_lconv_20 = lconv_G{:, 3};
        L_lconv_20 = lconv_G{:, 5};
        Term_3_lconv_20 = lconv_G{:, 7};
        
        R_Bulk_rel_1_5 = rel_A{:, 3};
        L_rel_1_5 = rel_A{:, 4};
        Term_3_rel_1_5 = rel_A{:, 6};
        
        R_Bulk_rel_3 = rel_B{:, 3};
        L_rel_3 = rel_B{:, 4};
        Term_3_rel_3 = rel_B{:, 6};
        
        R_Bulk_rel_4_5 = rel_C{:, 3};
        L_rel_4_5 = rel_C{:, 4};
        Term_3_rel_4_5 = rel_C{:, 6};
        
        R_Bulk_rel_6 = rel_D{:, 3};
        L_rel_6 = rel_D{:, 4};
        Term_3_rel_6 = rel_D{:, 6};
        
        R_Bulk_rel_8_5 = rel_E{:, 3};
        L_rel_8_5 = rel_E{:, 4};
        Term_3_rel_8_5 = rel_E{:, 6};
        
        R_Bulk_rel_10 = rel_F{:, 3};
        L_rel_10 = rel_F{:, 4};
        Term_3_rel_10 = rel_F{:, 6};
        
        R_Bulk_rel_15 = rel_G{:, 3};
        L_rel_15 = rel_G{:, 4};
        Term_3_rel_15 = rel_G{:, 6};
        
        R_Bulk_rel_20 = rel_G{:, 3};
        L_rel_20 = rel_G{:, 5};
        Term_3_rel_20 = rel_G{:, 7};
        
        R_Bulk_init_1_5 = init_A{:, 3};
        L_init_1_5 = init_A{:, 4};
        Term_3_init_1_5 = init_A{:, 6};
        
        R_Bulk_init_3 = init_B{:, 3};
        L_init_3 = init_B{:, 4};
        Term_3_init_3 = init_B{:, 6};
        
        R_Bulk_init_4_5 = init_C{:, 3};
        L_init_4_5 = init_C{:, 4};
        Term_3_init_4_5 = init_C{:, 6};
        
        R_Bulk_init_6 = init_D{:, 3};
        L_init_6 = init_D{:, 4};
        Term_3_init_6 = init_D{:, 6};
        
        R_Bulk_init_10 = init_D{:, 3};
        L_init_10 = init_D{:, 5};
        Term_3_init_10 = init_D{:, 7};
        
        R_Bulk_uconv_1_5 = uconv_A{:, 3};
        L_uconv_1_5 = uconv_A{:, 4};
        Term_3_uconv_1_5 = uconv_A{:, 6};
        
        R_Bulk_uconv_3 = uconv_B{:, 3};
        L_uconv_3 = uconv_B{:, 4};
        Term_3_uconv_3 = uconv_B{:, 6};
        
        R_Bulk_uconv_4_5 = uconv_C{:, 3};
        L_uconv_4_5 = uconv_C{:, 4};
        Term_3_uconv_4_5 = uconv_C{:, 6};
        
        R_Bulk_uconv_6 = uconv_D{:, 3};
        L_uconv_6 = uconv_D{:, 4};
        Term_3_uconv_6 = uconv_D{:, 6};
        
        R_Bulk_uconv_10 = uconv_D{:, 3};
        L_uconv_10 = uconv_D{:, 5};
        Term_3_uconv_10 = uconv_D{:, 7};
        
        
        [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5, R_Bulk_init_1_5, L_init_1_5, Term_3_init_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 213}, windTable{varStartIdx:varEndIdx, 243}, windTable{varStartIdx:varEndIdx, 273}, speedTable{varStartIdx:varEndIdx, 4}, R_Bulk_init_1_5, L_init_1_5, Term_3_init_1_5);
        [Vtke_init_3, TKE_init_3, spd_init_3, R_Bulk_init_3, L_init_3, Term_3_init_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 214}, windTable{varStartIdx:varEndIdx, 244}, windTable{varStartIdx:varEndIdx, 274}, speedTable{varStartIdx:varEndIdx, 5}, R_Bulk_init_3, L_init_3, Term_3_init_3);
        [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5, R_Bulk_init_4_5, L_init_4_5, Term_3_init_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 215}, windTable{varStartIdx:varEndIdx, 245}, windTable{varStartIdx:varEndIdx, 275}, speedTable{varStartIdx:varEndIdx, 6}, R_Bulk_init_4_5, L_init_4_5, Term_3_init_4_5);
        [Vtke_init_6, TKE_init_6, spd_init_6, R_Bulk_init_6, L_init_6, Term_3_init_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 216}, windTable{varStartIdx:varEndIdx, 246}, windTable{varStartIdx:varEndIdx, 276}, speedTable{varStartIdx:varEndIdx, 7}, R_Bulk_init_6, L_init_6, Term_3_init_6);
        [Vtke_init_10, TKE_init_10, spd_init_10, R_Bulk_init_10, L_init_10, Term_3_init_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 217}, windTable{varStartIdx:varEndIdx, 247}, windTable{varStartIdx:varEndIdx, 277}, speedTable{varStartIdx:varEndIdx, 8}, R_Bulk_init_10, L_init_10, Term_3_init_10);
        
        Vtke_init_1_5_ALL = [Vtke_init_1_5_ALL; Vtke_init_1_5];
        TKE_init_1_5_ALL = [TKE_init_1_5_ALL; TKE_init_1_5];
        spd_init_1_5_ALL = [spd_init_1_5_ALL; spd_init_1_5];
        R_Bulk_init_1_5_ALL = [R_Bulk_init_1_5_ALL; R_Bulk_init_1_5];
        L_init_1_5_ALL = [L_init_1_5_ALL; L_init_1_5];
        Term_3_init_1_5_ALL = [Term_3_init_1_5_ALL; Term_3_init_1_5];
        
        Vtke_init_3_ALL = [Vtke_init_3_ALL; Vtke_init_3];
        TKE_init_3_ALL = [TKE_init_3_ALL; TKE_init_3];
        spd_init_3_ALL = [spd_init_3_ALL; spd_init_3];
        R_Bulk_init_3_ALL = [R_Bulk_init_3_ALL; R_Bulk_init_3];
        L_init_3_ALL = [L_init_3_ALL; L_init_3];
        Term_3_init_3_ALL = [Term_3_init_3_ALL; Term_3_init_3];
        
        Vtke_init_4_5_ALL = [Vtke_init_4_5_ALL; Vtke_init_4_5];
        TKE_init_4_5_ALL = [TKE_init_4_5_ALL; TKE_init_4_5];
        spd_init_4_5_ALL = [spd_init_4_5_ALL; spd_init_4_5];
        R_Bulk_init_4_5_ALL = [R_Bulk_init_4_5_ALL; R_Bulk_init_4_5];
        L_init_4_5_ALL = [L_init_4_5_ALL; L_init_4_5];
        Term_3_init_4_5_ALL = [Term_3_init_4_5_ALL; Term_3_init_4_5];
        
        Vtke_init_6_ALL = [Vtke_init_6_ALL; Vtke_init_6];
        TKE_init_6_ALL = [TKE_init_6_ALL; TKE_init_6];
        spd_init_6_ALL = [spd_init_6_ALL; spd_init_6];
        R_Bulk_init_6_ALL = [R_Bulk_init_6_ALL; R_Bulk_init_6];
        L_init_6_ALL = [L_init_6_ALL; L_init_6];
        Term_3_init_6_ALL = [Term_3_init_6_ALL; Term_3_init_6];
        
        Vtke_init_10_ALL = [Vtke_init_10_ALL; Vtke_init_10];
        TKE_init_10_ALL = [TKE_init_10_ALL; TKE_init_10];
        spd_init_10_ALL = [spd_init_10_ALL; spd_init_10];
        R_Bulk_init_10_ALL = [R_Bulk_init_10_ALL; R_Bulk_init_10];
        L_init_10_ALL = [L_init_10_ALL; L_init_10];
        Term_3_init_10_ALL = [Term_3_init_10_ALL; Term_3_init_10];
        
        
        
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
        [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5, R_Bulk_rel_1_5, L_rel_1_5, Term_3_rel_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 219}, windTable{varStartIdx:varEndIdx, 249}, windTable{varStartIdx:varEndIdx, 279}, speedTable{varStartIdx:varEndIdx, 11}, R_Bulk_rel_1_5, L_rel_1_5, Term_3_rel_1_5);
        [Vtke_rel_3, TKE_rel_3, spd_rel_3, R_Bulk_rel_3, L_rel_3, Term_3_rel_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 220}, windTable{varStartIdx:varEndIdx, 250}, windTable{varStartIdx:varEndIdx, 280}, speedTable{varStartIdx:varEndIdx, 12}, R_Bulk_rel_3, L_rel_3, Term_3_rel_3);
        [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5, R_Bulk_rel_4_5, L_rel_4_5, Term_3_rel_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 221}, windTable{varStartIdx:varEndIdx, 251}, windTable{varStartIdx:varEndIdx, 281}, speedTable{varStartIdx:varEndIdx, 13}, R_Bulk_rel_4_5, L_rel_4_5, Term_3_rel_4_5);
        [Vtke_rel_6, TKE_rel_6, spd_rel_6, R_Bulk_rel_6, L_rel_6, Term_3_rel_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 222}, windTable{varStartIdx:varEndIdx, 252}, windTable{varStartIdx:varEndIdx, 282}, speedTable{varStartIdx:varEndIdx, 14}, R_Bulk_rel_6, L_rel_6, Term_3_rel_6);
        [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5, R_Bulk_rel_8_5, L_rel_8_5, Term_3_rel_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 223}, windTable{varStartIdx:varEndIdx, 253}, windTable{varStartIdx:varEndIdx, 283}, speedTable{varStartIdx:varEndIdx, 31}, R_Bulk_rel_8_5, L_rel_8_5, Term_3_rel_8_5);
        [Vtke_rel_10, TKE_rel_10, spd_rel_10, R_Bulk_rel_10, L_rel_10, Term_3_rel_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 224}, windTable{varStartIdx:varEndIdx, 254}, windTable{varStartIdx:varEndIdx, 284}, speedTable{varStartIdx:varEndIdx, 15}, R_Bulk_rel_10, L_rel_10, Term_3_rel_10);
        [Vtke_rel_15, TKE_rel_15, spd_rel_15, R_Bulk_rel_15, L_rel_15, Term_3_rel_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 225}, windTable{varStartIdx:varEndIdx, 255}, windTable{varStartIdx:varEndIdx, 285}, speedTable{varStartIdx:varEndIdx, 33}, R_Bulk_rel_15, L_rel_15, Term_3_rel_15);
        [Vtke_rel_20, TKE_rel_20, spd_rel_20, R_Bulk_rel_20, L_rel_20, Term_3_rel_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 226}, windTable{varStartIdx:varEndIdx, 256}, windTable{varStartIdx:varEndIdx, 286}, speedTable{varStartIdx:varEndIdx, 35}, R_Bulk_rel_20, L_rel_20, Term_3_rel_20);
        
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
        
        R_Bulk_rel_1_5_ALL = [R_Bulk_rel_1_5_ALL; R_Bulk_rel_1_5];
        L_rel_1_5_ALL = [L_rel_1_5_ALL; L_rel_1_5];
        Term_3_rel_1_5_ALL = [Term_3_rel_1_5_ALL; Term_3_rel_1_5];
        R_Bulk_rel_3_ALL = [R_Bulk_rel_3_ALL; R_Bulk_rel_3];
        L_rel_3_ALL = [L_rel_3_ALL; L_rel_3];
        Term_3_rel_3_ALL = [Term_3_rel_3_ALL; Term_3_rel_3];
        R_Bulk_rel_4_5_ALL = [R_Bulk_rel_4_5_ALL; R_Bulk_rel_4_5];
        L_rel_4_5_ALL = [L_rel_4_5_ALL; L_rel_4_5];
        Term_3_rel_4_5_ALL = [Term_3_rel_4_5_ALL; Term_3_rel_4_5];
        R_Bulk_rel_6_ALL = [R_Bulk_rel_6_ALL; R_Bulk_rel_6];
        L_rel_6_ALL = [L_rel_6_ALL; L_rel_6];
        Term_3_rel_6_ALL = [Term_3_rel_6_ALL; Term_3_rel_6];
        R_Bulk_rel_8_5_ALL = [R_Bulk_rel_8_5_ALL; R_Bulk_rel_8_5];
        L_rel_8_5_ALL = [L_rel_8_5_ALL; L_rel_8_5];
        Term_3_rel_8_5_ALL = [Term_3_rel_8_5_ALL; Term_3_rel_8_5];
        R_Bulk_rel_10_ALL = [R_Bulk_rel_10_ALL; R_Bulk_rel_10];
        L_rel_10_ALL = [L_rel_10_ALL; L_rel_10];
        Term_3_rel_10_ALL = [Term_3_rel_10_ALL; Term_3_rel_10];
        R_Bulk_rel_15_ALL = [R_Bulk_rel_15_ALL; R_Bulk_rel_15];
        L_rel_15_ALL = [L_rel_15_ALL; L_rel_15];
        Term_3_rel_15_ALL = [Term_3_rel_15_ALL; Term_3_rel_15];
        R_Bulk_rel_20_ALL = [R_Bulk_rel_20_ALL; R_Bulk_rel_20];
        L_rel_20_ALL = [L_rel_20_ALL; L_rel_20];
        Term_3_rel_20_ALL = [Term_3_rel_20_ALL; Term_3_rel_20];
        
        
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
        [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5, R_Bulk_uconv_1_5, L_uconv_1_5, Term_3_uconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 228}, windTable{varStartIdx:varEndIdx, 258}, windTable{varStartIdx:varEndIdx, 288}, speedTable{varStartIdx:varEndIdx, 18}, R_Bulk_uconv_1_5, L_uconv_1_5, Term_3_uconv_1_5);
        [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3, R_Bulk_uconv_3, L_uconv_3, Term_3_uconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 229}, windTable{varStartIdx:varEndIdx, 259}, windTable{varStartIdx:varEndIdx, 289}, speedTable{varStartIdx:varEndIdx, 19}, R_Bulk_uconv_3, L_uconv_3, Term_3_uconv_3);
        [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5, R_Bulk_uconv_4_5, L_uconv_4_5, Term_3_uconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 230}, windTable{varStartIdx:varEndIdx, 260}, windTable{varStartIdx:varEndIdx, 290}, speedTable{varStartIdx:varEndIdx, 20}, R_Bulk_uconv_4_5, L_uconv_4_5, Term_3_uconv_4_5);
        [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6, R_Bulk_uconv_6, L_uconv_6, Term_3_uconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 231}, windTable{varStartIdx:varEndIdx, 261}, windTable{varStartIdx:varEndIdx, 291}, speedTable{varStartIdx:varEndIdx, 21}, R_Bulk_uconv_6, L_uconv_6, Term_3_uconv_6);
        [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10, R_Bulk_uconv_10, L_uconv_10, Term_3_uconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 232}, windTable{varStartIdx:varEndIdx, 262}, windTable{varStartIdx:varEndIdx, 292}, speedTable{varStartIdx:varEndIdx, 22}, R_Bulk_uconv_10, L_uconv_10, Term_3_uconv_10);
        
        
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
        
        R_Bulk_uconv_1_5_ALL = [R_Bulk_uconv_1_5_ALL; R_Bulk_uconv_1_5];
        L_uconv_1_5_ALL = [L_uconv_1_5_ALL; L_uconv_1_5];
        Term_3_uconv_1_5_ALL = [Term_3_uconv_1_5_ALL; Term_3_uconv_1_5];
        R_Bulk_uconv_3_ALL = [R_Bulk_uconv_3_ALL; R_Bulk_uconv_3];
        L_uconv_3_ALL = [L_uconv_3_ALL; L_uconv_3];
        Term_3_uconv_3_ALL = [Term_3_uconv_3_ALL; Term_3_uconv_3];
        R_Bulk_uconv_4_5_ALL = [R_Bulk_uconv_4_5_ALL; R_Bulk_uconv_4_5];
        L_uconv_4_5_ALL = [L_uconv_4_5_ALL; L_uconv_4_5];
        Term_3_uconv_4_5_ALL = [Term_3_uconv_4_5_ALL; Term_3_uconv_4_5];
        R_Bulk_uconv_6_ALL = [R_Bulk_uconv_6_ALL; R_Bulk_uconv_6];
        L_uconv_6_ALL = [L_uconv_6_ALL; L_uconv_6];
        Term_3_uconv_6_ALL = [Term_3_uconv_6_ALL; Term_3_uconv_6];
        R_Bulk_uconv_10_ALL = [R_Bulk_uconv_10_ALL; R_Bulk_uconv_10];
        L_uconv_10_ALL = [L_uconv_10_ALL; L_uconv_10];
        Term_3_uconv_10_ALL = [Term_3_uconv_10_ALL; Term_3_uconv_10];
        
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
        [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5, R_Bulk_lconv_1_5, L_lconv_1_5, Term_3_lconv_1_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 234}, windTable{varStartIdx:varEndIdx, 264}, windTable{varStartIdx:varEndIdx, 294}, speedTable{varStartIdx:varEndIdx, 25}, R_Bulk_lconv_1_5, L_lconv_1_5, Term_3_lconv_1_5);
        [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3, R_Bulk_lconv_3, L_lconv_3, Term_3_lconv_3] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 235}, windTable{varStartIdx:varEndIdx, 265}, windTable{varStartIdx:varEndIdx, 295}, speedTable{varStartIdx:varEndIdx, 26}, R_Bulk_lconv_3, L_lconv_3, Term_3_lconv_3);
        [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5, R_Bulk_lconv_4_5, L_lconv_4_5, Term_3_lconv_4_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 236}, windTable{varStartIdx:varEndIdx, 266}, windTable{varStartIdx:varEndIdx, 296}, speedTable{varStartIdx:varEndIdx, 27}, R_Bulk_lconv_4_5, L_lconv_4_5, Term_3_lconv_4_5);
        [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6, R_Bulk_lconv_6, L_lconv_6, Term_3_lconv_6] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 237}, windTable{varStartIdx:varEndIdx, 267}, windTable{varStartIdx:varEndIdx, 297}, speedTable{varStartIdx:varEndIdx, 28}, R_Bulk_lconv_6, L_lconv_6, Term_3_lconv_6);
        [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5, R_Bulk_lconv_8_5, L_lconv_8_5, Term_3_lconv_8_5] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 238}, windTable{varStartIdx:varEndIdx, 268}, windTable{varStartIdx:varEndIdx, 298}, speedTable{varStartIdx:varEndIdx, 32}, R_Bulk_lconv_8_5, L_lconv_8_5, Term_3_lconv_8_5);
        [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10, R_Bulk_lconv_10, L_lconv_10, Term_3_lconv_10] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 239}, windTable{varStartIdx:varEndIdx, 269}, windTable{varStartIdx:varEndIdx, 299}, speedTable{varStartIdx:varEndIdx, 29}, R_Bulk_lconv_10, L_lconv_10, Term_3_lconv_10);
        [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15, R_Bulk_lconv_15, L_lconv_15, Term_3_lconv_15] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 240}, windTable{varStartIdx:varEndIdx, 270}, windTable{varStartIdx:varEndIdx, 300}, speedTable{varStartIdx:varEndIdx, 34}, R_Bulk_lconv_15, L_lconv_15, Term_3_lconv_15);
        [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20, R_Bulk_lconv_20, L_lconv_20, Term_3_lconv_20] = Jielun_TKE(windTable{varStartIdx:varEndIdx, 241}, windTable{varStartIdx:varEndIdx, 271}, windTable{varStartIdx:varEndIdx, 301}, speedTable{varStartIdx:varEndIdx, 36}, R_Bulk_lconv_20, L_lconv_20, Term_3_lconv_20);
        
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
        
        R_Bulk_lconv_1_5_ALL = [R_Bulk_lconv_1_5_ALL; R_Bulk_lconv_1_5];
        L_lconv_1_5_ALL = [L_lconv_1_5_ALL; L_lconv_1_5];
        Term_3_lconv_1_5_ALL = [Term_3_lconv_1_5_ALL; Term_3_lconv_1_5];
        R_Bulk_lconv_3_ALL = [R_Bulk_lconv_3_ALL; R_Bulk_lconv_3];
        L_lconv_3_ALL = [L_lconv_3_ALL; L_lconv_3];
        Term_3_lconv_3_ALL = [Term_3_lconv_3_ALL; Term_3_lconv_3];
        R_Bulk_lconv_4_5_ALL = [R_Bulk_lconv_4_5_ALL; R_Bulk_lconv_4_5];
        L_lconv_4_5_ALL = [L_lconv_4_5_ALL; L_lconv_4_5];
        Term_3_lconv_4_5_ALL = [Term_3_lconv_4_5_ALL; Term_3_lconv_4_5];
        R_Bulk_lconv_6_ALL = [R_Bulk_lconv_6_ALL; R_Bulk_lconv_6];
        L_lconv_6_ALL = [L_lconv_6_ALL; L_lconv_6];
        Term_3_lconv_6_ALL = [Term_3_lconv_6_ALL; Term_3_lconv_6];
        R_Bulk_lconv_8_5_ALL = [R_Bulk_lconv_8_5_ALL; R_Bulk_lconv_8_5];
        L_lconv_8_5_ALL = [L_lconv_8_5_ALL; L_lconv_8_5];
        Term_3_lconv_8_5_ALL = [Term_3_lconv_8_5_ALL; Term_3_lconv_8_5];
        R_Bulk_lconv_10_ALL = [R_Bulk_lconv_10_ALL; R_Bulk_lconv_10];
        L_lconv_10_ALL = [L_lconv_10_ALL; L_lconv_10];
        Term_3_lconv_10_ALL = [Term_3_lconv_10_ALL; Term_3_lconv_10];
        R_Bulk_lconv_15_ALL = [R_Bulk_lconv_15_ALL; R_Bulk_lconv_15];
        L_lconv_15_ALL = [L_lconv_15_ALL; L_lconv_15];
        Term_3_lconv_15_ALL = [Term_3_lconv_15_ALL; Term_3_lconv_15];
        R_Bulk_lconv_20_ALL = [R_Bulk_lconv_20_ALL; R_Bulk_lconv_20];
        L_lconv_20_ALL = [L_lconv_20_ALL; L_lconv_20];
        Term_3_lconv_20_ALL = [Term_3_lconv_20_ALL; Term_3_lconv_20];
        
        
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
        
        %bar_fence = repmat('|',10357);
        
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

% Now form tables!

% Sort at first based on speed
[Vtke_init_1_5_sort, TKE_init_1_5_sort, spd_init_1_5_sort, R_Bulk_init_1_5_sort, L_init_1_5_sort, Term_3_init_1_5_sort] = reference_sort(Vtke_init_1_5_ALL, TKE_init_1_5_ALL, spd_init_1_5_ALL, R_Bulk_init_1_5_ALL, L_init_1_5_ALL, Term_3_init_1_5_ALL);
[Vtke_init_3_sort, TKE_init_3_sort, spd_init_3_sort, R_Bulk_init_3_sort, L_init_3_sort, Term_3_init_3_sort] = reference_sort(Vtke_init_3_ALL, TKE_init_3_ALL, spd_init_3_ALL, R_Bulk_init_3_ALL, L_init_3_ALL, Term_3_init_3_ALL);
[Vtke_init_4_5_sort, TKE_init_4_5_sort, spd_init_4_5_sort, R_Bulk_init_4_5_sort, L_init_4_5_sort, Term_3_init_4_5_sort] = reference_sort(Vtke_init_4_5_ALL, TKE_init_4_5_ALL, spd_init_4_5_ALL, R_Bulk_init_4_5_ALL, L_init_4_5_ALL, Term_3_init_4_5_ALL);
[Vtke_init_6_sort, TKE_init_6_sort, spd_init_6_sort, R_Bulk_init_6_sort, L_init_6_sort, Term_3_init_6_sort] = reference_sort(Vtke_init_6_ALL, TKE_init_6_ALL, spd_init_6_ALL, R_Bulk_init_6_ALL, L_init_6_ALL, Term_3_init_6_ALL);
[Vtke_init_10_sort, TKE_init_10_sort, spd_init_10_sort, R_Bulk_init_10_sort, L_init_10_sort, Term_3_init_10_sort] = reference_sort(Vtke_init_10_ALL, TKE_init_10_ALL, spd_init_10_ALL, R_Bulk_init_10_ALL, L_init_10_ALL, Term_3_init_10_ALL);

[Vtke_uconv_1_5_sort, TKE_uconv_1_5_sort, spd_uconv_1_5_sort, R_Bulk_uconv_1_5_sort, L_uconv_1_5_sort, Term_3_uconv_1_5_sort] = reference_sort(Vtke_uconv_1_5_ALL, TKE_uconv_1_5_ALL, spd_uconv_1_5_ALL, R_Bulk_uconv_1_5_ALL, L_uconv_1_5_ALL, Term_3_uconv_1_5_ALL);
[Vtke_uconv_3_sort, TKE_uconv_3_sort, spd_uconv_3_sort, R_Bulk_uconv_3_sort, L_uconv_3_sort, Term_3_uconv_3_sort] = reference_sort(Vtke_uconv_3_ALL, TKE_uconv_3_ALL, spd_uconv_3_ALL, R_Bulk_uconv_3_ALL, L_uconv_3_ALL, Term_3_uconv_3_ALL);
[Vtke_uconv_4_5_sort, TKE_uconv_4_5_sort, spd_uconv_4_5_sort, R_Bulk_uconv_4_5_sort, L_uconv_4_5_sort, Term_3_uconv_4_5_sort] = reference_sort(Vtke_uconv_4_5_ALL, TKE_uconv_4_5_ALL, spd_uconv_4_5_ALL, R_Bulk_uconv_4_5_ALL, L_uconv_4_5_ALL, Term_3_uconv_4_5_ALL);
[Vtke_uconv_6_sort, TKE_uconv_6_sort, spd_uconv_6_sort, R_Bulk_uconv_6_sort, L_uconv_6_sort, Term_3_uconv_6_sort] = reference_sort(Vtke_uconv_6_ALL, TKE_uconv_6_ALL, spd_uconv_6_ALL, R_Bulk_uconv_6_ALL, L_uconv_6_ALL, Term_3_uconv_6_ALL);
[Vtke_uconv_10_sort, TKE_uconv_10_sort, spd_uconv_10_sort, R_Bulk_uconv_10_sort, L_uconv_10_sort, Term_3_uconv_10_sort] = reference_sort(Vtke_uconv_10_ALL, TKE_uconv_10_ALL, spd_uconv_10_ALL, R_Bulk_uconv_10_ALL, L_uconv_10_ALL, Term_3_uconv_10_ALL);

[Vtke_rel_1_5_sort, TKE_rel_1_5_sort, spd_rel_1_5_sort, R_Bulk_rel_1_5_sort, L_rel_1_5_sort, Term_3_rel_1_5_sort] = reference_sort(Vtke_rel_1_5_ALL, TKE_rel_1_5_ALL, spd_rel_1_5_ALL, R_Bulk_rel_1_5_ALL, L_rel_1_5_ALL, Term_3_rel_1_5_ALL);
[Vtke_rel_3_sort, TKE_rel_3_sort, spd_rel_3_sort, R_Bulk_rel_3_sort, L_rel_3_sort, Term_3_rel_3_sort] = reference_sort(Vtke_rel_3_ALL, TKE_rel_3_ALL, spd_rel_3_ALL, R_Bulk_rel_3_ALL, L_rel_3_ALL, Term_3_rel_3_ALL);
[Vtke_rel_4_5_sort, TKE_rel_4_5_sort, spd_rel_4_5_sort, R_Bulk_rel_4_5_sort, L_rel_4_5_sort, Term_3_rel_4_5_sort] = reference_sort(Vtke_rel_4_5_ALL, TKE_rel_4_5_ALL, spd_rel_4_5_ALL, R_Bulk_rel_4_5_ALL, L_rel_4_5_ALL, Term_3_rel_4_5_ALL);
[Vtke_rel_6_sort, TKE_rel_6_sort, spd_rel_6_sort, R_Bulk_rel_6_sort, L_rel_6_sort, Term_3_rel_6_sort] = reference_sort(Vtke_rel_6_ALL, TKE_rel_6_ALL, spd_rel_6_ALL, R_Bulk_rel_6_ALL, L_rel_6_ALL, Term_3_rel_6_ALL);
[Vtke_rel_8_5_sort, TKE_rel_8_5_sort, spd_rel_8_5_sort, R_Bulk_rel_8_5_sort, L_rel_8_5_sort, Term_3_rel_8_5_sort] = reference_sort(Vtke_rel_8_5_ALL, TKE_rel_8_5_ALL, spd_rel_8_5_ALL, R_Bulk_rel_8_5_ALL, L_rel_8_5_ALL, Term_3_rel_8_5_ALL);
[Vtke_rel_10_sort, TKE_rel_10_sort, spd_rel_10_sort, R_Bulk_rel_10_sort, L_rel_10_sort, Term_3_rel_10_sort] = reference_sort(Vtke_rel_10_ALL, TKE_rel_10_ALL, spd_rel_10_ALL, R_Bulk_rel_10_ALL, L_rel_10_ALL, Term_3_rel_10_ALL);
[Vtke_rel_15_sort, TKE_rel_15_sort, spd_rel_15_sort, R_Bulk_rel_15_sort, L_rel_15_sort, Term_3_rel_15_sort] = reference_sort(Vtke_rel_15_ALL, TKE_rel_15_ALL, spd_rel_15_ALL, R_Bulk_rel_15_ALL, L_rel_15_ALL, Term_3_rel_15_ALL);
[Vtke_rel_20_sort, TKE_rel_20_sort, spd_rel_20_sort, R_Bulk_rel_20_sort, L_rel_20_sort, Term_3_rel_20_sort] = reference_sort(Vtke_rel_20_ALL, TKE_rel_20_ALL, spd_rel_20_ALL, R_Bulk_rel_20_ALL, L_rel_20_ALL, Term_3_rel_20_ALL);

[Vtke_lconv_1_5_sort, TKE_lconv_1_5_sort, spd_lconv_1_5_sort, R_Bulk_lconv_1_5_sort, L_lconv_1_5_sort, Term_3_lconv_1_5_sort] = reference_sort(Vtke_lconv_1_5_ALL, TKE_lconv_1_5_ALL, spd_lconv_1_5_ALL, R_Bulk_lconv_1_5_ALL, L_lconv_1_5_ALL, Term_3_lconv_1_5_ALL);
[Vtke_lconv_3_sort, TKE_lconv_3_sort, spd_lconv_3_sort, R_Bulk_lconv_3_sort, L_lconv_3_sort, Term_3_lconv_3_sort] = reference_sort(Vtke_lconv_3_ALL, TKE_lconv_3_ALL, spd_lconv_3_ALL, R_Bulk_lconv_3_ALL, L_lconv_3_ALL, Term_3_lconv_3_ALL);
[Vtke_lconv_4_5_sort, TKE_lconv_4_5_sort, spd_lconv_4_5_sort, R_Bulk_lconv_4_5_sort, L_lconv_4_5_sort, Term_3_lconv_4_5_sort] = reference_sort(Vtke_lconv_4_5_ALL, TKE_lconv_4_5_ALL, spd_lconv_4_5_ALL, R_Bulk_lconv_4_5_ALL, L_lconv_4_5_ALL, Term_3_lconv_4_5_ALL);
[Vtke_lconv_6_sort, TKE_lconv_6_sort, spd_lconv_6_sort, R_Bulk_lconv_6_sort, L_lconv_6_sort, Term_3_lconv_6_sort] = reference_sort(Vtke_lconv_6_ALL, TKE_lconv_6_ALL, spd_lconv_6_ALL, R_Bulk_lconv_6_ALL, L_lconv_6_ALL, Term_3_lconv_6_ALL);
[Vtke_lconv_8_5_sort, TKE_lconv_8_5_sort, spd_lconv_8_5_sort, R_Bulk_lconv_8_5_sort, L_lconv_8_5_sort, Term_3_lconv_8_5_sort] = reference_sort(Vtke_lconv_8_5_ALL, TKE_lconv_8_5_ALL, spd_lconv_8_5_ALL, R_Bulk_lconv_8_5_ALL, L_lconv_8_5_ALL, Term_3_lconv_8_5_ALL);
[Vtke_lconv_10_sort, TKE_lconv_10_sort, spd_lconv_10_sort, R_Bulk_lconv_10_sort, L_lconv_10_sort, Term_3_lconv_10_sort] = reference_sort(Vtke_lconv_10_ALL, TKE_lconv_10_ALL, spd_lconv_10_ALL, R_Bulk_lconv_10_ALL, L_lconv_10_ALL, Term_3_lconv_10_ALL);
[Vtke_lconv_15_sort, TKE_lconv_15_sort, spd_lconv_15_sort, R_Bulk_lconv_15_sort, L_lconv_15_sort, Term_3_lconv_15_sort] = reference_sort(Vtke_lconv_15_ALL, TKE_lconv_15_ALL, spd_lconv_15_ALL, R_Bulk_lconv_15_ALL, L_lconv_15_ALL, Term_3_lconv_15_ALL);
[Vtke_lconv_20_sort, TKE_lconv_20_sort, spd_lconv_20_sort, R_Bulk_lconv_20_sort, L_lconv_20_sort, Term_3_lconv_20_sort] = reference_sort(Vtke_lconv_20_ALL, TKE_lconv_20_ALL, spd_lconv_20_ALL, R_Bulk_lconv_20_ALL, L_lconv_20_ALL, Term_3_lconv_20_ALL);


% Create bar fence
bar_fence = repmat('|',length(L_lconv_20_ALL), 1);
% Group table
tempT_spd_sort_init = table(spd_init_1_5_sort, Vtke_init_1_5_sort, TKE_init_1_5_sort, R_Bulk_init_1_5_sort, L_init_1_5_sort, Term_3_init_1_5_sort,...
    bar_fence, spd_init_3_sort, Vtke_init_3_sort, TKE_init_3_sort, R_Bulk_init_3_sort, L_init_3_sort, Term_3_init_3_sort,...
    bar_fence, spd_init_4_5_sort, Vtke_init_4_5_sort, TKE_init_4_5_sort, R_Bulk_init_4_5_sort, L_init_4_5_sort, Term_3_init_4_5_sort,...
    bar_fence, spd_init_6_sort, Vtke_init_6_sort, TKE_init_6_sort, R_Bulk_init_6_sort, L_init_6_sort, Term_3_init_6_sort,...
    bar_fence, spd_init_10_sort, Vtke_init_10_sort, TKE_init_10_sort, R_Bulk_init_10_sort, L_init_10_sort, Term_3_init_10_sort);

tempT_spd_sort_rel = table(spd_rel_1_5_sort, Vtke_rel_1_5_sort, TKE_rel_1_5_sort, R_Bulk_rel_1_5_sort, L_rel_1_5_sort, Term_3_rel_1_5_sort,...
    bar_fence, spd_rel_3_sort, Vtke_rel_3_sort, TKE_rel_3_sort, R_Bulk_rel_3_sort, L_rel_3_sort, Term_3_rel_3_sort,...
    bar_fence, spd_rel_4_5_sort, Vtke_rel_4_5_sort, TKE_rel_4_5_sort, R_Bulk_rel_4_5_sort, L_rel_4_5_sort, Term_3_rel_4_5_sort,...
    bar_fence, spd_rel_6_sort, Vtke_rel_6_sort, TKE_rel_6_sort, R_Bulk_rel_6_sort, L_rel_6_sort, Term_3_rel_6_sort,...
    bar_fence, spd_rel_8_5_sort, Vtke_rel_8_5_sort, TKE_rel_8_5_sort, R_Bulk_rel_8_5_sort, L_rel_8_5_sort, Term_3_rel_8_5_sort,...
    bar_fence, spd_rel_10_sort, Vtke_rel_10_sort, TKE_rel_10_sort, R_Bulk_rel_10_sort, L_rel_10_sort, Term_3_rel_10_sort,...
    bar_fence, spd_rel_15_sort, Vtke_rel_15_sort, TKE_rel_15_sort, R_Bulk_rel_15_sort, L_rel_15_sort, Term_3_rel_15_sort,...
    bar_fence, spd_rel_20_sort, Vtke_rel_20_sort, TKE_rel_20_sort, R_Bulk_rel_20_sort, L_rel_20_sort, Term_3_rel_20_sort);

tempT_spd_sort_uconv = table(spd_uconv_1_5_sort, Vtke_uconv_1_5_sort, TKE_uconv_1_5_sort, R_Bulk_uconv_1_5_sort, L_uconv_1_5_sort, Term_3_uconv_1_5_sort,...
    bar_fence, spd_uconv_3_sort, Vtke_uconv_3_sort, TKE_uconv_3_sort, R_Bulk_uconv_3_sort, L_uconv_3_sort, Term_3_uconv_3_sort,...
    bar_fence, spd_uconv_4_5_sort, Vtke_uconv_4_5_sort, TKE_uconv_4_5_sort, R_Bulk_uconv_4_5_sort, L_uconv_4_5_sort, Term_3_uconv_4_5_sort,...
    bar_fence, spd_uconv_6_sort, Vtke_uconv_6_sort, TKE_uconv_6_sort, R_Bulk_uconv_6_sort, L_uconv_6_sort, Term_3_uconv_6_sort,...
    bar_fence, spd_uconv_10_sort, Vtke_uconv_10_sort, TKE_uconv_10_sort, R_Bulk_uconv_10_sort, L_uconv_10_sort, Term_3_uconv_10_sort);

tempT_spd_sort_lconv = table(spd_lconv_1_5_sort, Vtke_lconv_1_5_sort, TKE_lconv_1_5_sort, R_Bulk_lconv_1_5_sort, L_lconv_1_5_sort, Term_3_lconv_1_5_sort,...
    bar_fence, spd_lconv_3_sort, Vtke_lconv_3_sort, TKE_lconv_3_sort, R_Bulk_lconv_3_sort, L_lconv_3_sort, Term_3_lconv_3_sort,...
    bar_fence, spd_lconv_4_5_sort, Vtke_lconv_4_5_sort, TKE_lconv_4_5_sort, R_Bulk_lconv_4_5_sort, L_lconv_4_5_sort, Term_3_lconv_4_5_sort,...
    bar_fence, spd_lconv_6_sort, Vtke_lconv_6_sort, TKE_lconv_6_sort, R_Bulk_lconv_6_sort, L_lconv_6_sort, Term_3_lconv_6_sort,...
    bar_fence, spd_lconv_8_5_sort, Vtke_lconv_8_5_sort, TKE_lconv_8_5_sort, R_Bulk_lconv_8_5_sort, L_lconv_8_5_sort, Term_3_lconv_8_5_sort,...
    bar_fence, spd_lconv_10_sort, Vtke_lconv_10_sort, TKE_lconv_10_sort, R_Bulk_lconv_10_sort, L_lconv_10_sort, Term_3_lconv_10_sort,...
    bar_fence, spd_lconv_15_sort, Vtke_lconv_15_sort, TKE_lconv_15_sort, R_Bulk_lconv_15_sort, L_lconv_15_sort, Term_3_lconv_15_sort,...
    bar_fence, spd_lconv_20_sort, Vtke_lconv_20_sort, TKE_lconv_20_sort, R_Bulk_lconv_20_sort, L_lconv_20_sort, Term_3_lconv_20_sort);

% Format table name
table_name_spd_sort_init = 'init_Speed_Sorted.csv';
table_name_spd_sort_rel = 'rel_Speed_Sorted.csv';
table_name_spd_sort_uconv = 'uconv_Speed_Sorted.csv';
table_name_spd_sort_lconv = 'lconv_Speed_Sorted.csv';

% Output tables
writetable(tempT_spd_sort_init, table_name_spd_sort_init);
writetable(tempT_spd_sort_rel, table_name_spd_sort_rel);
writetable(tempT_spd_sort_uconv, table_name_spd_sort_uconv);
writetable(tempT_spd_sort_lconv, table_name_spd_sort_lconv);

% Sort based on R_Bulk
[Vtke_init_1_5_sort, TKE_init_1_5_sort, R_Bulk_init_1_5_sort, spd_init_1_5_sort, L_init_1_5_sort, Term_3_init_1_5_sort] = reference_sort(Vtke_init_1_5_ALL, TKE_init_1_5_ALL, R_Bulk_init_1_5_ALL, spd_init_1_5_ALL, L_init_1_5_ALL, Term_3_init_1_5_ALL);
[Vtke_init_3_sort, TKE_init_3_sort, R_Bulk_init_3_sort, spd_init_3_sort, L_init_3_sort, Term_3_init_3_sort] = reference_sort(Vtke_init_3_ALL, TKE_init_3_ALL, R_Bulk_init_3_ALL, spd_init_3_ALL, L_init_3_ALL, Term_3_init_3_ALL);
[Vtke_init_4_5_sort, TKE_init_4_5_sort, R_Bulk_init_4_5_sort, spd_init_4_5_sort, L_init_4_5_sort, Term_3_init_4_5_sort] = reference_sort(Vtke_init_4_5_ALL, TKE_init_4_5_ALL, R_Bulk_init_4_5_ALL, spd_init_4_5_ALL, L_init_4_5_ALL, Term_3_init_4_5_ALL);
[Vtke_init_6_sort, TKE_init_6_sort, R_Bulk_init_6_sort, spd_init_6_sort, L_init_6_sort, Term_3_init_6_sort] = reference_sort(Vtke_init_6_ALL, TKE_init_6_ALL, R_Bulk_init_6_ALL, spd_init_6_ALL, L_init_6_ALL, Term_3_init_6_ALL);
[Vtke_init_10_sort, TKE_init_10_sort, R_Bulk_init_10_sort, spd_init_10_sort, L_init_10_sort, Term_3_init_10_sort] = reference_sort(Vtke_init_10_ALL, TKE_init_10_ALL, R_Bulk_init_10_ALL, spd_init_10_ALL, L_init_10_ALL, Term_3_init_10_ALL);

[Vtke_uconv_1_5_sort, TKE_uconv_1_5_sort, R_Bulk_uconv_1_5_sort, spd_uconv_1_5_sort, L_uconv_1_5_sort, Term_3_uconv_1_5_sort] = reference_sort(Vtke_uconv_1_5_ALL, TKE_uconv_1_5_ALL, R_Bulk_uconv_1_5_ALL, spd_uconv_1_5_ALL, L_uconv_1_5_ALL, Term_3_uconv_1_5_ALL);
[Vtke_uconv_3_sort, TKE_uconv_3_sort, R_Bulk_uconv_3_sort, spd_uconv_3_sort, L_uconv_3_sort, Term_3_uconv_3_sort] = reference_sort(Vtke_uconv_3_ALL, TKE_uconv_3_ALL, R_Bulk_uconv_3_ALL, spd_uconv_3_ALL, L_uconv_3_ALL, Term_3_uconv_3_ALL);
[Vtke_uconv_4_5_sort, TKE_uconv_4_5_sort, R_Bulk_uconv_4_5_sort, spd_uconv_4_5_sort, L_uconv_4_5_sort, Term_3_uconv_4_5_sort] = reference_sort(Vtke_uconv_4_5_ALL, TKE_uconv_4_5_ALL, R_Bulk_uconv_4_5_ALL, spd_uconv_4_5_ALL, L_uconv_4_5_ALL, Term_3_uconv_4_5_ALL);
[Vtke_uconv_6_sort, TKE_uconv_6_sort, R_Bulk_uconv_6_sort, spd_uconv_6_sort, L_uconv_6_sort, Term_3_uconv_6_sort] = reference_sort(Vtke_uconv_6_ALL, TKE_uconv_6_ALL, R_Bulk_uconv_6_ALL, spd_uconv_6_ALL, L_uconv_6_ALL, Term_3_uconv_6_ALL);
[Vtke_uconv_10_sort, TKE_uconv_10_sort, R_Bulk_uconv_10_sort, spd_uconv_10_sort, L_uconv_10_sort, Term_3_uconv_10_sort] = reference_sort(Vtke_uconv_10_ALL, TKE_uconv_10_ALL, R_Bulk_uconv_10_ALL, spd_uconv_10_ALL, L_uconv_10_ALL, Term_3_uconv_10_ALL);

[Vtke_rel_1_5_sort, TKE_rel_1_5_sort, R_Bulk_rel_1_5_sort, spd_rel_1_5_sort, L_rel_1_5_sort, Term_3_rel_1_5_sort] = reference_sort(Vtke_rel_1_5_ALL, TKE_rel_1_5_ALL, R_Bulk_rel_1_5_ALL, spd_rel_1_5_ALL, L_rel_1_5_ALL, Term_3_rel_1_5_ALL);
[Vtke_rel_3_sort, TKE_rel_3_sort, R_Bulk_rel_3_sort, spd_rel_3_sort, L_rel_3_sort, Term_3_rel_3_sort] = reference_sort(Vtke_rel_3_ALL, TKE_rel_3_ALL, R_Bulk_rel_3_ALL, spd_rel_3_ALL, L_rel_3_ALL, Term_3_rel_3_ALL);
[Vtke_rel_4_5_sort, TKE_rel_4_5_sort, R_Bulk_rel_4_5_sort, spd_rel_4_5_sort, L_rel_4_5_sort, Term_3_rel_4_5_sort] = reference_sort(Vtke_rel_4_5_ALL, TKE_rel_4_5_ALL, R_Bulk_rel_4_5_ALL, spd_rel_4_5_ALL, L_rel_4_5_ALL, Term_3_rel_4_5_ALL);
[Vtke_rel_6_sort, TKE_rel_6_sort, R_Bulk_rel_6_sort, spd_rel_6_sort, L_rel_6_sort, Term_3_rel_6_sort] = reference_sort(Vtke_rel_6_ALL, TKE_rel_6_ALL, R_Bulk_rel_6_ALL, spd_rel_6_ALL, L_rel_6_ALL, Term_3_rel_6_ALL);
[Vtke_rel_8_5_sort, TKE_rel_8_5_sort, R_Bulk_rel_8_5_sort, spd_rel_8_5_sort, L_rel_8_5_sort, Term_3_rel_8_5_sort] = reference_sort(Vtke_rel_8_5_ALL, TKE_rel_8_5_ALL, R_Bulk_rel_8_5_ALL, spd_rel_8_5_ALL, L_rel_8_5_ALL, Term_3_rel_8_5_ALL);
[Vtke_rel_10_sort, TKE_rel_10_sort, R_Bulk_rel_10_sort, spd_rel_10_sort, L_rel_10_sort, Term_3_rel_10_sort] = reference_sort(Vtke_rel_10_ALL, TKE_rel_10_ALL, R_Bulk_rel_10_ALL, spd_rel_10_ALL, L_rel_10_ALL, Term_3_rel_10_ALL);
[Vtke_rel_15_sort, TKE_rel_15_sort, R_Bulk_rel_15_sort, spd_rel_15_sort, L_rel_15_sort, Term_3_rel_15_sort] = reference_sort(Vtke_rel_15_ALL, TKE_rel_15_ALL, R_Bulk_rel_15_ALL, spd_rel_15_ALL, L_rel_15_ALL, Term_3_rel_15_ALL);
[Vtke_rel_20_sort, TKE_rel_20_sort, R_Bulk_rel_20_sort, spd_rel_20_sort, L_rel_20_sort, Term_3_rel_20_sort] = reference_sort(Vtke_rel_20_ALL, TKE_rel_20_ALL, R_Bulk_rel_20_ALL, spd_rel_20_ALL, L_rel_20_ALL, Term_3_rel_20_ALL);

[Vtke_lconv_1_5_sort, TKE_lconv_1_5_sort, R_Bulk_lconv_1_5_sort, spd_lconv_1_5_sort, L_lconv_1_5_sort, Term_3_lconv_1_5_sort] = reference_sort(Vtke_lconv_1_5_ALL, TKE_lconv_1_5_ALL, R_Bulk_lconv_1_5_ALL, spd_lconv_1_5_ALL, L_lconv_1_5_ALL, Term_3_lconv_1_5_ALL);
[Vtke_lconv_3_sort, TKE_lconv_3_sort, R_Bulk_lconv_3_sort, spd_lconv_3_sort, L_lconv_3_sort, Term_3_lconv_3_sort] = reference_sort(Vtke_lconv_3_ALL, TKE_lconv_3_ALL, R_Bulk_lconv_3_ALL, spd_lconv_3_ALL, L_lconv_3_ALL, Term_3_lconv_3_ALL);
[Vtke_lconv_4_5_sort, TKE_lconv_4_5_sort, R_Bulk_lconv_4_5_sort, spd_lconv_4_5_sort, L_lconv_4_5_sort, Term_3_lconv_4_5_sort] = reference_sort(Vtke_lconv_4_5_ALL, TKE_lconv_4_5_ALL, R_Bulk_lconv_4_5_ALL, spd_lconv_4_5_ALL, L_lconv_4_5_ALL, Term_3_lconv_4_5_ALL);
[Vtke_lconv_6_sort, TKE_lconv_6_sort, R_Bulk_lconv_6_sort, spd_lconv_6_sort, L_lconv_6_sort, Term_3_lconv_6_sort] = reference_sort(Vtke_lconv_6_ALL, TKE_lconv_6_ALL, R_Bulk_lconv_6_ALL, spd_lconv_6_ALL, L_lconv_6_ALL, Term_3_lconv_6_ALL);
[Vtke_lconv_8_5_sort, TKE_lconv_8_5_sort, R_Bulk_lconv_8_5_sort, spd_lconv_8_5_sort, L_lconv_8_5_sort, Term_3_lconv_8_5_sort] = reference_sort(Vtke_lconv_8_5_ALL, TKE_lconv_8_5_ALL, R_Bulk_lconv_8_5_ALL, spd_lconv_8_5_ALL, L_lconv_8_5_ALL, Term_3_lconv_8_5_ALL);
[Vtke_lconv_10_sort, TKE_lconv_10_sort, R_Bulk_lconv_10_sort, spd_lconv_10_sort, L_lconv_10_sort, Term_3_lconv_10_sort] = reference_sort(Vtke_lconv_10_ALL, TKE_lconv_10_ALL, R_Bulk_lconv_10_ALL, spd_lconv_10_ALL, L_lconv_10_ALL, Term_3_lconv_10_ALL);
[Vtke_lconv_15_sort, TKE_lconv_15_sort, R_Bulk_lconv_15_sort, spd_lconv_15_sort, L_lconv_15_sort, Term_3_lconv_15_sort] = reference_sort(Vtke_lconv_15_ALL, TKE_lconv_15_ALL, R_Bulk_lconv_15_ALL, spd_lconv_15_ALL, L_lconv_15_ALL, Term_3_lconv_15_ALL);
[Vtke_lconv_20_sort, TKE_lconv_20_sort, R_Bulk_lconv_20_sort, spd_lconv_20_sort, L_lconv_20_sort, Term_3_lconv_20_sort] = reference_sort(Vtke_lconv_20_ALL, TKE_lconv_20_ALL, R_Bulk_lconv_20_ALL, spd_lconv_20_ALL, L_lconv_20_ALL, Term_3_lconv_20_ALL);

% Create bar fence
bar_fence = repmat('|',length(L_lconv_20_ALL), 1);
% Group table
tempT_Bulk_sort_init = table(R_Bulk_init_1_5_sort, spd_init_1_5_sort, Vtke_init_1_5_sort, TKE_init_1_5_sort, L_init_1_5_sort, Term_3_init_1_5_sort,...
    bar_fence, R_Bulk_init_3_sort, spd_init_3_sort, Vtke_init_3_sort, TKE_init_3_sort, L_init_3_sort, Term_3_init_3_sort,...
    bar_fence, R_Bulk_init_4_5_sort, spd_init_4_5_sort, Vtke_init_4_5_sort, TKE_init_4_5_sort, L_init_4_5_sort, Term_3_init_4_5_sort,...
    bar_fence, R_Bulk_init_6_sort, spd_init_6_sort, Vtke_init_6_sort, TKE_init_6_sort, L_init_6_sort, Term_3_init_6_sort,...
    bar_fence, R_Bulk_init_10_sort, spd_init_10_sort, Vtke_init_10_sort, TKE_init_10_sort, L_init_10_sort, Term_3_init_10_sort);

tempT_Bulk_sort_rel = table(R_Bulk_rel_1_5_sort, spd_rel_1_5_sort, Vtke_rel_1_5_sort, TKE_rel_1_5_sort, L_rel_1_5_sort, Term_3_rel_1_5_sort,...
    bar_fence, R_Bulk_rel_3_sort, spd_rel_3_sort, Vtke_rel_3_sort, TKE_rel_3_sort, L_rel_3_sort, Term_3_rel_3_sort,...
    bar_fence, R_Bulk_rel_4_5_sort, spd_rel_4_5_sort, Vtke_rel_4_5_sort, TKE_rel_4_5_sort, L_rel_4_5_sort, Term_3_rel_4_5_sort,...
    bar_fence, R_Bulk_rel_6_sort, spd_rel_6_sort, Vtke_rel_6_sort, TKE_rel_6_sort, L_rel_6_sort, Term_3_rel_6_sort,...
    bar_fence, R_Bulk_rel_8_5_sort, spd_rel_8_5_sort, Vtke_rel_8_5_sort, TKE_rel_8_5_sort, L_rel_8_5_sort, Term_3_rel_8_5_sort,...
    bar_fence, R_Bulk_rel_10_sort, spd_rel_10_sort, Vtke_rel_10_sort, TKE_rel_10_sort, L_rel_10_sort, Term_3_rel_10_sort,...
    bar_fence, R_Bulk_rel_15_sort, spd_rel_15_sort, Vtke_rel_15_sort, TKE_rel_15_sort, L_rel_15_sort, Term_3_rel_15_sort,...
    bar_fence, R_Bulk_rel_20_sort, spd_rel_20_sort, Vtke_rel_20_sort, TKE_rel_20_sort, L_rel_20_sort, Term_3_rel_20_sort);

tempT_Bulk_sort_uconv = table(R_Bulk_uconv_1_5_sort, spd_uconv_1_5_sort, Vtke_uconv_1_5_sort, TKE_uconv_1_5_sort, L_uconv_1_5_sort, Term_3_uconv_1_5_sort,...
    bar_fence, R_Bulk_uconv_3_sort, spd_uconv_3_sort, Vtke_uconv_3_sort, TKE_uconv_3_sort, L_uconv_3_sort, Term_3_uconv_3_sort,...
    bar_fence, R_Bulk_uconv_4_5_sort, spd_uconv_4_5_sort, Vtke_uconv_4_5_sort, TKE_uconv_4_5_sort, L_uconv_4_5_sort, Term_3_uconv_4_5_sort,...
    bar_fence, R_Bulk_uconv_6_sort, spd_uconv_6_sort, Vtke_uconv_6_sort, TKE_uconv_6_sort, L_uconv_6_sort, Term_3_uconv_6_sort,...
    bar_fence, R_Bulk_uconv_10_sort, spd_uconv_10_sort, Vtke_uconv_10_sort, TKE_uconv_10_sort, L_uconv_10_sort, Term_3_uconv_10_sort);

tempT_Bulk_sort_lconv = table(R_Bulk_lconv_1_5_sort, spd_lconv_1_5_sort, Vtke_lconv_1_5_sort, TKE_lconv_1_5_sort, L_lconv_1_5_sort, Term_3_lconv_1_5_sort,...
    bar_fence, R_Bulk_lconv_3_sort, spd_lconv_3_sort, Vtke_lconv_3_sort, TKE_lconv_3_sort, L_lconv_3_sort, Term_3_lconv_3_sort,...
    bar_fence, R_Bulk_lconv_4_5_sort, spd_lconv_4_5_sort, Vtke_lconv_4_5_sort, TKE_lconv_4_5_sort, L_lconv_4_5_sort, Term_3_lconv_4_5_sort,...
    bar_fence, R_Bulk_lconv_6_sort, spd_lconv_6_sort, Vtke_lconv_6_sort, TKE_lconv_6_sort, L_lconv_6_sort, Term_3_lconv_6_sort,...
    bar_fence, R_Bulk_lconv_8_5_sort, spd_lconv_8_5_sort, Vtke_lconv_8_5_sort, TKE_lconv_8_5_sort, L_lconv_8_5_sort, Term_3_lconv_8_5_sort,...
    bar_fence, R_Bulk_lconv_10_sort, spd_lconv_10_sort, Vtke_lconv_10_sort, TKE_lconv_10_sort, L_lconv_10_sort, Term_3_lconv_10_sort,...
    bar_fence, R_Bulk_lconv_15_sort, spd_lconv_15_sort, Vtke_lconv_15_sort, TKE_lconv_15_sort, L_lconv_15_sort, Term_3_lconv_15_sort,...
    bar_fence, R_Bulk_lconv_20_sort, spd_lconv_20_sort, Vtke_lconv_20_sort, TKE_lconv_20_sort, L_lconv_20_sort, Term_3_lconv_20_sort);

% Format table name
table_name_Bulk_sort_init = 'init_Bulk_Sorted.csv';
table_name_Bulk_sort_rel = 'rel_Bulk_Sorted.csv';
table_name_Bulk_sort_uconv = 'uconv_Bulk_Sorted.csv';
table_name_Bulk_sort_lconv = 'lconv_Bulk_Sorted.csv';

% Output tables
writetable(tempT_Bulk_sort_init, table_name_Bulk_sort_init);
writetable(tempT_Bulk_sort_rel, table_name_Bulk_sort_rel);
writetable(tempT_Bulk_sort_uconv, table_name_Bulk_sort_uconv);
writetable(tempT_Bulk_sort_lconv, table_name_Bulk_sort_lconv);

% Check on conditions
[init_1_5_A, init_1_5_B, init_1_5_C] = idx_finder(R_Bulk_init_1_5_sort);
[init_3_A, init_3_B, init_3_C] = idx_finder(R_Bulk_init_3_sort);
[init_4_5_A, init_4_5_B, init_4_5_C] = idx_finder(R_Bulk_init_4_5_sort);
[init_6_A, init_6_B, init_6_C] = idx_finder(R_Bulk_init_6_sort);
[init_10_A, init_10_B, init_10_C] = idx_finder(R_Bulk_init_10_sort);

[rel_1_5_A, rel_1_5_B, rel_1_5_C] = idx_finder(R_Bulk_rel_1_5_sort);
[rel_3_A, rel_3_B, rel_3_C] = idx_finder(R_Bulk_rel_3_sort);
[rel_4_5_A, rel_4_5_B, rel_4_5_C] = idx_finder(R_Bulk_rel_4_5_sort);
[rel_6_A, rel_6_B, rel_6_C] = idx_finder(R_Bulk_rel_6_sort);
[rel_8_5_A, rel_8_5_B, rel_8_5_C] = idx_finder(R_Bulk_rel_8_5_sort);
[rel_10_A, rel_10_B, rel_10_C] = idx_finder(R_Bulk_rel_10_sort);
[rel_15_A, rel_15_B, rel_15_C] = idx_finder(R_Bulk_rel_15_sort);
[rel_20_A, rel_20_B, rel_20_C] = idx_finder(R_Bulk_rel_20_sort);

[uconv_1_5_A, uconv_1_5_B, uconv_1_5_C] = idx_finder(R_Bulk_uconv_1_5_sort);
[uconv_3_A, uconv_3_B, uconv_3_C] = idx_finder(R_Bulk_uconv_3_sort);
[uconv_4_5_A, uconv_4_5_B, uconv_4_5_C] = idx_finder(R_Bulk_uconv_4_5_sort);
[uconv_6_A, uconv_6_B, uconv_6_C] = idx_finder(R_Bulk_uconv_6_sort);
[uconv_10_A, uconv_10_B, uconv_10_C] = idx_finder(R_Bulk_uconv_10_sort);

[lconv_1_5_A, lconv_1_5_B, lconv_1_5_C] = idx_finder(R_Bulk_lconv_1_5_sort);
[lconv_3_A, lconv_3_B, lconv_3_C] = idx_finder(R_Bulk_lconv_3_sort);
[lconv_4_5_A, lconv_4_5_B, lconv_4_5_C] = idx_finder(R_Bulk_lconv_4_5_sort);
[lconv_6_A, lconv_6_B, lconv_6_C] = idx_finder(R_Bulk_lconv_6_sort);
[lconv_8_5_A, lconv_8_5_B, lconv_8_5_C] = idx_finder(R_Bulk_lconv_8_5_sort);
[lconv_10_A, lconv_10_B, lconv_10_C] = idx_finder(R_Bulk_lconv_10_sort);
[lconv_15_A, lconv_15_B, lconv_15_C] = idx_finder(R_Bulk_lconv_15_sort);
[lconv_20_A, lconv_20_B, lconv_20_C] = idx_finder(R_Bulk_lconv_20_sort);