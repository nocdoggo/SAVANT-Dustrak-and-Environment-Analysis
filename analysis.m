%function analysis

% Initialize memory space
clc, clear all, close all

% Start Diary Log
diary ExportLog.txt

% Get Time Stamp
START_TIME = (datetime('now'));
disp(START_TIME)

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

% Create file list
speedfile = strcat(file_dir, filesep, strcat(targetDate, '_Speed.csv'));
directionfile = strcat(file_dir, filesep, strcat(targetDate, '_Direction.csv'));
temperaturefile = strcat(file_dir, filesep, strcat(targetDate, '_Temperature.csv'));
windfile = strcat(file_dir, filesep, strcat(targetDate, '_3DWind.csv'));


% Catch if see if the file exist
if isfile(speedfile)        % Check speed file at first
    isSpeedExist = 'Y';
    fprintf('Wind speed variable exists.\n');
else
    isSpeedExist = 'N';
    fprintf('Wind speed variable does not exist.\n');
end

if isfile(directionfile)        % Check direction file at first
    isDirectionExist = 'Y';
    fprintf('Wind direction variable exists.\n');
else
    isDirectionExist = 'N';
    fprintf('Wind direction variable does not exist.\n');
end

if isfile(temperaturefile)        % Check temperature file at first
    isTempExist = 'Y';
    fprintf('Temperature variable exists.\n');
else
    isTempExist = 'N';
    fprintf('Temperature variable does not exist.\n');
end

if isfile(windfile)        % Check 3DWind file at first
    isWindExist = 'Y';
    fprintf('3DWind variable exists.\n');
else
    isWindExist = 'N';
    fprintf('3DWind variable does not exist.\n');
end

% Find Dustrak File
dustfile = strcat(file_dir, filesep, strcat(targetDate, '_Dustrak.csv'));

% Catch if see if the file exist
if isfile(dustfile)        % Check speed file at first
    isDustExist = 'Y';
    fprintf('Dustrak info exists.\n');
else
    isDustExist = 'N';
    fprintf('Dustrak info does not exist.\n');
end

if isDustExist == 'Y'
    
    dustTable = readtable(dustfile);
    
    % Split out time
    CDT_Time = dustTable{:,2};
    
    % Logger 
    DT6 = {};
    DT7 = {};
    DT8 = {};
    DT2 = {};
    DT3 = {};
    DT10 = {};
    DT9 = {};
    DT5 = {};
    
    % Find 0:00:01
    [dustLogicA, dustStart] = ismember('0:00:01', dustTable{:,2});
    [dustLogicB, dustEnd] = ismember('7:02:30', dustTable{:,2});
    
    % Loop through
    for cursor = dustStart:dustEnd
        
        % Check condition
        if (dustTable{cursor, 3} >= 0.1)
            DT6{cursor, 1} = 'Y';
        elseif (dustTable{cursor, 3} >= 0)
            DT6{cursor, 1} = 'N';
        else
            DT6{cursor, 1} = 'ERROR';
        end
        
        if (dustTable{cursor, 5} >= 0.1)
            DT5{cursor, 1} = 'Y';
        elseif (dustTable{cursor, 5} >= 0)
            DT5{cursor, 1} = 'N';
        else
            DT5{cursor, 1} = 'ERROR';
        end
        
        if (dustTable{cursor, 7} >= 0.1)
            DT8{cursor, 1} = 'Y';
        elseif (dustTable{cursor, 7} >= 0)
            DT8{cursor, 1} = 'N';
        else
            DT8{cursor, 1} = 'ERROR';
        end
        
        if (dustTable{cursor, 9} >= 0.1)
            DT2{cursor, 1} = 'Y';
        elseif (dustTable{cursor, 9} >= 0)
            DT2{cursor, 1} = 'N';
        else
            DT2{cursor, 1} = 'ERROR';
        end
        
        if (dustTable{cursor, 11} >= 0.1)
            DT3{cursor, 1} = 'Y';
        elseif (dustTable{cursor, 11} >= 0)
            DT3{cursor, 1} = 'N';
        else
            DT3{cursor, 1} = 'ERROR';
        end
        
        if (dustTable{cursor, 13} >= 0.1)
            DT10{cursor, 1} = 'Y';
        elseif (dustTable{cursor, 13} >= 0)
            DT10{cursor, 1} = 'N';
        else
            DT10{cursor, 1} = 'ERROR';
        end
        
        if (dustTable{cursor, 15} >= 0.1)
            DT9{cursor, 1} = 'Y';
        elseif (dustTable{cursor, 15} >= 0)
            DT9{cursor, 1} = 'N';
        else
            DT9{cursor, 1} = 'ERROR';
        end
        
        
    end
    
        
    

    
end

