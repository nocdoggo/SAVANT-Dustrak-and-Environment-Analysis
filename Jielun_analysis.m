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
    [Vtke_init_1_5, TKE_init_1_5, spd_init_1_5] = Jielun_TKE(windTable{:, 213}, windTable{:, 243}, windTable{:, 273}, speedTable{:, 4});
    [Vtke_init_3, TKE_init_3, spd_init_3] = Jielun_TKE(windTable{:, 214}, windTable{:, 244}, windTable{:, 274}, speedTable{:, 5});
    [Vtke_init_4_5, TKE_init_4_5, spd_init_4_5] = Jielun_TKE(windTable{:, 215}, windTable{:, 245}, windTable{:, 275}, speedTable{:, 6});
    [Vtke_init_6, TKE_init_6, spd_init_6] = Jielun_TKE(windTable{:, 216}, windTable{:, 246}, windTable{:, 276}, speedTable{:, 7});
    [Vtke_init_10, TKE_init_10, spd_init_10] = Jielun_TKE(windTable{:, 217}, windTable{:, 247}, windTable{:, 277}, speedTable{:, 8});
    
%     [a_sorted(:, 1), a_order] = sort(speedTable{:, 4});
%     newB(:, 1) = Vtke_init_1_5(a_order,1);
%     
%     A = a_sorted(:, 1);
%     B = newB(:, 1);
%     figure
%     plot(A, B, 'r')
    
    % Plot it
    figure
    plot(spd_init_1_5, Vtke_init_1_5, 'r-*', spd_init_3, Vtke_init_3, 'g-*', spd_init_4_5, Vtke_init_4_5, 'b-*', spd_init_6, Vtke_init_6, 'c-*', spd_init_10, Vtke_init_10, 'k-*')
    
    
    
    % Release tower
    [Vtke_rel_1_5, TKE_rel_1_5, spd_rel_1_5] = Jielun_TKE(windTable{:, 219}, windTable{:, 249}, windTable{:, 279}, speedTable{:, 11});
    [Vtke_rel_3, TKE_rel_3, spd_rel_3] = Jielun_TKE(windTable{:, 220}, windTable{:, 250}, windTable{:, 280}, speedTable{:, 12});
    [Vtke_rel_4_5, TKE_rel_4_5, spd_rel_4_5] = Jielun_TKE(windTable{:, 221}, windTable{:, 251}, windTable{:, 281}, speedTable{:, 13});
    [Vtke_rel_6, TKE_rel_6, spd_rel_6] = Jielun_TKE(windTable{:, 222}, windTable{:, 252}, windTable{:, 282}, speedTable{:, 14});
    [Vtke_rel_8_5, TKE_rel_8_5, spd_rel_8_5] = Jielun_TKE(windTable{:, 223}, windTable{:, 253}, windTable{:, 283}, speedTable{:, 31});
    [Vtke_rel_10, TKE_rel_10, spd_rel_10] = Jielun_TKE(windTable{:, 224}, windTable{:, 254}, windTable{:, 284}, speedTable{:, 15});
    [Vtke_rel_15, TKE_rel_15, spd_rel_15] = Jielun_TKE(windTable{:, 225}, windTable{:, 255}, windTable{:, 285}, speedTable{:, 33});
    [Vtke_rel_20, TKE_rel_20, spd_rel_20] = Jielun_TKE(windTable{:, 226}, windTable{:, 256}, windTable{:, 286}, speedTable{:, 35});
    
    % Upper convergence tower
    [Vtke_uconv_1_5, TKE_uconv_1_5, spd_uconv_1_5] = Jielun_TKE(windTable{:, 228}, windTable{:, 258}, windTable{:, 288}, speedTable{:, 18});
    [Vtke_uconv_3, TKE_uconv_3, spd_uconv_3] = Jielun_TKE(windTable{:, 229}, windTable{:, 259}, windTable{:, 289}, speedTable{:, 19});
    [Vtke_uconv_4_5, TKE_uconv_4_5, spd_uconv_4_5] = Jielun_TKE(windTable{:, 230}, windTable{:, 260}, windTable{:, 290}, speedTable{:, 20});
    [Vtke_uconv_6, TKE_uconv_6, spd_uconv_6] = Jielun_TKE(windTable{:, 231}, windTable{:, 261}, windTable{:, 291}, speedTable{:, 21});
    [Vtke_uconv_10, TKE_uconv_10, spd_uconv_10] = Jielun_TKE(windTable{:, 232}, windTable{:, 262}, windTable{:, 292}, speedTable{:, 22});
    
    % Lower convergence tower
    [Vtke_lconv_1_5, TKE_lconv_1_5, spd_lconv_1_5] = Jielun_TKE(windTable{:, 234}, windTable{:, 264}, windTable{:, 294}, speedTable{:, 25});
    [Vtke_lconv_3, TKE_lconv_3, spd_lconv_3] = Jielun_TKE(windTable{:, 235}, windTable{:, 265}, windTable{:, 295}, speedTable{:, 26});
    [Vtke_lconv_4_5, TKE_lconv_4_5, spd_lconv_4_5] = Jielun_TKE(windTable{:, 236}, windTable{:, 266}, windTable{:, 296}, speedTable{:, 27});
    [Vtke_lconv_6, TKE_lconv_6, spd_lconv_6] = Jielun_TKE(windTable{:, 237}, windTable{:, 267}, windTable{:, 297}, speedTable{:, 28});
    [Vtke_lconv_8_5, TKE_lconv_8_5, spd_lconv_8_5] = Jielun_TKE(windTable{:, 238}, windTable{:, 268}, windTable{:, 298}, speedTable{:, 32});
    [Vtke_lconv_10, TKE_lconv_10, spd_lconv_10] = Jielun_TKE(windTable{:, 239}, windTable{:, 269}, windTable{:, 299}, speedTable{:, 29});
    [Vtke_lconv_15, TKE_lconv_15, spd_lconv_15] = Jielun_TKE(windTable{:, 240}, windTable{:, 270}, windTable{:, 300}, speedTable{:, 34});
    [Vtke_lconv_20, TKE_lconv_20, spd_lconv_20] = Jielun_TKE(windTable{:, 241}, windTable{:, 271}, windTable{:, 301}, speedTable{:, 36});
    
end

