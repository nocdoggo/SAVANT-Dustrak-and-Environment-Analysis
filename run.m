function run

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
data_dir = input('Please enter the name of the input NetCDF file folder: \n', 's');

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
fprintf('There are %d NetCDF files in this directory.\n', num_NC);
fprintf('\n');

% Mode Selection
disp('How would you like your table to look like? Group by [H]eight, [T]ower. or [V]ariable, [S]ector?')
out_mode = input('[H/T/V/S]: \n', 's');

% Check Mode
if (out_mode == 'H')
    out_T = 1;
elseif (out_mode == 'T')
    out_T = 2;
elseif (out_mode == 'V')
    out_T = 3;
else
    out_T = 4;
end


% Start

for idx = 1:num_NC
    % Extract File Name
    currFile = strcat(data_dir, filesep, nc_group(idx).name);
    name = strcat(nc_group(idx).name);
    % currDate format changed
    currDate = char(extractBetween(name, 17, 20));
    % Toggle this for debugging purposes
    % ncdisp(testStr)
    time  = ncread(currFile,'time');
    len_Table = length(time);
    
    % Initialize Error Counter
    flag_counter = 0;
    
    % Extract Data Columns
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 0.2 Meter Level
    
    % Direction
    try
        dir_0_2m_init = ncread(currFile,'Dir_0_2m_init');
    catch
        errmsg('red','Dir_0_2m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_0_2m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_0_2m_rel = ncread(currFile,'Dir_0_2m_rel');
    catch
        errmsg('red','Dir_0_2m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_0_2m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_0_2m_uconv = ncread(currFile,'Dir_0_2m_uconv');
    catch
        errmsg('red','Dir_0_2m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_0_2m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_0_2m_lconv=ncread(currFile,'Dir_0_2m_lconv');
    catch
        errmsg('red','Dir_0_2m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_0_2m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % Speed
    try
        spd_0_2m_init=ncread(currFile,'Spd_0_2m_init');
    catch
        errmsg('red','Spd_0_2m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_0_2m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        flag_counter = flag_counter + 1;
        fprintf('\n')
    end
    
    try
        spd_0_2m_rel=ncread(currFile,'Spd_0_2m_rel');
    catch
        errmsg('red','Spd_0_2m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_0_2m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_0_2m_uconv=ncread(currFile,'Spd_0_2m_uconv');
    catch
        errmsg('red','Spd_0_2m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_0_2m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_0_2m_lconv=ncread(currFile,'Spd_0_2m_lconv');
    catch
        errmsg('red','Spd_0_2m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_0_2m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 1.5 Meter Level
    
    % Direction
    
    try
        dir_1_5m_init=ncread(currFile,'dir_1_5m_init');
    catch
        errmsg('red','Dir_1_5m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_1_5m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_1_5m_rel=ncread(currFile,'dir_1_5m_rel');
    catch
        errmsg('red','Dir_1_5m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_1_5m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_1_5m_uconv=ncread(currFile,'dir_1_5m_uconv');
    catch
        errmsg('red','Dir_1_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_1_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_1_5m_lconv=ncread(currFile,'dir_1_5m_lconv');
    catch
        errmsg('red','Dir_1_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_1_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_1_5m_init=ncread(currFile,'spd_1_5m_init');
    catch
        errmsg('red','Spd_1_5m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_1_5m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_1_5m_rel=ncread(currFile,'spd_1_5m_rel');
    catch
        errmsg('red','Spd_1_5m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_1_5m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_1_5m_uconv=ncread(currFile,'spd_1_5m_uconv');
    catch
        errmsg('red','Spd_1_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_1_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_1_5m_lconv=ncread(currFile,'spd_1_5m_lconv');
    catch
        errmsg('red','Spd_1_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_1_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 3 Meter Level
    
    % Direction
    
    try
        dir_3m_init=ncread(currFile,'dir_3m_init');
    catch
        errmsg('red','Dir_3m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_3m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_3m_rel=ncread(currFile,'dir_3m_rel');
    catch
        errmsg('red','Dir_3m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_3m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_3m_uconv=ncread(currFile,'dir_3m_uconv');
    catch
        errmsg('red','Dir_3m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_3m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_3m_lconv=ncread(currFile,'dir_3m_lconv');
    catch
        errmsg('red','Dir_3m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_3m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_3m_init=ncread(currFile,'spd_3m_init');
    catch
        errmsg('red','Spd_3m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_3m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_3m_rel=ncread(currFile,'spd_3m_rel');
    catch
        errmsg('red','Spd_3m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_3m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_3m_uconv=ncread(currFile,'spd_3m_uconv');
    catch
        errmsg('red','Spd_3m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_3m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_3m_lconv=ncread(currFile,'spd_3m_lconv');
    catch
        errmsg('red','Spd_3m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_3m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 4.5 Meter Level
    
    % Direction
    
    try
        dir_4_5m_init=ncread(currFile,'dir_4_5m_init');
    catch
        errmsg('red','Dir_4_5m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_4_5m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_4_5m_rel=ncread(currFile,'dir_4_5m_rel');
    catch
        errmsg('red','Dir_4_5m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_4_5m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_4_5m_uconv=ncread(currFile,'dir_4_5m_uconv');
    catch
        errmsg('red','Dir_4_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_4_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_4_5m_lconv=ncread(currFile,'dir_4_5m_lconv');
    catch
        errmsg('red','Dir_4_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_4_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_4_5m_init=ncread(currFile,'spd_4_5m_init');
    catch
        errmsg('red','Spd_4_5m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_4_5m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_4_5m_rel=ncread(currFile,'spd_4_5m_rel');
    catch
        errmsg('red','Spd_4_5m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_4_5m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_4_5m_uconv=ncread(currFile,'spd_4_5m_uconv');
    catch
        errmsg('red','Spd_4_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_4_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_4_5m_lconv=ncread(currFile,'spd_4_5m_lconv');
    catch
        errmsg('red','Spd_4_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_4_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 6 Meter Level
    
    % Direction
    
    try
        dir_6m_init=ncread(currFile,'dir_6m_init');
    catch
        errmsg('red','Dir_6m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_6m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_6m_rel=ncread(currFile,'dir_6m_rel');
    catch
        errmsg('red','Dir_6m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_6m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_6m_uconv=ncread(currFile,'dir_6m_uconv');
    catch
        errmsg('red','Dir_6m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_6m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_6m_lconv=ncread(currFile,'dir_6m_lconv');
    catch
        errmsg('red','Dir_6m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_6m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_6m_init=ncread(currFile,'spd_6m_init');
    catch
        errmsg('red','Spd_6m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_6m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_6m_rel=ncread(currFile,'spd_6m_rel');
    catch
        errmsg('red','Spd_6m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_6m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_6m_uconv=ncread(currFile,'spd_6m_uconv');
    catch
        errmsg('red','Spd_6m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_6m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_6m_lconv=ncread(currFile,'spd_6m_lconv');
    catch
        errmsg('red','Spd_6m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_6m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 10 Meter Level
    
    % Direction
    
    try
        dir_10m_init=ncread(currFile,'dir_10m_init');
    catch
        errmsg('red','Dir_10m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_10m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_10m_rel=ncread(currFile,'dir_10m_rel');
    catch
        errmsg('red','Dir_10m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_10m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_10m_uconv=ncread(currFile,'dir_10m_uconv');
    catch
        errmsg('red','Dir_10m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_10m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        dir_10m_lconv=ncread(currFile,'dir_10m_lconv');
    catch
        errmsg('red','Dir_10m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        dir_10m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_10m_init=ncread(currFile,'spd_10m_init');
    catch
        errmsg('red','Spd_10m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_10m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_10m_rel=ncread(currFile,'spd_10m_rel');
    catch
        errmsg('red','Spd_10m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_10m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_10m_uconv=ncread(currFile,'spd_10m_uconv');
    catch
        errmsg('red','Spd_10m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_10m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_10m_lconv=ncread(currFile,'spd_10m_lconv');
    catch
        errmsg('red','Spd_10m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_10m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
       
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Temperature
    % Init Tower
    try
        T_0_2m_init = ncread(currFile,'T_0_2m_init');
    catch
        errmsg('red','T_0_2m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_0_2m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_1_5m_init = ncread(currFile,'T_1_5m_init');
    catch
        errmsg('red','T_1_5m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_1_5m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_4_5m_init = ncread(currFile,'T_4_5m_init');
    catch
        errmsg('red','T_4_5m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_4_5m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_8_5m_init = ncread(currFile,'T_8_5m_init');
    catch
        errmsg('red','T_8_5m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_8_5m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_15m_init = ncread(currFile,'T_15m_init');
    catch
        errmsg('red','T_15m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_15m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_20m_init = ncread(currFile,'T_20m_init');
    catch
        errmsg('red','T_20m_init does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_20m_init = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % Rel Tower
    try
        T_0_2m_rel = ncread(currFile,'T_0_2m_rel');
    catch
        errmsg('red','T_0_2m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_0_2m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_1_5m_rel = ncread(currFile,'T_1_5m_rel');
    catch
        errmsg('red','T_1_5m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_1_5m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_4_5m_rel = ncread(currFile,'T_4_5m_rel');
    catch
        errmsg('red','T_4_5m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_4_5m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_8_5m_rel = ncread(currFile,'T_8_5m_rel');
    catch
        errmsg('red','T_8_5m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_8_5m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_15m_rel = ncread(currFile,'T_15m_rel');
    catch
        errmsg('red','T_15m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_15m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_20m_rel = ncread(currFile,'T_20m_rel');
    catch
        errmsg('red','T_20m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_20m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % Uconv Tower
    try
        T_0_2m_uconv = ncread(currFile,'T_0_2m_uconv');
    catch
        errmsg('red','T_0_2m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_0_2m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_1_5m_uconv = ncread(currFile,'T_1_5m_uconv');
    catch
        errmsg('red','T_1_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_1_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_4_5m_uconv = ncread(currFile,'T_4_5m_uconv');
    catch
        errmsg('red','T_4_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_4_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_8_5m_uconv = ncread(currFile,'T_8_5m_uconv');
    catch
        errmsg('red','T_8_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_8_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_15m_uconv = ncread(currFile,'T_15m_uconv');
    catch
        errmsg('red','T_15m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_15m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_20m_uconv = ncread(currFile,'T_20m_uconv');
    catch
        errmsg('red','T_20m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_20m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % Lconv Tower
    try
        T_0_2m_lconv = ncread(currFile,'T_0_2m_lconv');
    catch
        errmsg('red','T_0_2m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_0_2m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_1_5m_lconv = ncread(currFile,'T_1_5m_lconv');
    catch
        errmsg('red','T_1_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_1_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_4_5m_lconv = ncread(currFile,'T_4_5m_lconv');
    catch
        errmsg('red','T_4_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_4_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_8_5m_lconv = ncread(currFile,'T_8_5m_lconv');
    catch
        errmsg('red','T_8_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_8_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_15m_lconv = ncread(currFile,'T_15m_lconv');
    catch
        errmsg('red','T_15m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_15m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        T_20m_lconv = ncread(currFile,'T_20m_lconv');
    catch
        errmsg('red','T_20m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        T_20m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % U Wind Component
    % Uconv Tower
    try
        u_1_5m_uconv = ncread(currFile,'u_1_5m_uconv');
    catch
        errmsg('red','u_1_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_1_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_3m_uconv = ncread(currFile,'u_3m_uconv');
    catch
        errmsg('red','u_3m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_3m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_4_5m_uconv = ncread(currFile,'u_4_5m_uconv');
    catch
        errmsg('red','u_4_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_4_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_6m_uconv = ncread(currFile,'u_6m_uconv');
    catch
        errmsg('red','u_6m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_6m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_10m_uconv = ncread(currFile,'u_10m_uconv');
    catch
        errmsg('red','u_10m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_10m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    
    % Lconv Tower
    try
        u_1_5m_lconv = ncread(currFile,'u_1_5m_lconv');
    catch
        errmsg('red','u_1_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_1_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_3m_lconv = ncread(currFile,'u_3m_lconv');
    catch
        errmsg('red','u_3m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_3m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_4_5m_lconv = ncread(currFile,'u_4_5m_lconv');
    catch
        errmsg('red','u_4_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_4_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_6m_lconv = ncread(currFile,'u_6m_lconv');
    catch
        errmsg('red','u_6m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_6m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_8_5m_lconv = ncread(currFile,'u_8_5m_lconv');
    catch
        errmsg('red','u_8_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_8_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_10m_lconv = ncread(currFile,'u_10m_lconv');
    catch
        errmsg('red','u_10m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_10m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_15m_lconv = ncread(currFile,'u_15m_lconv');
    catch
        errmsg('red','u_15m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_15m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        u_20m_lconv = ncread(currFile,'u_20m_lconv');
    catch
        errmsg('red','u_20m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        u_20m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % V Wind Component
    % Uconv Tower
    try
        v_1_5m_uconv = ncread(currFile,'v_1_5m_uconv');
    catch
        errmsg('red','v_1_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_1_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_3m_uconv = ncread(currFile,'v_3m_uconv');
    catch
        errmsg('red','v_3m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_3m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_4_5m_uconv = ncread(currFile,'v_4_5m_uconv');
    catch
        errmsg('red','v_4_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_4_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_6m_uconv = ncread(currFile,'v_6m_uconv');
    catch
        errmsg('red','v_6m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_6m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_10m_uconv = ncread(currFile,'v_10m_uconv');
    catch
        errmsg('red','v_10m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_10m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    
    % Lconv Tower
    try
        v_1_5m_lconv = ncread(currFile,'v_1_5m_lconv');
    catch
        errmsg('red','v_1_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_1_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_3m_lconv = ncread(currFile,'v_3m_lconv');
    catch
        errmsg('red','v_3m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_3m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_4_5m_lconv = ncread(currFile,'v_4_5m_lconv');
    catch
        errmsg('red','v_4_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_4_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_6m_lconv = ncread(currFile,'v_6m_lconv');
    catch
        errmsg('red','v_6m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_6m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_8_5m_lconv = ncread(currFile,'v_8_5m_lconv');
    catch
        errmsg('red','v_8_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_8_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_10m_lconv = ncread(currFile,'v_10m_lconv');
    catch
        errmsg('red','v_10m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_10m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_15m_lconv = ncread(currFile,'v_15m_lconv');
    catch
        errmsg('red','v_15m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_15m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        v_20m_lconv = ncread(currFile,'v_20m_lconv');
    catch
        errmsg('red','v_20m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        v_20m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % W Wind Component
    % Uconv Tower
    try
        w_1_5m_uconv = ncread(currFile,'w_1_5m_uconv');
    catch
        errmsg('red','w_1_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_1_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_3m_uconv = ncread(currFile,'w_3m_uconv');
    catch
        errmsg('red','w_3m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_3m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_4_5m_uconv = ncread(currFile,'w_4_5m_uconv');
    catch
        errmsg('red','w_4_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_4_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_6m_uconv = ncread(currFile,'w_6m_uconv');
    catch
        errmsg('red','w_6m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_6m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_10m_uconv = ncread(currFile,'w_10m_uconv');
    catch
        errmsg('red','w_10m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_10m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    
    % Lconv Tower
    try
        w_1_5m_lconv = ncread(currFile,'w_1_5m_lconv');
    catch
        errmsg('red','w_1_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_1_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_3m_lconv = ncread(currFile,'w_3m_lconv');
    catch
        errmsg('red','w_3m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_3m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_4_5m_lconv = ncread(currFile,'w_4_5m_lconv');
    catch
        errmsg('red','w_4_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_4_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_6m_lconv = ncread(currFile,'w_6m_lconv');
    catch
        errmsg('red','w_6m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_6m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_8_5m_lconv = ncread(currFile,'w_8_5m_lconv');
    catch
        errmsg('red','w_8_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_8_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_10m_lconv = ncread(currFile,'w_10m_lconv');
    catch
        errmsg('red','w_10m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_10m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_15m_lconv = ncread(currFile,'w_15m_lconv');
    catch
        errmsg('red','w_15m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_15m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_20m_lconv = ncread(currFile,'w_20m_lconv');
    catch
        errmsg('red','w_20m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_20m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % Obtain virtual temperature
        % w'tc' for flux calculation
    % Uconv Tower
    try
        w_tc__1_5m_uconv = ncread(currFile,'w_tc__1_5m_uconv');
    catch
        errmsg('red','w_tc__1_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__1_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__3m_uconv = ncread(currFile,'w_tc__3m_uconv');
    catch
        errmsg('red','w_tc__3m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__3m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__4_5m_uconv = ncread(currFile,'w_tc__4_5m_uconv');
    catch
        errmsg('red','w_tc__4_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__4_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__6m_uconv = ncread(currFile,'w_tc__6m_uconv');
    catch
        errmsg('red','w_tc__6m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__6m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__10m_uconv = ncread(currFile,'w_tc__10m_uconv');
    catch
        errmsg('red','w_tc__10m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__10m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    
    % Lconv Tower
    try
        w_tc__1_5m_lconv = ncread(currFile,'w_tc__1_5m_lconv');
    catch
        errmsg('red','w_tc__1_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__1_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__3m_lconv = ncread(currFile,'w_tc__3m_lconv');
    catch
        errmsg('red','w_tc__3m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__3m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__4_5m_lconv = ncread(currFile,'w_tc__4_5m_lconv');
    catch
        errmsg('red','w_tc__4_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__4_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__6m_lconv = ncread(currFile,'w_tc__6m_lconv');
    catch
        errmsg('red','w_tc__6m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__6m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__8_5m_lconv = ncread(currFile,'w_tc__8_5m_lconv');
    catch
        errmsg('red','w_tc__8_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__8_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__10m_lconv = ncread(currFile,'w_tc__10m_lconv');
    catch
        errmsg('red','w_tc__10m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__10m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__15m_lconv = ncread(currFile,'w_tc__15m_lconv');
    catch
        errmsg('red','w_tc__15m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__15m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        w_tc__20m_lconv = ncread(currFile,'w_tc__20m_lconv');
    catch
        errmsg('red','w_tc__20m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        w_tc__20m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    % tc for flux calculation
    % Uconv Tower
    try
        tc_1_5m_uconv = ncread(currFile,'tc_1_5m_uconv');
    catch
        errmsg('red','tc_1_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_1_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_3m_uconv = ncread(currFile,'tc_3m_uconv');
    catch
        errmsg('red','tc_3m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_3m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_4_5m_uconv = ncread(currFile,'tc_4_5m_uconv');
    catch
        errmsg('red','tc_4_5m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_4_5m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_6m_uconv = ncread(currFile,'tc_6m_uconv');
    catch
        errmsg('red','tc_6m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_6m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_10m_uconv = ncread(currFile,'tc_10m_uconv');
    catch
        errmsg('red','tc_10m_uconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_10m_uconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    
    % Lconv Tower
    try
        tc_1_5m_lconv = ncread(currFile,'tc_1_5m_lconv');
    catch
        errmsg('red','tc_1_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_1_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_3m_lconv = ncread(currFile,'tc_3m_lconv');
    catch
        errmsg('red','tc_3m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_3m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_4_5m_lconv = ncread(currFile,'tc_4_5m_lconv');
    catch
        errmsg('red','tc_4_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_4_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_6m_lconv = ncread(currFile,'tc_6m_lconv');
    catch
        errmsg('red','tc_6m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_6m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_8_5m_lconv = ncread(currFile,'tc_8_5m_lconv');
    catch
        errmsg('red','tc_8_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_8_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_10m_lconv = ncread(currFile,'tc_10m_lconv');
    catch
        errmsg('red','tc_10m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_10m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_15m_lconv = ncread(currFile,'tc_15m_lconv');
    catch
        errmsg('red','tc_15m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_15m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        tc_20m_lconv = ncread(currFile,'tc_20m_lconv');
    catch
        errmsg('red','tc_20m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        tc_20m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end

    
    
    
    % Wrapping Prompt
    fprintf('\n')
    errmsg('blue', '=============================================================================\n')
    errmsg('red', '%s has finished processing with %d errors!\n', currDate, flag_counter)
    errmsg('red', 'Please check the log for more info!\n')
    errmsg('blue', '=============================================================================\n')
    fprintf('\n')
    
        
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
        
    size(CDT_time);
    
    % Generate Tables
    
    % Generate empty column
    bar_fence = repmat('|',length(CDT_time),1);
    
    if (out_T == 1)
        
        % Group Tables
        tempT_02 = table(CDT_time, bar_fence, dir_0_2m_init, dir_0_2m_rel, dir_0_2m_uconv, dir_0_2m_lconv, bar_fence, spd_0_2m_init, spd_0_2m_rel, spd_0_2m_uconv, spd_0_2m_lconv, bar_fence, T_0_2m_init, T_0_2m_rel, T_0_2m_uconv, T_0_2m_lconv);
        tempT_15 = table(CDT_time, bar_fence, dir_1_5m_init, dir_1_5m_rel, dir_1_5m_uconv, dir_1_5m_lconv, bar_fence, spd_1_5m_init, spd_1_5m_rel, spd_1_5m_uconv, spd_1_5m_lconv, bar_fence, T_1_5m_init, T_1_5m_rel, T_1_5m_uconv, T_1_5m_lconv);
        tempT_30 = table(CDT_time, bar_fence, dir_3m_init, dir_3m_rel, dir_3m_uconv, dir_3m_lconv, bar_fence, spd_3m_init, spd_3m_rel, spd_3m_uconv, spd_3m_lconv);
        tempT_45 = table(CDT_time, bar_fence, dir_4_5m_init, dir_4_5m_rel, dir_4_5m_uconv, dir_4_5m_lconv, bar_fence, spd_4_5m_init, spd_4_5m_rel, spd_4_5m_uconv, spd_4_5m_lconv, bar_fence, T_4_5m_init, T_4_5m_rel, T_4_5m_uconv, T_4_5m_lconv);
        tempT_60 = table(CDT_time, bar_fence, dir_6m_init, dir_6m_rel, dir_6m_uconv, dir_6m_lconv, bar_fence, spd_6m_init, spd_6m_rel, spd_6m_uconv, spd_6m_lconv);
        tempT_100 = table(CDT_time, bar_fence, dir_10m_init, dir_10m_rel, dir_10m_uconv, dir_10m_lconv, bar_fence, spd_10m_init, spd_10m_rel, spd_10m_uconv, spd_10m_lconv);
    
        heatT_85 = table(CDT_time, bar_fence, T_8_5m_init, T_8_5m_rel, T_8_5m_uconv, T_8_5m_lconv);
        heatT_150 = table(CDT_time, bar_fence, T_15m_init, T_15m_rel, T_15m_uconv, T_15m_lconv);
        heatT_200 = table(CDT_time, bar_fence, T_20m_init, T_20m_rel, T_20m_uconv, T_20m_lconv);
    
        % Format Table Names
        table_name_02 = strcat(currDate, '_0.2m.xlsx');
        table_name_15 = strcat(currDate, '_1.5m.xlsx');
        table_name_30 = strcat(currDate, '_3.0m.xlsx');
        table_name_45 = strcat(currDate, '_4.5m.xlsx');
        table_name_60 = strcat(currDate, '_6.0m.xlsx');
        table_name_100 = strcat(currDate, '_10.0m.xlsx');
        table_name_85 = strcat(currDate, '_8.5m.xlsx');
        table_name_150 = strcat(currDate, '_15.0m.xlsx');
        table_name_200 = strcat(currDate, '_20.0m.xlsx');

        % Output Tables
        writetable(tempT_02, table_name_02);
        writetable(tempT_15, table_name_15);
        writetable(tempT_30, table_name_30);
        writetable(tempT_45, table_name_45);
        writetable(tempT_60, table_name_60);
        writetable(tempT_100, table_name_100);
        writetable(heatT_85, table_name_85);
        writetable(heatT_150, table_name_150);
        writetable(heatT_200, table_name_200);
    elseif (out_T == 2)
        
        % Group Tables
        tempT_init = table(CDT_time, bar_fence, dir_0_2m_init, dir_1_5m_init, dir_3m_init, dir_4_5m_init, dir_6m_init, dir_10m_init, bar_fence, spd_0_2m_init, spd_1_5m_init, spd_3m_init, spd_4_5m_init, spd_6m_init, spd_10m_init, bar_fence, T_0_2m_init, T_1_5m_init, T_4_5m_init, T_8_5m_init, T_15m_init, T_20m_init);
        tempT_rel = table(CDT_time, bar_fence, dir_0_2m_rel, dir_1_5m_rel, dir_3m_rel, dir_4_5m_rel, dir_6m_rel, dir_10m_rel, bar_fence, spd_0_2m_rel, spd_1_5m_rel, spd_3m_rel, spd_4_5m_rel, spd_6m_rel, spd_10m_rel, bar_fence, T_0_2m_rel, T_1_5m_rel, T_4_5m_rel, T_8_5m_rel, T_15m_rel, T_20m_rel);
        tempT_uconv = table(CDT_time, bar_fence, dir_0_2m_uconv, dir_1_5m_uconv, dir_3m_uconv, dir_4_5m_uconv, dir_6m_uconv, dir_10m_uconv, bar_fence, spd_0_2m_uconv, spd_1_5m_uconv, spd_3m_uconv, spd_4_5m_uconv, spd_6m_uconv, spd_10m_uconv, bar_fence, T_0_2m_uconv, T_1_5m_uconv, T_4_5m_uconv, T_8_5m_uconv, T_15m_uconv, T_20m_uconv);
        tempT_lconv = table(CDT_time, bar_fence, dir_0_2m_lconv, dir_1_5m_lconv, dir_3m_lconv, dir_4_5m_lconv, dir_6m_lconv, dir_10m_lconv, bar_fence, spd_0_2m_lconv, spd_1_5m_lconv, spd_3m_lconv, spd_4_5m_lconv, spd_6m_lconv, spd_10m_lconv, bar_fence, T_0_2m_lconv, T_1_5m_lconv, T_4_5m_lconv, T_8_5m_lconv, T_15m_lconv, T_20m_lconv);
        
    
        % Format Table Names
        table_name_init = strcat(currDate, '_init.xlsx');
        table_name_rel = strcat(currDate, '_rel.xlsx');
        table_name_uconv = strcat(currDate, '_uconv.xlsx');
        table_name_lconv = strcat(currDate, '_lconv.xlsx');

        % Output Tables
        writetable(tempT_init, table_name_init);
        writetable(tempT_rel, table_name_rel);
        writetable(tempT_uconv, table_name_uconv);
        writetable(tempT_lconv, table_name_lconv);
        
    elseif (out_T == 3)
        
        % Group Tables
        tempT_dir = table(CDT_time, bar_fence, dir_0_2m_init, dir_0_2m_rel, dir_0_2m_uconv, dir_0_2m_lconv, bar_fence, dir_1_5m_init, dir_1_5m_rel, dir_1_5m_uconv, dir_1_5m_lconv, bar_fence, dir_3m_init, dir_3m_rel, dir_3m_uconv, dir_3m_lconv, bar_fence, dir_4_5m_init, dir_4_5m_rel, dir_4_5m_uconv, dir_4_5m_lconv, bar_fence, dir_6m_init, dir_6m_rel, dir_6m_uconv, dir_6m_lconv, bar_fence, dir_10m_init, dir_10m_rel, dir_10m_uconv, dir_10m_lconv);
        tempT_T = table(CDT_time, bar_fence, T_0_2m_init, T_0_2m_rel, T_0_2m_uconv, T_0_2m_lconv, bar_fence, T_1_5m_init, T_1_5m_rel, T_1_5m_uconv, T_1_5m_lconv, bar_fence, T_4_5m_init, T_4_5m_rel, T_4_5m_uconv, T_4_5m_lconv, bar_fence, T_8_5m_init, T_8_5m_rel, T_8_5m_uconv, T_8_5m_lconv, bar_fence, T_15m_init, T_15m_rel, T_15m_uconv, T_15m_lconv, bar_fence, T_20m_init, T_20m_rel, T_20m_uconv, T_20m_lconv);
        tempT_spd = table(CDT_time, bar_fence, spd_0_2m_init, spd_0_2m_rel, spd_0_2m_uconv, spd_0_2m_lconv, bar_fence, spd_1_5m_init, spd_1_5m_rel, spd_1_5m_uconv, spd_1_5m_lconv, bar_fence, spd_3m_init, spd_3m_rel, spd_3m_uconv, spd_3m_lconv, bar_fence, spd_4_5m_init, spd_4_5m_rel, spd_4_5m_uconv, spd_4_5m_lconv, bar_fence, spd_6m_init, spd_6m_rel, spd_6m_uconv, spd_6m_lconv, bar_fence, spd_10m_init, spd_10m_rel, spd_10m_uconv, spd_10m_lconv);
        
        % Format Table Names
        table_name_dir = strcat(currDate, '_Direction.csv');
        table_name_T = strcat(currDate, '_Temperature.csv');
        table_name_spd = strcat(currDate, '_Speed.csv');
        
        % Output Tables
        writetable(tempT_dir, table_name_dir);
        writetable(tempT_T, table_name_T);
        writetable(tempT_spd, table_name_spd);
        
    else
        
        % Group Tables
        tempT_dir2 = table(CDT_time, bar_fence, dir_0_2m_init, dir_1_5m_init, dir_3m_init, dir_4_5m_init, dir_6m_init, dir_10m_init, bar_fence, dir_0_2m_rel, dir_1_5m_rel, dir_3m_rel, dir_4_5m_rel, dir_6m_rel, dir_10m_rel, bar_fence, dir_0_2m_uconv, dir_1_5m_uconv, dir_3m_uconv, dir_4_5m_uconv, dir_6m_uconv, dir_10m_uconv, bar_fence, dir_0_2m_lconv, dir_1_5m_lconv, dir_3m_lconv, dir_4_5m_lconv, dir_6m_lconv, dir_10m_lconv);
        tempT_T2 = table(CDT_time, bar_fence, T_0_2m_init, T_1_5m_init, T_4_5m_init, T_8_5m_init, T_15m_init, T_20m_init, bar_fence, T_0_2m_rel, T_1_5m_rel, T_4_5m_rel, T_8_5m_rel, T_15m_rel, T_20m_rel, bar_fence, T_0_2m_uconv, T_1_5m_uconv, T_4_5m_uconv, T_8_5m_uconv, T_15m_uconv, T_20m_uconv, bar_fence, T_0_2m_lconv, T_1_5m_lconv, T_4_5m_lconv, T_8_5m_lconv, T_15m_lconv, T_20m_lconv);
        tempT_spd2 = table(CDT_time, bar_fence, spd_0_2m_init, spd_1_5m_init, spd_3m_init, spd_4_5m_init, spd_6m_init, spd_10m_init, bar_fence, spd_0_2m_rel, spd_1_5m_rel, spd_3m_rel, spd_4_5m_rel, spd_6m_rel, spd_10m_rel, bar_fence, spd_0_2m_uconv, spd_1_5m_uconv, spd_3m_uconv, spd_4_5m_uconv, spd_6m_uconv, spd_10m_uconv, bar_fence, spd_0_2m_lconv, spd_1_5m_lconv, spd_3m_lconv, spd_4_5m_lconv, spd_6m_lconv, spd_10m_lconv);
        tempT_3D2 = table(CDT_time, bar_fence, u_1_5m_uconv, u_3m_uconv, u_4_5m_uconv, u_6m_uconv, u_10m_uconv, bar_fence, u_1_5m_lconv, u_3m_lconv, u_4_5m_lconv, u_6m_lconv, u_8_5m_lconv, u_10m_lconv, u_15m_lconv, u_20m_lconv, bar_fence, v_1_5m_uconv, v_3m_uconv, v_4_5m_uconv, v_6m_uconv, v_10m_uconv, bar_fence, v_1_5m_lconv, v_3m_lconv, v_4_5m_lconv, v_6m_lconv, v_8_5m_lconv, v_10m_lconv, v_15m_lconv, v_20m_lconv, ...
            bar_fence, w_1_5m_uconv, w_3m_uconv, w_4_5m_uconv, w_6m_uconv, w_10m_uconv, bar_fence, w_1_5m_lconv, w_3m_lconv, w_4_5m_lconv, w_6m_lconv, w_8_5m_lconv, w_10m_lconv, w_15m_lconv, w_20m_lconv, ...
            bar_fence, tc_1_5m_uconv, tc_3m_uconv, tc_4_5m_uconv, tc_6m_uconv, tc_10m_uconv, bar_fence, tc_1_5m_lconv, tc_3m_lconv, tc_4_5m_lconv, tc_6m_lconv, tc_8_5m_lconv, tc_10m_lconv, tc_15m_lconv, tc_20m_lconv, ...
            bar_fence, w_tc__1_5m_uconv, w_tc__3m_uconv, w_tc__4_5m_uconv, w_tc__6m_uconv, w_tc__10m_uconv, bar_fence, w_tc__1_5m_lconv, w_tc__3m_lconv, w_tc__4_5m_lconv, w_tc__6m_lconv, w_tc__8_5m_lconv, w_tc__10m_lconv, w_tc__15m_lconv, w_tc__20m_lconv);
        
        % Format Table Names
        table_name_dir = strcat(currDate, '_Direction.csv');
        table_name_T = strcat(currDate, '_Temperature.csv');
        table_name_spd = strcat(currDate, '_Speed.csv');
        table_name_3D = strcat(currDate, '_3DWind.csv');
        
        % Output Tables
        writetable(tempT_dir2, table_name_dir);
        writetable(tempT_T2, table_name_T);
        writetable(tempT_spd2, table_name_spd);
        writetable(tempT_3D2, table_name_3D);
    end
    
end

% End Logging
diary off;

end