% Import data
speedTable = readtable(speedfile);
directionTable = readtable(directionfile);
temperatureTable = readtable(temperaturefile);
windTable = readtable(windfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Speed work
if isSpeedExist == 'Y'
    
    % Split out time
    CDT_Time = speedTable{:,1};
    
    % Logger 
    initSpeed = {};
    relSpeed = {};
    uconvSpeed = {};
    lconvSpeed = {};
    uconvSpeed2 = {};
    lconvSpeed2 = {};
    
    % Average link
    uconv_low_speed = {};
    uconv_high_speed = {};
    lconv_low_speed = {};
    lconv_high_speed = {};
    
    % Loop through
    for cursor = 1:length(speedTable{:,1})
        
        % Initiation tower
        if (speedTable{cursor, 4} > speedTable{cursor, 5}) && ((speedTable{cursor, 5} > speedTable{cursor, 6})) && (speedTable{cursor, 6} > speedTable{cursor, 7})
            initSpeed{cursor, 1} = 'Y';
        elseif (speedTable{cursor, 4} > speedTable{cursor, 5}) && ((speedTable{cursor, 5} > speedTable{cursor, 6})) && (speedTable{cursor, 6} < speedTable{cursor, 7})
            initSpeed{cursor, 1} = '6>10';
        elseif (speedTable{cursor, 4} < speedTable{cursor, 5}) && ((speedTable{cursor, 5} > speedTable{cursor, 6}))
            initSpeed{cursor, 1} = '1.5<3';
        else
            initSpeed{cursor, 1} = 'N';
        end
        
        % Release tower
        if (speedTable{cursor, 11} > speedTable{cursor, 12}) && ((speedTable{cursor, 12} > speedTable{cursor, 13})) && (speedTable{cursor, 13} > speedTable{cursor, 14}) && (speedTable{cursor, 14} > speedTable{cursor, 15})
            relSpeed{cursor, 1} = 'Y';
        elseif (speedTable{cursor, 11} > speedTable{cursor, 12}) && ((speedTable{cursor, 12} > speedTable{cursor, 13})) && (speedTable{cursor, 13} > speedTable{cursor, 14}) && (speedTable{cursor, 14} < speedTable{cursor, 15})
            relSpeed{cursor, 1} = '6>10';
        elseif (speedTable{cursor, 11} < speedTable{cursor, 12}) && ((speedTable{cursor, 12} > speedTable{cursor, 13})) && (speedTable{cursor, 13} > speedTable{cursor, 14})
            relSpeed{cursor, 1} = '1.5<3';
        else
            relSpeed{cursor, 1} = 'N';
        end
        
        % Upper convergence tower
        if (speedTable{cursor, 18} > speedTable{cursor, 19}) && ((speedTable{cursor, 19} > speedTable{cursor, 20})) && (speedTable{cursor, 20} > speedTable{cursor, 21}) && (speedTable{cursor, 21} > speedTable{cursor, 22})
            uconvSpeed{cursor, 1} = 'Y';
        elseif (speedTable{cursor, 18} > speedTable{cursor, 19}) && ((speedTable{cursor, 19} > speedTable{cursor, 20})) && (speedTable{cursor, 20} > speedTable{cursor, 21}) && (speedTable{cursor, 21} < speedTable{cursor, 22})
            uconvSpeed{cursor, 1} = '6>10';
        elseif (speedTable{cursor, 18} < speedTable{cursor, 19}) && ((speedTable{cursor, 19} > speedTable{cursor, 20})) && (speedTable{cursor, 20} > speedTable{cursor, 21})
            uconvSpeed{cursor, 1} = '1.5<3';
        else
            uconvSpeed{cursor, 1} = 'N';
        end
        
        uconv_low_speed{cursor, 1} = (speedTable{cursor, 18} + speedTable{cursor, 19}) / 2;
        uconv_high_speed{cursor, 1} = (speedTable{cursor, 20} + speedTable{cursor, 21}) / 2;
        
        % Check on upper conv tower
        if (uconv_low_speed{cursor, 1} > uconv_high_speed{cursor, 1})
            uconvSpeed2{cursor, 1} = 'Y';
        else
            uconvSpeed2{cursor, 1} = 'N';
        end
        
        % Lower convergence tower
        if (speedTable{cursor, 25} > speedTable{cursor, 26}) && ((speedTable{cursor, 26} > speedTable{cursor, 27})) && (speedTable{cursor, 27} > speedTable{cursor, 28}) && (speedTable{cursor, 28} > speedTable{cursor, 29})
            lconvSpeed{cursor, 1} = 'Y';
        elseif (speedTable{cursor, 25} > speedTable{cursor, 26}) && ((speedTable{cursor, 26} > speedTable{cursor, 27})) && (speedTable{cursor, 27} > speedTable{cursor, 28}) && (speedTable{cursor, 28} < speedTable{cursor, 29})
            lconvSpeed{cursor, 1} = '6>10';
        elseif (speedTable{cursor, 25} < speedTable{cursor, 26}) && ((speedTable{cursor, 26} > speedTable{cursor, 27})) && (speedTable{cursor, 27} > speedTable{cursor, 28})
            lconvSpeed{cursor, 1} = '1.5<3';
        else
            lconvSpeed{cursor, 1} = 'N';
        end 
        
        lconv_low_speed{cursor, 1} = (speedTable{cursor, 25} + speedTable{cursor, 26}) / 2;
        lconv_high_speed{cursor, 1} = (speedTable{cursor, 27} + speedTable{cursor, 28}) / 2;
        
        % Check on upper conv tower
        if (lconv_low_speed{cursor, 1} > lconv_high_speed{cursor, 1})
            lconvSpeed2{cursor, 1} = 'Y';
        else
            lconvSpeed2{cursor, 1} = 'N';
        end
        
    end
    
    % Plot it
    
    % The previous date
    figure
    plot(CDT_Time(1:60), speedTable{1:60, 3}, 'r-x', CDT_Time(1:60), speedTable{1:60, 4}, 'g-x', CDT_Time(1:60), speedTable{1:60, 5}, 'b-x', CDT_Time(1:60), speedTable{1:60, 6}, 'c-x', CDT_Time(1:60), speedTable{1:60, 7}, 'y-x', CDT_Time(1:60), speedTable{1:60, 8}, 'k-x');
    xlabel('CDT Time')
    ylabel('Initiation Tower Wind Speed')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('0.2m', '1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    yyaxis left
    plot(CDT_Time(61:146), speedTable{61:146, 3}, 'r-.', CDT_Time(61:146), speedTable{61:146, 4}, 'g-x', CDT_Time(61:146), speedTable{61:146, 5}, 'b-*', CDT_Time(61:146), speedTable{61:146, 6}, 'c-.', CDT_Time(61:146), speedTable{61:146, 7}, 'y-+', CDT_Time(61:146), speedTable{61:146, 8}, 'k->');
    xlabel('CDT Time')
    ylabel('Initiation Tower Wind Speed')
    
    yyaxis right
    plot(dustTable{dustStart:dustEnd,2}, dustTable{dustStart:dustEnd,3}, '*')
    ylabel('Dust')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('0.2m', '1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(1:60), speedTable{1:60, 10}, 'r-.', CDT_Time(1:60), speedTable{1:60, 11}, 'g-x', CDT_Time(1:60), speedTable{1:60, 12}, 'b-*', CDT_Time(1:60), speedTable{1:60, 13}, 'c-.', CDT_Time(1:60), speedTable{1:60, 14}, 'y-+', CDT_Time(1:60), speedTable{1:60, 15}, 'k->');
    xlabel('CDT Time')
    ylabel('Release Tower Wind Speed')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('0.2m', '1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(61:146), speedTable{61:146, 10}, 'r-.', CDT_Time(61:146), speedTable{61:146, 11}, 'g-x', CDT_Time(61:146), speedTable{61:146, 12}, 'b-*', CDT_Time(61:146), speedTable{61:146, 13}, 'c-.', CDT_Time(61:146), speedTable{61:146, 14}, 'y-+', CDT_Time(61:146), speedTable{61:146, 15}, 'k->');
    xlabel('CDT Time')
    ylabel('Release Tower Wind Speed')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('0.2m', '1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(1:60), speedTable{1:60, 17}, 'r-.', CDT_Time(1:60), speedTable{1:60, 18}, 'g-x', CDT_Time(1:60), speedTable{1:60, 19}, 'b-*', CDT_Time(1:60), speedTable{1:60, 20}, 'c-.', CDT_Time(1:60), speedTable{1:60, 21}, 'y-+', CDT_Time(1:60), speedTable{1:60, 22}, 'k->');
    xlabel('CDT Time')
    ylabel('Upper Convergence Tower Wind Speed')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('0.2m', '1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(61:146), speedTable{61:146, 17}, 'r-.', CDT_Time(61:146), speedTable{61:146, 18}, 'g-x', CDT_Time(61:146), speedTable{61:146, 19}, 'b-*', CDT_Time(61:146), speedTable{61:146, 20}, 'c-.', CDT_Time(61:146), speedTable{61:146, 21}, 'y-+', CDT_Time(61:146), speedTable{61:146, 22}, 'k->');
    xlabel('CDT Time')
    ylabel('Upper Convergence Tower Wind Speed')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('0.2m', '1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(1:60), speedTable{1:60, 24}, 'r-.', CDT_Time(1:60), speedTable{1:60, 25}, 'g-x', CDT_Time(1:60), speedTable{1:60, 26}, 'b-*', CDT_Time(1:60), speedTable{1:60, 27}, 'c-.', CDT_Time(1:60), speedTable{1:60, 28}, 'y-+', CDT_Time(1:60), speedTable{1:60, 29}, 'k->');
    xlabel('CDT Time')
    ylabel('Lower Convergence Tower Wind Speed')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('0.2m', '1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(61:146), speedTable{61:146, 24}, 'r-.', CDT_Time(61:146), speedTable{61:146, 25}, 'g-x', CDT_Time(61:146), speedTable{61:146, 26}, 'b-*', CDT_Time(61:146), speedTable{61:146, 27}, 'c-.', CDT_Time(61:146), speedTable{61:146, 28}, 'y-+', CDT_Time(61:146), speedTable{61:146, 29}, 'k->');
    xlabel('CDT Time')
    ylabel('Lower Convergence Tower Wind Speed')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('0.2m', '1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
end

if isDirectionExist == 'Y'
    
    % Split out time
    CDT_Time = directionTable{:,1};
    
    % Logger 
    initDirection = {};
    relDirection = {};
    uconvDirection = {};
    lconvDirection = {};
    
    % Loop through
    for cursor = 1:length(directionTable{:,1})
        
        % Initiation tower
        if (270 <= directionTable{cursor, 4} ) && (directionTable{cursor, 4} <= 310)
            if (270 <= directionTable{cursor, 5} ) && (directionTable{cursor, 5} <= 310)
                if (270 <= directionTable{cursor, 6} ) && (directionTable{cursor, 6} <= 310)
                    initDirection{cursor, 1} = 'Y';
                else
                    initDirection{cursor, 1} = 'X4.5';
                end
            elseif (270 <= directionTable{cursor, 6} ) && (directionTable{cursor, 6} <= 310)
                initDirection{cursor, 1} = 'X3';
            else
                initDirection{cursor, 1} = 'V1.5';
            end
        else
            initDirection{cursor, 1} = 'N';
        end      
        
        % Release tower
        if (270 <= directionTable{cursor, 11} ) && (directionTable{cursor, 11} <= 310)
            if (270 <= directionTable{cursor, 12} ) && (directionTable{cursor, 12} <= 310)
                if (270 <= directionTable{cursor, 13} ) && (directionTable{cursor, 13} <= 310)
                    relDirection{cursor, 1} = 'Y';
                else
                    relDirection{cursor, 1} = 'X4.5';
                end
            elseif (270 <= directionTable{cursor, 13} ) && (directionTable{cursor, 13} <= 310)
                relDirection{cursor, 1} = 'X3';
            else
                relDirection{cursor, 1} = 'V1.5';
            end
        else
            relDirection{cursor, 1} = 'N';
        end
        
        % Upper convergence tower
        if (270 <= directionTable{cursor, 18} ) && (directionTable{cursor, 18} <= 310)
            if (270 <= directionTable{cursor, 19} ) && (directionTable{cursor, 19} <= 310)
                if (270 <= directionTable{cursor, 20} ) && (directionTable{cursor, 20} <= 310)
                    uconvDirection{cursor, 1} = 'Y';
                else
                    uconvDirection{cursor, 1} = 'X4.5';
                end
            elseif (270 <= directionTable{cursor, 20} ) && (directionTable{cursor, 20} <= 310)
                uconvDirection{cursor, 1} = 'X3';
            else
                uconvDirection{cursor, 1} = 'V1.5';
            end
        else
            uconvDirection{cursor, 1} = 'N';
        end
        
        % Lower convergence tower
        if (270 <= directionTable{cursor, 25} ) && (directionTable{cursor, 25} <= 310)
            if (270 <= directionTable{cursor, 26} ) && (directionTable{cursor, 26} <= 310)
                if (270 <= directionTable{cursor, 27} ) && (directionTable{cursor, 27} <= 310)
                    lconvDirection{cursor, 1} = 'Y';
                else
                    lconvDirection{cursor, 1} = 'X4.5';
                end
            elseif (270 <= directionTable{cursor, 27} ) && (directionTable{cursor, 27} <= 310)
                lconvDirection{cursor, 1} = 'X3';
            else
                lconvDirection{cursor, 1} = 'V1.5';
            end
        else
            lconvDirection{cursor, 1} = 'N';
        end
        
    end
    
    % Plot it
    figure
    plot(CDT_Time(1:60), directionTable{1:60, 4}, 'g-x', CDT_Time(1:60), directionTable{1:60, 5}, 'b-*', CDT_Time(1:60), directionTable{1:60, 6}, 'r-.', CDT_Time(1:60), directionTable{1:60, 7}, 'c-+', CDT_Time(1:60), directionTable{1:60, 8}, 'k>');
    xlabel('CDT Time')
    ylabel('Initiation Tower Wind Direction')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(61:146), directionTable{61:146, 4}, 'g-x', CDT_Time(61:146), directionTable{61:146, 5}, 'b-*', CDT_Time(61:146), directionTable{61:146, 6}, 'r-.', CDT_Time(61:146), directionTable{61:146, 7}, 'c-+', CDT_Time(61:146), directionTable{61:146, 8}, 'k>');
    xlabel('CDT Time')
    ylabel('Initiation Tower Wind Direction')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(1:60), directionTable{1:60, 11}, 'g-x', CDT_Time(1:60), directionTable{1:60, 12}, 'b-*', CDT_Time(1:60), directionTable{1:60, 13}, 'r-.', CDT_Time(1:60), directionTable{1:60, 14}, 'c-+', CDT_Time(1:60), directionTable{1:60, 15}, 'k>');
    xlabel('CDT Time')
    ylabel('Release Tower Wind Direction')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(61:146), directionTable{61:146, 11}, 'g-x', CDT_Time(61:146), directionTable{61:146, 12}, 'b-*', CDT_Time(61:146), directionTable{61:146, 13}, 'r-.', CDT_Time(61:146), directionTable{61:146, 14}, 'c-+', CDT_Time(61:146), directionTable{61:146, 15}, 'k>');
    xlabel('CDT Time')
    ylabel('Release Tower Wind Direction')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(1:60), directionTable{1:60, 18}, 'g-x', CDT_Time(1:60), directionTable{1:60, 19}, 'b-*', CDT_Time(1:60), directionTable{1:60, 20}, 'r-.', CDT_Time(1:60), directionTable{1:60, 21}, 'c-+', CDT_Time(1:60), directionTable{1:60, 22}, 'k>');
    xlabel('CDT Time')
    ylabel('Upper Convergence Tower Wind Direction')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(61:146), directionTable{61:146, 18}, 'g-x', CDT_Time(61:146), directionTable{61:146, 19}, 'b-*', CDT_Time(61:146), directionTable{61:146, 20}, 'r-.', CDT_Time(61:146), directionTable{61:146, 21}, 'c-+', CDT_Time(61:146), directionTable{61:146, 22}, 'k>');
    xlabel('CDT Time')
    ylabel('Upper Convergence Tower Wind Direction')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(1:60), directionTable{1:60, 25}, 'g-x', CDT_Time(1:60), directionTable{1:60, 26}, 'b-*', CDT_Time(1:60), directionTable{1:60, 27}, 'r-.', CDT_Time(1:60), directionTable{1:60, 28}, 'c-+', CDT_Time(1:60), directionTable{1:60, 29}, 'k>');
    xlabel('CDT Time')
    ylabel('Lower Convergence Tower Wind Direction')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
    figure
    plot(CDT_Time(61:146), directionTable{61:146, 25}, 'g-x', CDT_Time(61:146), directionTable{61:146, 26}, 'b-*', CDT_Time(61:146), directionTable{61:146, 27}, 'r-.', CDT_Time(61:146), directionTable{61:146, 28}, 'c-+', CDT_Time(61:146), directionTable{61:146, 29}, 'k>');
    xlabel('CDT Time')
    ylabel('Lower Convergence Tower Wind Direction')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('1.5m', '3.0m', '4.5m', '6.0m', '10m')
    
end

if isTempExist == 'Y'
    
    % Split out time
    CDT_Time = temperatureTable{:,1};
    
    % Logger 
    initTemperature = {};
    relTemperature = {};
    uconvTemperature = {};
    lconvTemperature = {};
    
    % Loop through
    for cursor = 1:length(temperatureTable{:,1})
        
        % Initiation tower
        if (temperatureTable{cursor, 3} < temperatureTable{cursor, 4}) && (temperatureTable{cursor, 4} < temperatureTable{cursor, 5})
            initTemperature{cursor, 1} = 'Y';
        elseif (temperatureTable{cursor, 3} < temperatureTable{cursor, 4}) && (temperatureTable{cursor, 4} > temperatureTable{cursor, 5})
            initTemperature{cursor, 1} = '1.5>4.5';
        elseif (temperatureTable{cursor, 3} > temperatureTable{cursor, 4}) && (temperatureTable{cursor, 4} < temperatureTable{cursor, 5})
            initTemperature{cursor, 1} = '0.2>1.5';
        else
            initTemperature{cursor, 1} = 'N';
        end
        
        % Release tower
        if (temperatureTable{cursor, 10} < temperatureTable{cursor, 11}) && (temperatureTable{cursor, 11} < temperatureTable{cursor, 12})
            if (temperatureTable{cursor, 12} < temperatureTable{cursor, 13})
                if (temperatureTable{cursor, 13} < temperatureTable{cursor, 14})
                    relTemperature{cursor, 1} = 'Y';
                else
                    relTemperature{cursor, 1} = '8.5>15';
                end
            elseif (temperatureTable{cursor, 13} < temperatureTable{cursor, 14})
                    relTemperature{cursor, 1} = '4.5>8.5';
                else
                    relTemperature{cursor, 1} = '4.5>>';
            end         
        elseif (temperatureTable{cursor, 10} < temperatureTable{cursor, 11}) && (temperatureTable{cursor, 11} > temperatureTable{cursor, 12})
            relTemperature{cursor, 1} = '1.5>4.5';
        elseif (temperatureTable{cursor, 10} > temperatureTable{cursor, 11}) && (temperatureTable{cursor, 11} < temperatureTable{cursor, 12})
            relTemperature{cursor, 1} = '0.2>1.5';
        else
            relTemperature{cursor, 1} = 'N';
        end
        
        % Upper convergence tower
        if (temperatureTable{cursor, 17} < temperatureTable{cursor, 18}) && (temperatureTable{cursor, 18} < temperatureTable{cursor, 19})
            uconvTemperature{cursor, 1} = 'Y';
        elseif (temperatureTable{cursor, 17} < temperatureTable{cursor, 18}) && (temperatureTable{cursor, 18} > temperatureTable{cursor, 19})
            uconvTemperature{cursor, 1} = '1.5>4.5';
        elseif (temperatureTable{cursor, 17} > temperatureTable{cursor, 18}) && (temperatureTable{cursor, 18} < temperatureTable{cursor, 19})
            uconvTemperature{cursor, 1} = '0.2>1.5';
        else
            uconvTemperature{cursor, 1} = 'N';
        end
        
        % Lower convergence tower
        if (temperatureTable{cursor, 24} < temperatureTable{cursor, 25}) && (temperatureTable{cursor, 25} < temperatureTable{cursor, 26})
            if (temperatureTable{cursor, 26} < temperatureTable{cursor, 27})
                if (temperatureTable{cursor, 27} < temperatureTable{cursor, 28})
                    lconvTemperature{cursor, 1} = 'Y';
                else
                    lconvTemperature{cursor, 1} = '8.5>15';
                end
            elseif (temperatureTable{cursor, 27} < temperatureTable{cursor, 28})
                    lconvTemperature{cursor, 1} = '4.5>8.5';
                else
                    lconvTemperature{cursor, 1} = '4.5>>';
            end         
        elseif (temperatureTable{cursor, 24} < temperatureTable{cursor, 25}) && (temperatureTable{cursor, 25} > temperatureTable{cursor, 26})
            lconvTemperature{cursor, 1} = '1.5>4.5';
        elseif (temperatureTable{cursor, 24} > temperatureTable{cursor, 25}) && (temperatureTable{cursor, 25} < temperatureTable{cursor, 26})
            lconvTemperature{cursor, 1} = '0.2>1.5';
        else
            lconvTemperature{cursor, 1} = 'N';
        end
        
    end
    
    % Plot it
    figure
    plot(CDT_Time(1:60), temperatureTable{1:60, 3}, 'r-.', CDT_Time(1:60), temperatureTable{1:60, 4}, 'g-x', CDT_Time(1:60), temperatureTable{1:60, 5}, 'b-*');
    xlabel('CDT Time')
    ylabel('Initiation Tower Wind Direction')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('0.2m', '1.5m', '4.5m')
    
    figure
    plot(CDT_Time(61:146), temperatureTable{61:146, 3}, 'r-.', CDT_Time(61:146), temperatureTable{61:146, 4}, 'g-x', CDT_Time(61:146), temperatureTable{61:146, 5}, 'b-*');
    xlabel('CDT Time')
    ylabel('Initiation Tower Wind Direction')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('0.2m', '1.5m', '4.5m')
    
    figure
    plot(CDT_Time(1:60), temperatureTable{1:60, 10}, 'r-.', CDT_Time(1:60), temperatureTable{1:60, 11}, 'g-x', CDT_Time(1:60), temperatureTable{1:60, 12}, 'b-*', CDT_Time(1:60), temperatureTable{1:60, 13}, 'c-.', CDT_Time(1:60), temperatureTable{1:60, 14}, 'y-+', CDT_Time(1:60), temperatureTable{1:60, 15}, 'k->');
    xlabel('CDT Time')
    ylabel('Release Tower Wind Direction')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('0.2m', '1.5m', '4.5m', '8.5m', '15m', '20m')
    
    figure
    plot(CDT_Time(61:146), temperatureTable{61:146, 10}, 'r-.', CDT_Time(61:146), temperatureTable{61:146, 11}, 'g-x', CDT_Time(61:146), temperatureTable{61:146, 12}, 'b-*', CDT_Time(61:146), temperatureTable{61:146, 13}, 'c-.', CDT_Time(61:146), temperatureTable{61:146, 14}, 'y-+', CDT_Time(61:146), temperatureTable{61:146, 15}, 'k->');
    xlabel('CDT Time')
    ylabel('Release Tower Wind Direction')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('0.2m', '1.5m', '4.5m', '8.5m', '15m', '20m')
    
    figure
    plot(CDT_Time(1:60), temperatureTable{1:60, 17}, 'r-.', CDT_Time(1:60), temperatureTable{1:60, 18}, 'g-x', CDT_Time(1:60), temperatureTable{1:60, 19}, 'b-*');
    xlabel('CDT Time')
    ylabel('Upper Convergence Tower Wind Direction')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('0.2m', '1.5m', '4.5m')
    
    figure
    plot(CDT_Time(61:146), temperatureTable{61:146, 17}, 'r-.', CDT_Time(61:146), temperatureTable{61:146, 18}, 'g-x', CDT_Time(61:146), temperatureTable{61:146, 19}, 'b-*');
    xlabel('CDT Time')
    ylabel('Upper Convergence Tower Wind Direction')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('0.2m', '1.5m', '4.5m')
    
    figure
    plot(CDT_Time(1:60), temperatureTable{1:60, 24}, 'r-.', CDT_Time(1:60), temperatureTable{1:60, 25}, 'g-x', CDT_Time(1:60), temperatureTable{1:60, 26}, 'b-*', CDT_Time(1:60), temperatureTable{1:60, 27}, 'c-.', CDT_Time(1:60), temperatureTable{1:60, 28}, 'y-+', CDT_Time(1:60), temperatureTable{1:60, 29}, 'k->');
    xlabel('CDT Time')
    ylabel('Lower Convergence Tower Wind Direction')
    title(strcat(num2str(dateStamp - 1), ' Data'))
    legend('0.2m', '1.5m', '4.5m', '8.5m', '15m', '20m')
    
    figure
    plot(CDT_Time(61:146), temperatureTable{61:146, 24}, 'r-.', CDT_Time(61:146), temperatureTable{61:146, 25}, 'g-x', CDT_Time(61:146), temperatureTable{61:146, 26}, 'b-*', CDT_Time(61:146), temperatureTable{61:146, 27}, 'c-.', CDT_Time(61:146), temperatureTable{61:146, 28}, 'y-+', CDT_Time(61:146), temperatureTable{61:146, 29}, 'k->');
    xlabel('CDT Time')
    ylabel('Lower Convergence Tower Wind Direction')
    title(strcat(num2str(dateStamp), ' Data'))
    legend('0.2m', '1.5m', '4.5m', '8.5m', '15m', '20m')
    
end

close all

if isWindExist == 'Y'
    
    % Split out time
    CDT_Time = windTable{:,1};
    
    % Generate empty column
    bar_fence = repmat('|',length(CDT_Time),1);
    
%     % Logger 
%     uconvU = {};
%     uconvV = {};
%     uconvW = {};
%     
%     lconvU = {};
%     lconvV = {};
%     lconvW = {};
    
    % Define constant values
    g = 9.8;
    R_critical = 0.25;
    k = 0.4;
    
    
    % Bulk Richardson Number
    for iteration = 1:3     % As for the theta_v, we are using the lower surface temp
        if iteration == 1
            upper_height = 4.5;
            lower_height = 1.5;
%             delta_theta_v = temperatureTable{:, 19} - temperatureTable{:, 18};
            delta_theta_v = windTable{:, 50} - windTable{:, 48};        % Now using virtual temperatures
            delta_z = upper_height - lower_height;
%             theta_v = temperatureTable{:, 18};
            theta_v_low = windTable{:, 48};     % Now using virtual temperature
            theta_v_high = windTable{: 50};
            delta_u = windTable{:, 5} - windTable{:, 3};
            delta_v = windTable{:, 20} - windTable{:, 18};
            u_star_low = ((windTable{:, 78}.*windTable{:, 78}) + (windTable{:, 93}.*windTable{:, 93})).^(0.25);
            u_star_high = ((windTable{:, 80}.*windTable{:, 80}) + (windTable{:, 95}.*windTable{:, 95})).^(0.25);
            w_theta_v_low = windTable{:, 63};
            w_theta_v_high = windTable{:, 65};
            
            % Initialization for R_Bulk
            R_Bulk_up = [];
            R_Bulk_down = [];
            R_Bulk = [];
            L_up_low = [];
            L_down_low = [];
            L_low = [];
            L_up_high = [];
            L_down_high = [];
            L_high = [];
        
            for idx = 1:length(CDT_Time)
            
                % Try to calculate the R_Bulk
                try
                    R_Bulk_up(idx, 1) = g .* delta_theta_v(idx, 1) * delta_z;
                    R_Bulk_down(idx, 1) = theta_v_low(idx, 1) .* ((delta_u(idx, 1).*delta_u(idx, 1)) + (delta_v(idx, 1).*delta_v(idx, 1)));
                    R_Bulk(idx, 1) = R_Bulk_up(idx, 1) ./ R_Bulk_down(idx, 1);
                catch
                    errmsg('red','bulk Richardson number is not calculatable @: \n');
                    errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                end
                
                % Try to calculate the lower surface Obukhov length
                try
                    L_up_low(idx, 1) = -theta_v_low(idx, 1) .* ((u_star_low(idx, 1)).^3);
                    L_down_low(idx, 1) = k * g .* w_theta_v_low(idx, 1);
                    L_low(idx, 1) = L_up_low(idx, 1) ./ L_down_low(idx, 1);
                catch
                    errmsg('red','Obukhov length for lower surface is not calculatable @: \n');
                    errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                end
                
                % Try to calculate the lower surface Obukhov length
                try
                    L_up_high(idx, 1) = -theta_v_high(idx, 1) .* ((u_star_high(idx, 1)).^3);
                    L_down_high(idx, 1) = k * g .* w_theta_v_high(idx, 1);
                    L_high(idx, 1) = L_up_high(idx, 1) ./ L_down_high(idx, 1);
                catch
                    errmsg('red','Obukhov length for higher surface is not calculatable @: \n');
                    errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                end
                
            end
                
            % Form a csv dump
            tempT_uconv_bulk = table(CDT_Time, bar_fence, R_Bulk);
            table_name_uconv_bulk = strcat(targetDate, '_bulk_uconv_1.5-4.5.xlsx');
            writetable(tempT_uconv_bulk, table_name_uconv_bulk);
        elseif iteration == 2
            upper_height = 4.5;
            lower_height = 1.5;
            delta_theta_v = temperatureTable{:, 26} - temperatureTable{:, 25};
            delta_z = upper_height - lower_height;
            theta_v = temperatureTable{:, 25};
            delta_u = windTable{:, 11} - windTable{:, 9};
            delta_v = windTable{:, 26} - windTable{:, 24};
            
            % Initialization for R_Bulk
            R_Bulk_up = [];
            R_Bulk_down = [];
            R_Bulk = [];
        
            for idx = 1:length(CDT_Time)
            
                % Try to calculate the R_Bulk
                try
                    R_Bulk_up(idx, 1) = g .* delta_theta_v(idx, 1) * delta_z;
                    R_Bulk_down(idx, 1) = theta_v(idx, 1) .* ((delta_u(idx, 1).*delta_u(idx, 1)) + (delta_v(idx, 1).*delta_v(idx, 1)));
                    R_Bulk(idx, 1) = R_Bulk_up(idx, 1) ./ R_Bulk_down(idx, 1);
                catch
                    errmsg('red','bulk Richardson number is not calculatable @: \n');
                    errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                end
            end
            
            % Form a csv dump
            tempT_lconv_bulk1 = table(CDT_Time, bar_fence, R_Bulk);
            table_name_lconv_bulk1 = strcat(targetDate, '_bulk_lconv_1.5-4.5.xlsx');
            writetable(tempT_lconv_bulk1, table_name_lconv_bulk1);
        elseif iteration == 3
            upper_height = 8.5;
            lower_height = 4.5;
            delta_theta_v = temperatureTable{:, 27} - temperatureTable{:, 26};
            delta_z = upper_height - lower_height;
            theta_v = temperatureTable{:, 26};
            delta_u = windTable{:, 13} - windTable{:, 11};
            delta_v = windTable{:, 28} - windTable{:, 26};
            
            % Initialization for R_Bulk
            R_Bulk_up = [];
            R_Bulk_down = [];
            R_Bulk = [];
        
            for idx = 1:length(CDT_Time)
            
                % Try to calculate the R_Bulk
                try
                    R_Bulk_up(idx, 1) = g .* delta_theta_v(idx, 1) * delta_z;
                    R_Bulk_down(idx, 1) = theta_v(idx, 1) .* ((delta_u(idx, 1).*delta_u(idx, 1)) + (delta_v(idx, 1).*delta_v(idx, 1)));
                    R_Bulk(idx, 1) = R_Bulk_up(idx, 1) ./ R_Bulk_down(idx, 1);
                catch
                    errmsg('red','bulk Richardson number is not calculatable @: \n');
                    errmsg('blue', '      %s\n',CDT_Time(idx, 1));
                end
            end
            % Form a csv dump
            tempT_lconv_bulk2 = table(CDT_Time, bar_fence, R_Bulk);
            table_name_lconv_bulk2 = strcat(targetDate, '_bulk_lconv_4.5-8.5.xlsx');
            writetable(tempT_lconv_bulk2, table_name_lconv_bulk2);
        end
        
    end
    
    
    
end

% Start Time
varStart = input('What would be the starting time? [x:x2:30]\n', 's');
varEnd = input('What would be the ending time? [x:x7:30]\n', 's');
[varLogA, varStartIdx] = ismember(varStart, CDT_Time);
[varLogB, varEndIdx] = ismember(varEnd, CDT_Time);
[dustLogA, dustStartIdx] = ismember(varStart, dustTable{:,2});
[dustLogB, dustEndIdx] = ismember(varEnd, dustTable{:,2});

% Try with double y-axis

% Speed
figure
yyaxis left
plot(CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 17}, 'r-x', CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 18}, 'g-x', CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 19}, 'b-x', CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 20}, 'c-x', CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 21}, 'm-x', CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 22}, 'k-x');
xlabel('CDT Time')
ylabel('Upper Convergence Tower Wind Speed')

    
yyaxis right
plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
ylabel('Dust Concentration')
title(strcat(num2str(dateStamp), ' Data'))
legend('0.2m', '1.5m', '3.0m', '4.5m', '6.0m', '10m', 'Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6')

