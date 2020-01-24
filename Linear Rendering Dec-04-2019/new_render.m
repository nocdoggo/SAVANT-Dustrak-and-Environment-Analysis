clc, clear all, close all

% Grab file
data_dir = input('Please paste your full data directory here: \n', 's');

% Catch all .hpl files
hpl_group = dir(strcat(data_dir, filesep, '*.hpl'));

% Check if the directory is empty
if (isempty(hpl_group))
    fprintf('\n');
    fprintf('No hpl detected, please copy the file directory from the file explorer address bar!');
    fprintf('\n');
    return
else
    num_hpl = length(hpl_group);
    tag_digit = input('Please enter the last 6 digits of the hpl file: \n');
end

% Check the margin of difference
% diffRange = input('What would be the difference in each level angle: \n');

for idx = 1:num_hpl
    % Extract File Name
    currFile = strcat(data_dir, filesep, hpl_group(idx).name);
    currName = strcat(hpl_group(idx).name);
    currTag = str2num(currName(20:25));
    if currTag == tag_digit
        filename = currName;
    end
end

% Values to enter/change
snrBound = 1.05; % The acceptable SNR value to reduce backscatter in the image.
% filename = 'User1_100_20181018_025017.hpl'; % Change this to the directory and path to your RHI or PPI file.

% % Acquire scan type
% type_sel = input('Please enter the scan type: [1] RHI, [2] PPI \n');
% 
% if type_sel == 1
%     scanType = 'RHI';
% else
%     scanType = 'PPI'; % This will be either PPI or RHI
% end

% Hardcode it for now!
scanType = 'PPI';

% Acquire background level
bg_lv = input('Please choose your background level: [1] Clear, [2] Altered \n');

if bg_lv == 1
    bg_sel_1 = 'bgimg.png';
    bg_sel_2 = 'bgimg.png';
else
    bg_sel_1 = 'bgimg2.png';
    bg_sel_2 = 'bgimg3.png';
end

% fileDate = '20181018';
fileDate = currName(11:18);

if scanType == 'RHI' % Enter the restrictions for graphing features in RHI scans
    htMin = 0; % Minimum Height in meters
    htMax = 1000; % Maximum Height in meters
    distMin = -1000; % Minimum lateral distance from lidar in meters
    distMax = 1000; % Maximum lateral distance from lidar in meters
    titleName = strcat(scanType," ",fileDate,", Ht range: ",num2str(htMin),"-",num2str(htMax),"m, Dist range: ",num2str(distMin),"-",num2str(distMax),"m");
else % Enter the restrictions for PPI scans
    northMin = -750; % Minimum distance from lidar in the north/south direction.  Use negative values for distances south of the lidar. Values in meters
    northMax = 750; % Maximum distance from lidar in the north/south direction.  Use negative values for distances south of the lidar. Values in meters
    eastMin = -750; % Minimum distance from lidar in the east/west direction.  Use negative values for distances west of the lidar. Values in meters
    eastMax = 750; % Maximum distance from lidar in the east/west direction.  Use negative values for distances west of the lidar. Values in meters
    titleName = strcat(scanType," ",fileDate," ",num2str(northMin),"-",num2str(northMax),"m ",num2str(eastMin),"-",num2str(eastMax),"m");
end
titleName = strcat(titleName,", SNR: ",num2str(snrBound));


% Open starefile
fid = fopen(strcat(data_dir, filesep, filename));

% Get the number of gates
gatesStr = textscan(fid,'%s',1,'delimiter','\n','headerlines',2);
gS = strsplit(gatesStr{1}{1},':');
Gs = strtrim(gS(2));

% No need for str2double, since it kinda just make higher RAM utilization.
% Here the part we using are all integers.
gateNum = str2num(Gs{1});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%These range numbers were used for the first few scans using the LIDAR,
% not applicable except for those cases.                               
%if gateNum == 570
%    gateNum = 564;
%end
%if gateNum == 1200
%    gateNum = 1194;
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the length of the gates from the header information
distStr = textscan(fid,'%s',1,'delimiter','\n','headerlines',0);
length = strsplit(distStr{1}{1},':');

% get the range distance from the header information
rang = strtrim(length(2));
rangDist = str2num(rang{1});

% Read in the scan measured data
% M = dlmread(filename,'%s*',17,0); % Put all the scan data in one big matrix
% Backup, since need to slice the data
M_total = dlmread(strcat(data_dir, filesep,filename),'%s*',17,0); % Put all the scan data in one big matrix

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now, we chop the data

% Initial angle for the scanning
start_idx = 1;  % Cuz the indexing starts from 1

