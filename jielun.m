% Analysis based on Jielun's paper
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

% Now work on importing the 3D Wind variablesa
if (isWindExist == 'Y') && (isSpeedExist == 'Y')
    
    % Import the time stamps
    CDT_Time = speedTable{:, 1};
    
    % Calculate turbulence velocity scale
    Vtke_uconv_1_5(:, 1) = [0.5* ()]^0.5;
    
    
end