figure
yyaxis left
plot(CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 24}, 'r-x', CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 25}, 'g-x', CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 26}, 'b-x', CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 27}, 'c-x', CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 28}, 'm-x', CDT_Time(varStartIdx:varEndIdx), speedTable{varStartIdx:varEndIdx, 29}, 'k-x');
xlabel('CDT Time')
ylabel('Lower Convergence Tower Wind Speed')

    
yyaxis right
plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
ylabel('Dust Concentration')
title(strcat(num2str(dateStamp), ' Data'))
legend('0.2m', '1.5m', '3.0m', '4.5m', '6.0m', '10m', 'Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6')

% figure  % Upper average
% yyaxis left
% plot(CDT_Time(varStartIdx:varEndIdx), uconv_low_speed{varStartIdx:varEndIdx, 1}, 'r-x', CDT_Time(varStartIdx:varEndIdx), uconv_high_speed{varStartIdx:varEndIdx, 1}, 'g-x');
% xlabel('CDT Time')
% ylabel('Uower Convergence Tower Wind Speed AVG')
% 
%     
% yyaxis right
% plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
% ylabel('Dust Concentration')
% title(strcat(num2str(dateStamp), ' Data'))
% legend('1.5 + 3.0', '4.5 + 6.0', 'Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6')

% figure  % Lower average
% yyaxis left
% plot(CDT_Time(varStartIdx:varEndIdx), lconv_low_speed{varStartIdx:varEndIdx, 1}, 'r-x', CDT_Time(varStartIdx:varEndIdx), lconv_high_speed{varStartIdx:varEndIdx, 1}, 'g-x');
% xlabel('CDT Time')
% ylabel('Lower Convergence Tower Wind Speed AVG')
% 
%     
% yyaxis right
% plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
% ylabel('Dust Concentration')
% title(strcat(num2str(dateStamp), ' Data'))
% legend('1.5 + 3.0', '4.5 + 6.0', 'Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6')
    
