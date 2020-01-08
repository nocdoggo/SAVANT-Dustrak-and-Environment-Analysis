clear all

% Values to enter/change
snrBound = 1.05; % The acceptable SNR value to reduce backscatter in the image.
filename = 'C:\Users\wzhang77\Documents\GitHub\SAVANT-Dustrak-and-Environment-Analysis\lidar\User1_100_20181017_222554.hpl'; % Change this to the directory and path to your RHI or VAD file.
scanType = 'VAD'; % This will be either VAD or RHI
fileDate = '20181017';
if scanType == 'RHI' % Enter the restrictions for graphing features in RHI scans
    htMin = 0; % Minimum Height in meters
    htMax = 1000; % Maximum Height in meters
    distMin = -1000; % Minimum lateral distance from lidar in meters
    distMax = 1000; % Maximum lateral distance from lidar in meters
    titleName = strcat(scanType," ",fileDate,", Ht range: ",num2str(htMin),"-",num2str(htMax),"m, Dist range: ",num2str(distMin),"-",num2str(distMax),"m");
else % Enter the restrictions for VAD scans
    northMin = -750; % Minimum distance from lidar in the north/south direction.  Use negative values for distances south of the lidar. Values in meters
    northMax = 750; % Maximum distance from lidar in the north/south direction.  Use negative values for distances south of the lidar. Values in meters
    eastMin = -750; % Minimum distance from lidar in the east/west direction.  Use negative values for distances west of the lidar. Values in meters
    eastMax = 750; % Maximum distance from lidar in the east/west direction.  Use negative values for distances west of the lidar. Values in meters
    titleName = strcat(scanType," ",fileDate," ",num2str(northMin),"-",num2str(northMax),"m ",num2str(eastMin),"-",num2str(eastMax),"m");
end
titleName = strcat(titleName,", SNR: ",num2str(snrBound));



% Set up the color doppler map for the values
C = [0.5 0 1;
    0.4 0 1;
    0.3 0 1;
    0.2 0 1;
    0.1 0 1;
    0 0 1;
    0 0.2 0.8;
    0 0.3 0.6;
    0 0.4 0.4;
    0 0.6 0.2;
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
    1 0.4 0;
    1 0.3 0;
    1 0.2 0;
    1 0.1 0;
    1 0 0;
    0 0 0];

% Set up color map for backscatter values
% Set up the color map for the values
CBack = [0 0.1 0.4;
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
     0 1 0
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
     1 1 1;
     0 0 0;
];

% Open starefile
fid = fopen(filename);

% Get the number of gates
gatesStr = textscan(fid,'%s',1,'delimiter','\n','headerlines',2);
gS = strsplit(gatesStr{1}{1},':');
Gs = strtrim(gS(2));
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
M = dlmread(filename,'%s*',17,0); % Put all the scan data in one big matrix
[r,c] = size(M); % Get the column and row sizes of the big matrix.

writematrix(M,'test.hpl','Delimiter','tab')