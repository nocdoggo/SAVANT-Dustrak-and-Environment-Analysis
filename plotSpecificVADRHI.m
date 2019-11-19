clc, clear all, clear all

% Values to enter/change
snrBound = 1.05; % The acceptable SNR value to reduce backscatter in the image.
filename = 'User1_100_20181017_222554.hpl'; % Change this to the directory and path to your RHI or VAD file.
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

% Color map done

% Open starefile
fid = fopen(filename)

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
% M = dlmread(filename,'%s*',17,0); % Put all the scan data in one big matrix
% Backup, since need to slice the data
M_total = dlmread(filename,'%s*',17,0); % Put all the scan data in one big matrix

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now, we chop the data

% Initial angle for the scanning
scantilt = 0.00;
start_idx = 1;  % Cuz the indexing starts from 1

% Get the size of which
[r_total, c_total] = size(M_total);
r_rdx = 1;

for r_idx = 1:557:r_total
    r_idx
    % Check on the angel which they are working with
    if abs(M_total(r_idx, 3) - scantilt) > 0.3
        
        % Then continue
        M = M_total(start_idx:(r_idx - 1), :);
        
        start_idx = r_idx
        fprintf('Got here!');
        

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [r,c] = size(M); % Get the column and row sizes of the big matrix.

        % Set the scan and gate counters to find how many there are.
        scan = 0;
        gate = -1;
        % Go through each row of M (each scan/gate)
        for i=1:r
            % If the gate is equal to the total number of gates get the new scan information 
            if gate == gateNum-1 || gate == -1
               scan = scan + 1;
               time(scan) = M(i,1);
               azm(scan) = M(i,2);
               elev(scan) = M(i,3);
               pitch(scan) = M(i,4);
               roll(scan) = M(i,5);
               gate = 1;
           % This section puts the each scan in as a column and each row in the column is the data for each gate    
           else
               gate = M(i,1);
               ind = gate + 1;
               gateCnt(ind) = gate;
               dist(ind) = (M(i,1) + 0.5) * rangDist;
               % In the following matrices, each column contains the all the data
               % for one scan at all of the range gates and each row contains all
               % scan data for each height (range gate)
               doppler(ind,scan) = M(i,2); % gate doppler reading
               intensity(ind,scan) = M(i,3); % gate SNR
               beta(ind,scan) = M(i,4); % gate backscatter
               if scanType == 'RHI'
                   htDist(ind,scan) = dist(ind) * sind(elev(scan));
                   if htDist(ind,scan)<0
                       htDist(ind,scan) = 0;
                   end
                   latDist(ind,scan) = dist(ind) * cosd(elev(scan));
               else
                   if(azm(scan)>=0&azm(scan)<90)
                       northDist(ind,scan) = dist(ind) * sind(90-azm(scan));
                       eastDist(ind,scan) = dist(ind) * cosd(90-azm(scan));
                   elseif(azm(scan)>=90&azm(scan)<=360)
                       northDist(ind,scan) = dist(ind) * sind(450-azm(scan));
                       eastDist(ind,scan) = dist(ind) * cosd(450-azm(scan));
                   end
               end
           end  
        end

        % This data within the restricted parameters
        if scanType=='RHI'
            [idxR,idxC] = find(htDist>=htMin & htDist<=htMax & latDist>=distMin & latDist<=distMax);
            for i=1:size(idxR)
                originalX(i,1) = latDist(idxR(i),idxC(i));
                originalY(i,1) = htDist(idxR(i),idxC(i)); 
            end
        else
            [idxR,idxC] = find(northDist>=northMin & northDist<=northMax & eastDist>=eastMin & eastDist<=eastMax);
            for i=1:size(idxR)
                originalY(i,1) = northDist(idxR(i),idxC(i));
                originalX(i,1) = eastDist(idxR(i),idxC(i));
            end
        end
        originalX = sort(originalX);
        originalY = sort(originalY);
        [xR,xC] = size(originalX);
        [yR,yC] = size(originalY);
        minX = min(originalX);
        minY = min(originalY);

        % Find how many scans are in the period and how many gates are in the
        % limited heights.
        [xr,xc] = size(originalX);
        [yr,yc] = size(originalY);

        % Get total distances distances in both directions
        xDist = max(originalX) - min(originalX);
        yDist = max(originalY) - min(originalY);

        % Go through all the included y- and x-direction values
        minR = min(idxR);
        maxR = max(idxR);
        diffR = maxR-minR+1;
        minC = min(idxC);
        maxC = max(idxC);
        diffC = maxC-minC+1;
        xStep = xDist/diffC;
        yStep = yDist/diffR;
        map = NaN([diffR,diffC],'single');
        eDist = NaN([diffR,diffC],'single');
        nDist = NaN([diffR,diffC],'single');
        dopReduce = NaN([diffR,diffC],'single');
        for j=1:size(idxR)
            divNeg = -10;
            divPos = 10;
            % Get indices based on X and Y distance
            if scanType=='RHI'
                xCurDist(j) = latDist(idxR(j),idxC(j));
                yCurDist(j) = htDist(idxR(j),idxC(j));
            else
                xCurDist(j) = eastDist(idxR(j),idxC(j));
                yCurDist(j) = northDist(idxR(j),idxC(j));
            end
            curCol(j) = round((xCurDist(j)-minX)/xStep);
            if curCol(j)==0
                curCol(j) = 1;
            end
            curRow(j) = round((yCurDist(j)-minY)/yStep);
            if curRow(j)==0
                curRow(j) = 1;
            end

            % Set a new matrix, map, of the color codes for the plot based on the
            % value of the doppler
            if doppler(idxR(j),idxC(j)) > 0 && intensity(idxR(j),idxC(j))>=snrBound
                %map(idxR(j)-minR+1,idxC(j)-minC+1) = round(doppler(idxR(j),idxC(j))/divPos*15)+16;
                map(curRow(j),curCol(j)) = round(doppler(idxR(j),idxC(j))/divPos*15)+16;
                if map(curRow(j),curCol(j)) > 31
                    map(curRow(j),curCol(j)) = 31;
                end
            elseif doppler(idxR(j),idxC(j)) < 0 && intensity(idxR(j),idxC(j))>=snrBound
                map(curRow(j),curCol(j)) = round(doppler(idxR(j),idxC(j))/divNeg*15);
                if map(curRow(j),curCol(j))>15
                    map(curRow(j),curCol(j)) = 1;
                end
                map(curRow(j),curCol(j)) = 16 - map(curRow(j),curCol(j));
            elseif doppler(idxR(j),idxC(j))==0 && intensity(idxR(j),idxC(j))>=snrBound
                map(curRow(j),curCol(j)) = 16;
            else
                map(curRow(j),curCol(j)) = 32;
            end


        end

        map(isnan(map)) = 32;



        % Set the elements for the height axis to display properly
        mapHeight = originalY;
        mapUD = flipud(map);
        distLR = fliplr(mapHeight);
        disSize = size(mapHeight);
        d1 = round(disSize(1)*.1);
        l1 = disSize(1) - d1;
        d2 = round(disSize(1)*.2);
        l2 = disSize(1) - d2;
        d3 = round(disSize(1)*.3);
        l3 = disSize(1) - d3;
        d4 = round(disSize(1)*.4);
        l4 = disSize(1) - d4;
        d5 = round(disSize(1)*.5);
        l5 = disSize(1) - d5;
        d6 = round(disSize(1)*.6);
        l6 = disSize(1) - d6;
        d7 = round(disSize(1)*.7);
        l7 = disSize(1) - d7;
        d8 = round(disSize(1)*.8);
        l8 = disSize(1) - d8;
        d9 = round(disSize(1)*.9);
        l9 = disSize(1) - d9;

        figure
        % use the colormap created above
        colormap(C)
        % Create the image using image with time on the x-axis and height on
        % the y-axis
        image(originalX,originalY,mapUD)
        ax = gca;
        % Set the tick interval and labels for the y-axis
        set(ax,'YTick',[mapHeight(d1) mapHeight(d2) mapHeight(d3) mapHeight(d4) mapHeight(d5) mapHeight(d6) mapHeight(d7) mapHeight(d8) mapHeight(d9) mapHeight(disSize(1))])
        set(ax,'YTickLabel',{mapHeight(disSize(1)),mapHeight(l1),mapHeight(l2),mapHeight(l3),mapHeight(l4),mapHeight(l5),mapHeight(l6),mapHeight(l7),mapHeight(l8),mapHeight(l9),mapHeight(1)})
        % label the x-axis
        if scanType == 'RHI'
            xlabel('Distance (m)')
        else
            xlabel('East-West Distance (m)')
        end
        % label the y-axis
        if scanType == 'RHI'
            ylabel('Altitude (m)')
        else
            ylabel('North-South Distance (m)')
        end
        title(strcat("Doppler ",titleName))
        % If time wanted in the reverse order, do it here.
        %if flipTime == 1
        %    set(ax,'xdir','reverse')
        %end
        % Set the values for the colorbar.
        h = colorbar();
        set(h,'YTick',[1,8,16,24,31],'YTickLabel',{-10,-5,0,5,10})


        % Go through all the included y- and x-direction values for backscatter
        %minR = min(idxR);
        %maxR = max(idxR);
        %diffR = maxR-minR+1;
        %minC = min(idxC);
        %maxC = max(idxC);
        %diffC = maxC-minC+1;
        %xStep = xDist/diffC;
        %yStep = yDist/diffR;
        mapBack = NaN([diffR,diffC],'single');
        eDist = NaN([diffR,diffC],'single');
        nDist = NaN([diffR,diffC],'single');
        betaReduce = NaN([diffR,diffC],'single');
        for j=1:size(idxR)
            % Get indices based on X and Y distance
            %if scanType=='RHI'
            %    xCurDist(j) = latDist(idxR(j),idxC(j));
            %    yCurDist(j) = htDist(idxR(j),idxC(j));
            %else
            %    xCurDist(j) = eastDist(idxR(j),idxC(j));
            %    yCurDist(j) = northDist(idxR(j),idxC(j));
            %end
            %curCol(j) = round((xCurDist(j)-minX)/xStep);
            %if curCol(j)==0
            %    curCol(j) = 1;
            %end
            %curRow(j) = round((yCurDist(j)-minY)/yStep);
            %if curRow(j)==0
            %    curRow(j) = 1;
            %end

            % Set a new matrix, map, set color code based on the value of beta
            if beta(idxR(j),idxC(j)) >= 1E-6 && beta(idxR(j),idxC(j)) < 2E-6 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 1;
            elseif beta(idxR(j),idxC(j)) >= 2E-6 && beta(idxR(j),idxC(j)) < 3E-6 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 2;
            elseif beta(idxR(j),idxC(j)) >= 3E-6 && beta(idxR(j),idxC(j)) < 4E-6 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 3;
            elseif beta(idxR(j),idxC(j)) >= 4E-6 && beta(idxR(j),idxC(j)) < 5E-6 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 4;
            elseif beta(idxR(j),idxC(j)) >= 5E-6 && beta(idxR(j),idxC(j)) < 6E-6 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 5;
            elseif beta(idxR(j),idxC(j)) >= 6E-6 && beta(idxR(j),idxC(j)) < 7E-6 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 6;
            elseif beta(idxR(j),idxC(j)) >= 7E-6 && beta(idxR(j),idxC(j)) < 8E-6 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 7;
            elseif beta(idxR(j),idxC(j)) >= 8E-6 && beta(idxR(j),idxC(j)) < 9E-6 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 8;
            elseif beta(idxR(j),idxC(j)) >= 9E-6 && beta(idxR(j),idxC(j)) < 1E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 9;
            elseif beta(idxR(j),idxC(j)) >= 1E-5 && beta(idxR(j),idxC(j)) < 1.5E-5 && intensity(idxR(j),idxC(j))>=snrBound
                map(idxR(j),idxC(j)) = 10;
            elseif beta(idxR(j),idxC(j)) >= 1.5E-5 && beta(idxR(j),idxC(j)) < 2E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 11;
            elseif beta(idxR(j),idxC(j)) >= 2E-5 && beta(idxR(j),idxC(j)) < 2.5E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 12;
            elseif beta(idxR(j),idxC(j)) >= 2.5E-5 && beta(idxR(j),idxC(j)) < 3E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 13;
            elseif beta(idxR(j),idxC(j)) >= 3E-5 && beta(idxR(j),idxC(j)) < 3.5E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 14;
            elseif beta(idxR(j),idxC(j)) >= 3.5E-5 && beta(idxR(j),idxC(j)) < 4E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 15;
            elseif beta(idxR(j),idxC(j)) >= 4E-5 && beta(idxR(j),idxC(j)) < 4.5E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 16;
            elseif beta(idxR(j),idxC(j)) >= 4.5E-5 && beta(idxR(j),idxC(j)) < 5E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 17;
            elseif beta(idxR(j),idxC(j)) >= 5E-5 && beta(idxR(j),idxC(j)) < 5.5E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 18;
            elseif beta(idxR(j),idxC(j)) >= 5.5E-5 && beta(idxR(j),idxC(j)) < 6E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 19;
            elseif beta(idxR(j),idxC(j)) >= 6E-5 && beta(idxR(j),idxC(j)) < 6.5E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 20;
            elseif beta(idxR(j),idxC(j)) >= 6.5E-5 && beta(idxR(j),idxC(j)) < 7E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 21;
            elseif beta(idxR(j),idxC(j)) >= 7E-5 && beta(idxR(j),idxC(j)) < 7.5E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 22;
            elseif beta(idxR(j),idxC(j)) >= 7.5E-5 && beta(idxR(j),idxC(j)) < 8E-5 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 23;
            elseif beta(idxR(j),idxC(j)) >= 8E-5 && beta(idxR(j),idxC(j)) < 1E-4 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 24;
            elseif beta(idxR(j),idxC(j)) >= 1E-4 && beta(idxR(j),idxC(j)) < 2E-4 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 25;
            elseif beta(idxR(j),idxC(j)) >= 2E-4 && beta(idxR(j),idxC(j)) < 3E-4 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 26;
            elseif beta(idxR(j),idxC(j)) >= 3E-4 && beta(idxR(j),idxC(j)) < 4E-4 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 27;
            elseif beta(idxR(j),idxC(j)) >= 4E-4 && beta(idxR(j),idxC(j)) < 5E-4 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 28;
            elseif beta(idxR(j),idxC(j)) >= 5E-4 && beta(idxR(j),idxC(j)) < 6E-4 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 29;
            elseif beta(idxR(j),idxC(j)) >= 6E-4 && beta(idxR(j),idxC(j)) < 7E-4 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 30;
            elseif beta(idxR(j),idxC(j)) >= 7E-4 && beta(idxR(j),idxC(j)) < 8E-4 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 31;
            elseif beta(idxR(j),idxC(j)) >= 8E-4 && beta(idxR(j),idxC(j)) < 9E-4 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 32;
            elseif beta(idxR(j),idxC(j)) >= 9E-4 && beta(idxR(j),idxC(j)) < 1E-3 && intensity(idxR(j),idxC(j))>=snrBound
                mapBack(curRow(j),curCol(j)) = 33;    
            %else
            %    mapBack(curRow(j),curCol(j)) = 34;
            end


        end

        mapBack(isnan(mapBack)) = 35;


        figure
        % Set the elements for the height axis to display properly
        mapHeight = originalY;
        mapBackUD = flipud(mapBack);
        distLR = fliplr(mapHeight);
        disSize = size(mapHeight);
        d1 = round(disSize(1)*.1);
        l1 = disSize(1) - d1;
        d2 = round(disSize(1)*.2);
        l2 = disSize(1) - d2;
        d3 = round(disSize(1)*.3);
        l3 = disSize(1) - d3;
        d4 = round(disSize(1)*.4);
        l4 = disSize(1) - d4;
        d5 = round(disSize(1)*.5);
        l5 = disSize(1) - d5;
        d6 = round(disSize(1)*.6);
        l6 = disSize(1) - d6;
        d7 = round(disSize(1)*.7);
        l7 = disSize(1) - d7;
        d8 = round(disSize(1)*.8);
        l8 = disSize(1) - d8;
        d9 = round(disSize(1)*.9);
        l9 = disSize(1) - d9;

        % use the colormap created above
        colormap(CBack)
        % Create the image using image with time on the x-axis and height on
        % the y-axis
        image(originalX,originalY,mapBackUD)
        ax = gca;
        % Set the tick interval and labels for the y-axis
        set(ax,'YTick',[mapHeight(d1) mapHeight(d2) mapHeight(d3) mapHeight(d4) mapHeight(d5) mapHeight(d6) mapHeight(d7) mapHeight(d8) mapHeight(d9) mapHeight(disSize(1))])
        set(ax,'YTickLabel',{mapHeight(disSize(1)),mapHeight(l1),mapHeight(l2),mapHeight(l3),mapHeight(l4),mapHeight(l5),mapHeight(l6),mapHeight(l7),mapHeight(l8),mapHeight(l9),mapHeight(1)})
        % label the x-axis
        if scanType == 'RHI'
            xlabel('Distance (m)')
        else
            xlabel('East-West Distance (m)')
        end
        % label the y-axis
        if scanType == 'RHI'
            ylabel('Altitude (m)')
        else
            ylabel('North-South Distance (m)')
        end
        title(strcat("Backscatter ",titleName))
        % If time wanted in the reverse order, do it here.
        %if flipTime == 1
        %    set(ax,'xdir','reverse')
        %end
        % Set the values for the colorbar.
        h = colorbar();
        set(h,'YTick',[1,3,5,7,10,12,14,16,18,20,22,24,25,27,29,31,34],'YTickLabel',{1E-6,3E-6,5E-6,7E-6,1.0E-5,2E-5,3E-5,4E-5,5E-5,6E-5,7E-5,8E-5,1E-4,3E-4,5E-4,7E-4,1E-3})
   
    end
end