% Temp
figure
yyaxis left
plot(CDT_Time(varStartIdx:varEndIdx), temperatureTable{varStartIdx:varEndIdx, 17}, 'r-x', CDT_Time(varStartIdx:varEndIdx), temperatureTable{varStartIdx:varEndIdx, 18}, 'g-x', CDT_Time(varStartIdx:varEndIdx), temperatureTable{varStartIdx:varEndIdx, 19}, 'b-x');
xlabel('CDT Time')
ylabel('Upper Convergence Tower Temp')
    
yyaxis right
plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
ylabel('Dust Concentration')
title(strcat(num2str(dateStamp), ' Data'))
legend('0.2m', '1.5m', '4.5m', 'Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6')

figure
yyaxis left
plot(CDT_Time(varStartIdx:varEndIdx), temperatureTable{varStartIdx:varEndIdx, 24}, 'r-x', CDT_Time(varStartIdx:varEndIdx), temperatureTable{varStartIdx:varEndIdx, 25}, 'g-x', CDT_Time(varStartIdx:varEndIdx), temperatureTable{varStartIdx:varEndIdx, 26}, 'b-x', CDT_Time(varStartIdx:varEndIdx), temperatureTable{varStartIdx:varEndIdx, 27}, 'c-x', CDT_Time(varStartIdx:varEndIdx), temperatureTable{varStartIdx:varEndIdx, 28}, 'm-x', CDT_Time(varStartIdx:varEndIdx), temperatureTable{varStartIdx:varEndIdx, 29}, 'k-x');
xlabel('CDT Time')
ylabel('Lower Convergence Tower Temp')