% Get the size of which
[r_total, c_total] = size(M_total);
r_rdx = 1;

% Build up the library
zero_lib = 0;
zero_5_lib = 0;
five_lib = 0;
flag = 0;

for r_idx = 1:557:r_total

    % Build Index
    if (M_total(r_idx, 3) > 0.3) && (M_total(r_idx, 3) < 0.75) && (flag == 0)
        zero_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 0.75) && (M_total(r_idx, 3) < 1.3) && (flag == 1)
        zero_5_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 1.3) && (M_total(r_idx, 3) < 1.75) && (flag == 2)
        one_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 1.75) && (M_total(r_idx, 3) < 2.3) && (flag == 3)
        one_5_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 2.3) && (M_total(r_idx, 3) < 2.75) && (flag == 4)
        two_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 2.75) && (M_total(r_idx, 3) < 3.3) && (flag == 5)
        two_5_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 3.3) && (M_total(r_idx, 3) < 3.75) && (flag == 6)
        three_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 3.75) && (M_total(r_idx, 3) < 4.3) && (flag == 7)
        three_5_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 4.3) && (M_total(r_idx, 3) < 4.75) && (flag == 8)
        four_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 4.75) && (M_total(r_idx, 3) < 5.3) && (flag == 9)
        four_5_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 5.3) && (M_total(r_idx, 3) < 5.75) && (flag == 10)
        five_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 5.75) && (M_total(r_idx, 3) < 6.3) && (flag == 11)
        five_5_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 6.3) && (M_total(r_idx, 3) < 6.75) && (flag == 12)
        six_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 6.75) && (M_total(r_idx, 3) < 7.3) && (flag == 13)
        six_5_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 7.3) && (M_total(r_idx, 3) < 7.75) && (flag == 14)
        seven_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 7.75) && (M_total(r_idx, 3) < 8.3) && (flag == 15)
        seven_5_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 8.3) && (M_total(r_idx, 3) < 8.75) && (flag == 16)
        eight_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 8.75) && (M_total(r_idx, 3) < 9.3) && (flag == 17)
        eight_5_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 9.3) && (M_total(r_idx, 3) < 9.75) && (flag == 18)
        nine_lib = r_idx - 1;
        flag = flag + 1;
    elseif (M_total(r_idx, 3) > 9.75) && (M_total(r_idx, 3) < 10.3) && (flag == 19)
        nine_5_lib = r_idx - 1;
        flag = flag + 1;
    end
end
        
        
% C = [0 0 0;
%     0.6 0 1;
%     0.5 0 1;
%     0.4 0 1;
%     0.3 0 1;
%     0.2 0 1;
%     0.1 0 1;
%     0 0 1;
%     0 0.2 0.8;
%     0 0.3 0.6;
%     0 0.4 0.4;
%     0 0.6 0.2;
%     0 1 0;
%     0.2 1 0.2;
%     0.4 1 0.4;
%     0.6 1 0.6;
%     0.8 1 0.8;
%     1 1 1;
%     1 1 0;
%     1 0.9 0;
%     1 0.85 0;
%     1 0.8 0;
%     1 0.75 0;
%     1 0.7 0;
%     1 0.65 0;
%     1 0.6 0;
%     1 0.55 0;
%     1 0.5 0;
%     1 0.4 0;
%     1 0.3 0;
%     1 0.2 0;
%     1 0.1 0;
%     1 0 0;
%     0 0 0];

C = [0 0 0;
    0.8 0 1;
    0.7 0 1;
    0.6 0 1;
    0.5 0 1;
    0.4 0 1;
    0.3 0 1;
    0.2 0 1;
    0.1 0 1;
    0 0 1;
    0 0.2 0.8;
    0 0.3 0.6;
    0 0.4 0.5;
    0 0.5 0.4;
    0 0.6 0.2;
    0 0.8 0;
    0 1 0;
    0.2 1 0.2;
    0.4 1 0.4;
    0.6 1 0.6;
    0.8 1 0.8;
    1 1 1;
    1 1 0;
    1 0.9 0;
    1 0.85 0;
    1 0.8 0;
    1 0.75 0;
    1 0.7 0;
    1 0.65 0;
    1 0.6 0;
    1 0.55 0;
    1 0.5 0;
    1 0.45 0;
    1 0.4 0;
    1 0.35 0;
    1 0.3 0;
    1 0.25 0;
    1 0.2 0;
    1 0.15 0;
    1 0.1 0;
    1 0 0;
    0 0 0];
        
