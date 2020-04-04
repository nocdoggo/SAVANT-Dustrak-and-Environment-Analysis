% This is for farm_site extraction
function run_farm


% Initialize memory space
clc, clear all, close all

% Start Diary Log
diary ExportLog.txt

% Get Time Stamp
START_TIME = (datetime('now'));
disp(START_TIME)

% Input prompt
fprintf('=============================================================================');
fprintf('\n');
errmsg('magenta', 'This is for farm site data only!\n\n')
%data_dir = input('Please enter the name of the input NetCDF file folder: \n', 's');
data_dir = 'Farm_Site_Data';

% Catch all .nc files
nc_group = dir(strcat(data_dir, filesep, '*.nc'));

% Check if the directory is empty
if (isempty(nc_group))
    fprintf('\n');
    errmsg('red','No NC file detected @ %s, please check in your file explorer!\n', data_dir);
    fprintf('\n');
    return
else
    num_NC = length(nc_group);
end

% Prompt
fprintf('\n');
errmsg('blue', 'There are %d NetCDF files in this directory.\n', num_NC);
fprintf('\n');

% Start to loop through it
for idx = 1:num_NC
%for idx = 45:48       % This is for debug purposes.
    % Extract File Name
    currFile = strcat(data_dir, filesep, nc_group(idx).name);
    name = strcat(nc_group(idx).name);
    % currDate format changed
    currDate = char(extractBetween(name, 10, 13))
    % Toggle this for debugging purposes
    % ncdisp(testStr)
    time  = ncread(currFile,'time');
    len_Table = length(time);   % For putting null there
    
    % Create another duplicate
    second_counter = time;
    % Initialize Error Counter
    flag_counter = 0;
    
    
    % They use UTC timezone, that's why we need convert them to CDT.
    % Set Time Zone Flipper
    CDT_time = strings(size(time));
    % Now, we offset the time
    digit_date = str2num(currDate);
    
    if digit_date < 1104
        time = time - 18150+150;
        
        for reg = 1:length(time)
            if time(reg)<0
                time(reg)=time(reg) + 86400;
            end
            CDT_time(reg)=datestr(seconds(time(reg)),'HH:MM:SS');
        end
    else
        time = time - 21750+150;
        
        for reg = 1:length(time)
            if time(reg)<0
                time(reg)=time(reg) + 86400;
            end
            CDT_time(reg)=datestr(seconds(time(reg)),'HH:MM:SS');
        end
    end
       
    % For debug sake
    %disp(CDT_time)
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Now we try to port the data                                   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % long_name:  Air Temperature
    % units:  degC
    try
        T_3m = ncread(currFile, 'T_3m');
    catch
        errmsg('red','T.3m does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_3m = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % long_name:  Dewpoint Temperature
    % units:  degC
    try
        Td_3m = ncread(currFile, 'Td_3m');
    catch
        errmsg('red','Td.3m does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        Td_3m = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % long_name:  Relative Humidity
    % units:  %
    try
        RH_3m = ncread(currFile, 'RH_3m');
    catch
        errmsg('red','RH.3m does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        RH_3m = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % long_name:  Relative Air Pressure
    % units:  mb
    try
        P_3m = ncread(currFile, 'P_3m');
    catch
        errmsg('red','P.3m does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        P_3m = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % long_name:  Wind Speed
    % units:  m/s
    try
        Spd_3m = ncread(currFile, 'Spd_3m');
    catch
        errmsg('red','Spd.3m does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        Spd_3m = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % long_name:  Precipitation quantity
    % units:  mm
    try
        raina_3m = ncread(currFile, 'raina_3m');
    catch
        errmsg('red','raina.3m does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        raina_3m = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % long_name:  Precipitation type
    % units:  1
    try
        preciptype_3m = ncread(currFile, 'preciptype_3m');
    catch
        errmsg('red','preciptype.3m does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        preciptype_3m = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % long_name:  Precipitation intensity
    % units:  mm/hr
    try
        rainr_3m = ncread(currFile, 'rainr_3m');
    catch
        errmsg('red','rainr.3m does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        rainr_3m = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % long_name:  Act. Air Density
    % units:  kg/m
    try
        Ad_3m = ncread(currFile, 'Ad_3m');
    catch
        errmsg('red','Ad.3m does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        Ad_3m = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Now we try to filter out the precipitation period.            %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % This is the temporary solution, not sure if subject to future
    % changes.
    
    % Try to find the time stamps where there are rains
    high_freq_rain_idx = find(rainr_3m > 0);
    
    % Cut down the time before the rain starts
    high_pre = high_freq_rain_idx - 1;
    high_pre = high_pre(high_pre > 0);
    
    % Cut down
    high_post = high_freq_rain_idx + 1;
    high_post = high_post(high_post <= length(time));    % This makes sure it doesn't overflow
    
    % Now we set join
    temp_join = union(high_pre, high_freq_rain_idx);
    rain_idx = union(temp_join, high_post);
    
    % So we decide to use 1 to denote the valid data which does not have
    % rain, where as 0 as there are rains.
    raintag = ones(length(time), 1);
    raintag(rain_idx) = 0;
    
    % Down-sampling to 5-min interval to match with the other set of data
    % given by NCAR.
    five_min_rain = raintag(3:5:length(time));
    
    time_tag = CDT_time(3:5:length(time));
    
    % This is for debug purpose only
    %printer = length(five_min_rain)
    
    
    % Generate Tables
    
    % Generate empty column
    bar_fence = repmat('|',length(CDT_time),1);
    bar_line = repmat('|',length(time_tag),1);
    
    % Group table
    tempT = table(CDT_time, bar_fence, T_3m, Td_3m, RH_3m, P_3m, Spd_3m, raina_3m, preciptype_3m, rainr_3m, Ad_3m, bar_fence, second_counter, bar_fence, raintag);
    temp_raintag = table(time_tag, bar_line, five_min_rain);
    
    % Format table name
    table_name_T = strcat(currDate, '_Farm.csv');
    table_name_raintag = strcat(currDate, '_RainTag.csv');
    
    % Output Tables
    writetable(tempT, table_name_T);
    writetable(temp_raintag, table_name_raintag);
    
end

% End Logging
diary off;



end