yyaxis right
plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
ylabel('Dust Concentration')
title(strcat(num2str(dateStamp), ' Data'))
legend('0.2m', '1.5m', '4.5m', '8.5m', '15m', '20m', 'Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6')
    
% Direction

figure
yyaxis left
plot(CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 18}, 'g-x', CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 19}, 'b-*', CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 20}, 'r-.', CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 21}, 'c-+', CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 22}, 'k>', CDT_Time(varStartIdx:varEndIdx), 310, 'k', CDT_Time(varStartIdx:varEndIdx), 290, 'k');
xlabel('CDT Time')
ylabel('Upper Convergence Tower Wind Direction')
    
yyaxis right
plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
ylabel('Dust Concentration')
title(strcat(num2str(dateStamp), ' Data'))
legend('0.2m', '1.5m', '3.0m', '4.5m', '6m', '10m', '310', '290', 'Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6')

figure
yyaxis left
plot(CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 24}, 'r-x', CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 25}, 'g-x', CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 26}, 'b-x', CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 27}, 'c-x', CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 28}, 'm-x', CDT_Time(varStartIdx:varEndIdx), directionTable{varStartIdx:varEndIdx, 29}, 'k-x');
xlabel('CDT Time')
ylabel('Lower Convergence Tower Wind Direction')

yyaxis right
plot(dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,7}, 'r*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,9}, 'g*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,11}, 'b*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,13}, 'c*', dustTable{dustStartIdx:dustEndIdx,2}, dustTable{dustStartIdx:dustEndIdx,15}, 'k*');
ylabel('Dust Concentration')
title(strcat(num2str(dateStamp), ' Data'))
legend('0.2m', '1.5m', '3.0m', '4.5m', '6m', '10m', 'Up3.0', 'Up0', 'Low0', 'Low1.5', 'Low6')
   

diary off;


% Form tables

%bar_fence = repmat('|',length(CDT_Time),1);

%table_name = strcat(targetDate, '_dump.csv');

%tableTray = table(CDT_Time, bar_fence, initSpeed, relSpeed, uconvSpeed, lconvSpeed, bar_fence, initDirection, relDirection, uconvDirection, lconvDirection, bar_fence, initTemperature, relTemperature, uconvTemperature, lconvTemperature);

%writetable(tableTray, table_name);


%end