% Set up the color map for the values
C_Back = [0 0 0;
     0 0.1 0.4;
     0 0.1 0.6;
     0 0.1 0.8;
     0 0 1;
     0 0.2 1;
     0 0.3 1;
     0 0.4 1;
     0 0.5 1;
     0 0.6 1;
     0 1 1;
     0 1 0.6;
     0 1 0.4;
     0 1 0;
     0.4 1 0;
     0.6 1 0;
     0.8 1 0;
     1 1 0;
     1 0.8 0;
     1 0.6 0;
     1 0.4 0;
     1 0.2 0;
     1 0 0;
     1 0.4 0.4;
     1 0.8 0.8;
     0.25 0.25 0.25;
     0.3 0.3 0.3;
     0.35 0.35 0.35;
     0.4 0.4 0.4;
     0.5 0.5 0.5;
     0.6 0.6 0.6;
     0.7 0.7 0.7;
     0.8 0.8 0.8;
     0.9 0.9 0.9;
     1 1 1];
    
ang_key = 22;
ang_label = "";

while ang_key > 0
    % Prompt user to enter the angle for plotting
    fprintf('Here is a list of angles you may choose from : \n');
    fprintf('[ 1] 0.00, [ 2] 0.50, [ 3] 1.00, [ 4] 1.50, [ 5] 2.00, [ 6] 2.50, [ 7] 3.00 ,[ 8] 3.50\n');
    fprintf('[ 9] 4.00, [10] 4.50, [11] 5.00, [12] 5.50, [13] 6.00, [14] 6.50, [15] 7.00 ,[16] 7.50\n');
    fprintf('[17] 8.00, [18] 8.50, [19] 9.00, [20] 9.50, [21] 10.0, \n');
    ang_key = input('And [0] Quit \n');
    
    if (ang_key > 0)
        
        if ang_key == 1
            M = M_total(1:zero_lib, :);
            ang_label = "0.0°";
        elseif ang_key == 2
            M = M_total((zero_lib +1):zero_5_lib, :);
            ang_label = "0.5°";
        elseif ang_key == 3
            M = M_total((zero_5_lib +1): one_lib, :);
            ang_label = "1.0°";
        elseif ang_key == 4
            M = M_total((one_lib +1): one_5_lib, :);
            ang_label = "1.5°";
        elseif ang_key == 5
            M = M_total((one_5_lib +1): two_lib, :);
            ang_label = "2.0°";
        elseif ang_key == 6
            M = M_total((two_lib +1): two_5_lib, :);
            ang_label = "2.5°";
        elseif ang_key == 7
            M = M_total((two_5_lib +1): three_lib, :);
            ang_label = "3.0°";
        elseif ang_key == 8
            M = M_total((three_lib +1): three_5_lib, :);
            ang_label = "3.5°";
        elseif ang_key == 9
            M = M_total((three_5_lib +1): four_lib, :);
            ang_label = "4.0°";
        elseif ang_key == 10
            M = M_total((four_lib +1): four_5_lib, :);
            ang_label = "4.5°";
        elseif ang_key == 11
            M = M_total((four_5_lib +1): five_lib, :);
            ang_label = "5.0°";
        elseif ang_key == 12
            M = M_total((five_lib +1): five_5_lib, :);
            ang_label = "5.5°";
        elseif ang_key == 13
            M = M_total((five_5_lib +1): six_lib, :);
            ang_label = "6.0°";
        elseif ang_key == 14
            M = M_total((six_lib +1): six_5_lib, :);
            ang_label = "6.5°";
        elseif ang_key == 15
            M = M_total((six_5_lib +1): seven_lib, :);
            ang_label = "7.0°";
        elseif ang_key == 16
            M = M_total((seven_lib +1): seven_5_lib, :);
            ang_label = "7.5°";
        elseif ang_key == 17
            M = M_total((seven_5_lib +1): eight_lib, :);
            ang_label = "8.0°";
        elseif ang_key == 18
            M = M_total((eight_lib +1): eight_5_lib, :);
            ang_label = "8.5°";
        elseif ang_key == 19
            M = M_total((eight_5_lib +1): nine_lib, :);
            ang_label = "9.0°";
        elseif ang_key == 20
            M = M_total((nine_lib +1): nine_5_lib, :);
            ang_label = "9.5°";
        elseif ang_key == 21
            M = M_total((nine_5_lib +1): r_total, :);
            ang_label = "10.0°";
        else
            fprintf('Not defined angle!\n');
        end
        
        % This is where the old rendering goes
        %rendering(data_dir, fid, filename, fileDate, M, scanType, snrBound, tag_digit, ang_label) 
        linear_render(data_dir, fid, filename, fileDate, M, scanType, snrBound, tag_digit, ang_label, gateNum, rangDist, bg_sel_1, bg_sel_2) 
              
        
   
    end
    
        
end