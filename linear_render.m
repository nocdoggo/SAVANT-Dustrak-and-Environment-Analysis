function linear_render(data_dir, fid, filename, fileDate, M, scanType, snrBound, tag_digit, ang_label, gateNum, rangDist, bg_sel_1, bg_sel_2) 

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

% Obtain the total length of the data matrix being used
ending_idx = size(M, 1);    % Since we only go by the length

max_list = [];
min_list = [];
mid_list = [];

% Pre-sorting for colormap
for idx = 1:(gateNum + 1):ending_idx
    
    %     % Intialization
    %     max_temp = 0;
    %     min_temp = 0;
    
    % Obtain the max value for the intensity
    max_temp = max(M((idx + 1):(idx + gateNum), 3));
    min_temp = min(M((idx + 1):(idx + gateNum), 3));
    mid_temp = mean(M((idx + 1):(idx + gateNum), 3));
    
    % Fuck this, doesn't wanna tweek the speed unless someone wants to...
    % Let's see...
    max_list = [max_list, max_temp];
    min_list = [min_list, min_temp];
    mid_list = [mid_list, mid_temp];
    
end

% Now get the absolute max
max_ab = max(max_list);
min_ab = min(min_list);
mid_ab = mean(mid_list);

% Toggler of the plot
f = figure;
%axis('on', 'image');

% Test
bgimage = imread(bg_sel_1);
imshow(bgimage, 'XData', [-5, 945], 'YData', [-1600/5*(580/500), 900/5*(580/500)]);

ax = gca;

hold on

%         grayImage = imread('cameraman.tif');
%         [rows, columns, numberOfColorChannels] = size(grayImage);
%         origin = [13, 58];  % Assume x, y, NOT row, column
%         xdata = -origin(1) : columns - origin(1);
%         ydata = -origin(2) : columns - origin(2);
%         imshow(grayImage, 'XData', xdata, 'YData', ydata);
%         axis on;
%         hp = impixelinfo
%         grid on;

% Start with doppler
for idx = 1:(gateNum + 1):ending_idx
    
    % Obtain the angle of the scan
    ang = M(idx, 3);
    
    % Obtain the degree of the scan
    degree = M(idx, 2);
    
    % Obtain the time of the starting time of each scan
    start_time = M(idx, 1);
    
    % Obtain the matrix we are working with
    intensity = M((idx + 1):(idx + gateNum), 2);
    
    % Obtain the SNR datalog
    SNRLog = M((idx + 1):(idx + gateNum), 3);
    
    % Obtain the gate range
    gate_range = M((idx + 1):(idx + gateNum), 1);
    
    % Obtain the height info
    height_range = gate_range * rangDist * sin(ang / 180*pi);
    
    % Obtain the real hrizontal distance info
    horizontal_range_relative = gate_range * rangDist * cos(ang / 180*pi);
    
    % Scale the horizontal distance
    horizontal_range = horizontal_range_relative * cos((270 - degree) / 180*pi);
    
    % Scale the vertical distance
    vertical_range = horizontal_range_relative * sin((270 - degree) / 180*pi);
    
    % Now try to figure out the color map for the intensity
    
    % Initialize the color dict
    color_dict = zeros(gateNum, 3);
    
    % Color code initialization
    
    %vertical_range = flipud(vertical_range);
    
    for cidx = 1:gateNum
        
        if (SNRLog(cidx, 1) >= 1.05)
            
            % Initialize color code
            C_Code = [];
            % Intensity flagger
            temp_flag = intensity(cidx, 1);
            
            % Can't be fucked, use the dumbest if else
            % Actually fuck it
            temp_flag = round((intensity(cidx, 1) - (0.50/2))/5*10);
            
            if (temp_flag <= -21)
                C_Code = C(1, :);
            elseif (temp_flag >= 20)
                C_Code = C(42, :);
            else
                C_Code = C(temp_flag + 22, :);
            end
            
            
            %                    temp_flag = round((intensity(cidx, 1) * 2));
            %
            %                     % Check temp_flag condition
            %                     if (temp_flag <= 33)
            %                         C_Code = C((34 - temp_flag), :);
            %                       % I am such an idiot to set condition like this
            %                     else
            %                         C_Code = C(1, :);
            %                     end
            plot(horizontal_range(cidx, 1), (vertical_range(cidx, 1)), 'o', 'MarkerSize',15, 'MarkerEdgeColor', C_Code,  'MarkerFaceColor', C_Code);
            
            % Experimental
            if (ang == 270)
                % Add labeling
                text(horizontal_range(cidx, 1), (vertical_range(cidx, 1)), strcat(cidx));
                
            end
            
            %plot(horizontal_range(cidx, 1), -(vertical_range(cidx, 1)), 'o', 'MarkerSize',3, 'MarkerFaceColor', C_Code);
        end
        
        
        
        
        %                 % Check the value
        %                 if (intensity(cidx, 1) < mid_ab) && (intensity(cidx, 1) >= 1.05)
        %                     color_dict(cidx, 2) = (intensity(cidx, 1) - min_ab) / (mid_ab - min_ab);
        %                     plot(horizontal_range(cidx, 1), vertical_range(cidx, 1), 'o', 'MarkerSize',5, 'MarkerEdgeColor','w',  'MarkerFaceColor',[0, 1, 1])
        %                 elseif (intensity(cidx, 1) >= 1.05)
        %                     color_dict(cidx, 3) = (intensity(cidx, 1) - mid_ab) / (max_ab - mid_ab);
        %                     plot(horizontal_range(cidx, 1), vertical_range(cidx, 1), 'o', 'MarkerSize',5, 'MarkerEdgeColor','w',  'MarkerFaceColor',[0, 1, 0])
        %                 end
        %                 %         % Now start with the plot
        %                 % plot(horizontal_range(cidx, 1), vertical_range(cidx, 1), 'd', 'MarkerSize',3, 'MarkerEdgeColor','w',  'MarkerFaceColor',[0, color_dict(cidx, 2)*5 , color_dict(cidx, 3)*5])
        %                 %scatter(horizontal_range(cidx, 1), vertical_range(cidx, 1), 20, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[0, color_dict(cidx, 2) , color_dict(cidx, 3)]);
        
        
        % Make sure everything stays on the canvas
        hold on
    end
    % Now start with the plot
    
end
%set(gca,'YDir','reverse')
% Done with plot
hold off
axis on
set(ax, 'XTick', [-5 45 95 145 195 245 295 345 395 445 495 545 595 645 695 745 795 845 895 945])
set(ax, 'XTickLabel',{'0','52.1','104.2','156.3','208.4','260.5','312.6','364.7','416.8','468.9','521.1','573.2','625.3','677.4','729.5','781.6','833.7','885.8','937.9','990.0'} )
set(ax, 'YTick', [-350 -300 -250 -200 -150 -100 -50 0 50 100 150 200])
set(ax, 'YTickLabel',{'350','300','250','200','150','100','50','0','-50','-100','-150','-200'} )
set(gca,'XDir','Reverse','Ydir','Reverse')

%xticks([-5 45 95 145 195 245 295 345 395 445 495 545 595 645 695 745 795 845 895 945])
%         xticks([-945 -895 -845 -795 -745 -695 -645 -595 -545 -495 -445 -395 -345 -295 -245 -195 -145 -95 -45 5])
%         xticklabels({'0','52.1','104.2','156.3','208.4','260.5','312.6','364.7','416.8','468.9','521.1','573.2','625.3','677.4','729.5','781.6','833.7',...
%             '885.8','937.9','990.0'})
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
colormap(C)
h = colorbar();
set(h,'YTick',[0/42,5/42,10/42,15/42,20/42,25/42,30/42,35/42,40/42],'YTickLabel',{-10,-7.5,-5,-2.5,0,2.5,5,7.5,10})
title(strcat("Doppler ",scanType, " ", fileDate," ", num2str(tag_digit), " ", ang_label, " ", num2str(snrBound)))
%set(gca,'xdir','reverse')

print(gcf,strcat(scanType, "_", fileDate, "_", num2str(tag_digit), "_", ang_label, "_Doppler.png"),'-dpng','-r1200');
% set(f,'paperunits','centimeter')
% set(f,'papersize',[84.1,118.9])
% set(f,'paperposition',[0 0 84.1 118.9]);
% print(f,strcat(scanType, "_", fileDate, "_", num2str(tag_digit), "_", ang_label, "_Doppler.pdf"),'-dpdf','-opengl');
%close
%linear_render(M, gateNum, rangDist)


% Toggler of the plot
g = figure;

% Test
bgimage = imread(bg_sel_2);
imshow(bgimage, 'XData', [-5, 945], 'YData', [-1600/5*(580/500), 900/5*(580/500)]);
ax = gca;
hold on
% Start with backscatter
for idx = 1:(gateNum + 1):ending_idx
    
    % Obtain the angle of the scan
    ang = M(idx, 3);
    
    % Obtain the degree of the scan
    degree = M(idx, 2);
    
    % Obtain the time of the starting time of each scan
    start_time = M(idx, 1);
    
    % Obtain the matrix we are working with
    backsity = M((idx + 1):(idx + gateNum), 4);
    
    % Obtain the SNR datalog
    SNRLog = M((idx + 1):(idx + gateNum), 3);
    
    % Obtain the gate range
    gate_range = M((idx + 1):(idx + gateNum), 1);
    
    % Obtain the height info
    height_range = gate_range * rangDist * sin(ang / 180*pi);
    
    % Obtain the real hrizontal distance info
    horizontal_range_relative = gate_range * rangDist * cos(ang / 180*pi);
    
    % Scale the horizontal distance
    horizontal_range = horizontal_range_relative * cos((270 - degree) / 180*pi);
    
    % Scale the vertical distance
    vertical_range = horizontal_range_relative * sin((270 - degree) / 180*pi);
    
    % Now try to figure out the color map for the intensity
    
    % Initialize the color dict
    color_dict = zeros(gateNum, 3);
    
    % Color code initialization
    
    %vertical_range = flipud(vertical_range);
    
    for cidx = 1:gateNum
        
        if (SNRLog(cidx, 1) >= 1.05)
            
            % Initialize color code
            C_Code = [];
            % Intensity flagger
            temp_flag = backsity(cidx, 1);
            
            % Can't be fucked, use the dumbest if else
            % Actually fuck it
            temp_flag = round((backsity(cidx, 1)*1000000) - 0.5);
            
            if (temp_flag <= 0)
                C_Code = C_Back(1, :);
            elseif (temp_flag <= 8)
                C_Code = C_Back((1+temp_flag), :);
            elseif (temp_flag == 9)
                C_Code = C_Back(10, :);
            elseif (temp_flag >= 10) && (temp_flag < 15)
                C_Code = C_Back(11, :);
            elseif (temp_flag >= 15) && (temp_flag < 20)
                C_Code = C_Back(12, :);
            elseif (temp_flag >= 20) && (temp_flag < 25)
                C_Code = C_Back(13, :);
            elseif (temp_flag >= 25) && (temp_flag < 30)
                C_Code = C_Back(14, :);
            elseif (temp_flag >= 30) && (temp_flag < 35)
                C_Code = C_Back(15, :);
            elseif (temp_flag >= 35) && (temp_flag < 40)
                C_Code = C_Back(16, :);
            elseif (temp_flag >= 40) && (temp_flag < 45)
                C_Code = C_Back(17, :);
            elseif (temp_flag >= 45) && (temp_flag < 50)
                C_Code = C_Back(18, :);
            elseif (temp_flag >= 50) && (temp_flag < 55)
                C_Code = C_Back(19, :);
            elseif (temp_flag >= 55) && (temp_flag < 60)
                C_Code = C_Back(20, :);
            elseif (temp_flag >= 60) && (temp_flag < 65)
                C_Code = C_Back(21, :);
            elseif (temp_flag >= 65) && (temp_flag < 70)
                C_Code = C_Back(22, :);
            elseif (temp_flag >= 70) && (temp_flag < 75)
                C_Code = C_Back(23, :);
            elseif (temp_flag >= 75) && (temp_flag < 80)
                C_Code = C_Back(24, :);
            elseif (temp_flag >= 80) && (temp_flag < 100)
                C_Code = C_Back(25, :);
            elseif (temp_flag >= 100) && (temp_flag < 200)
                C_Code = C_Back(26, :);
            elseif (temp_flag >= 200) && (temp_flag < 300)
                C_Code = C_Back(27, :);
            elseif (temp_flag >= 300) && (temp_flag < 400)
                C_Code = C_Back(28, :);
            elseif (temp_flag >= 400) && (temp_flag < 500)
                C_Code = C_Back(29, :);
            elseif (temp_flag >= 500) && (temp_flag < 600)
                C_Code = C_Back(30, :);
            elseif (temp_flag >= 600) && (temp_flag < 700)
                C_Code = C_Back(31, :);
            elseif (temp_flag >= 700) && (temp_flag < 800)
                C_Code = C_Back(32, :);
            elseif (temp_flag >= 800) && (temp_flag < 900)
                C_Code = C_Back(33, :);
            elseif (temp_flag >= 900) && (temp_flag < 1000)
                C_Code = C_Back(34, :);
            else
                C_Code = C_Back(35, :);
            end
            
            
            %                    temp_flag = round((intensity(cidx, 1) * 2));
            %
            %                     % Check temp_flag condition
            %                     if (temp_flag <= 33)
            %                         C_Code = C((34 - temp_flag), :);
            %                       % I am such an idiot to set condition like this
            %                     else
            %                         C_Code = C(1, :);
            %                     end
            plot(horizontal_range(cidx, 1), (vertical_range(cidx, 1)), 'o', 'MarkerSize',10, 'MarkerEdgeColor', C_Code,  'MarkerFaceColor', C_Code);
            %plot(horizontal_range(cidx, 1), -(vertical_range(cidx, 1)), 'o', 'MarkerSize',3, 'MarkerFaceColor', C_Code);
        end
        
        
        
        
        %                 % Check the value
        %                 if (intensity(cidx, 1) < mid_ab) && (intensity(cidx, 1) >= 1.05)
        %                     color_dict(cidx, 2) = (intensity(cidx, 1) - min_ab) / (mid_ab - min_ab);
        %                     plot(horizontal_range(cidx, 1), vertical_range(cidx, 1), 'o', 'MarkerSize',5, 'MarkerEdgeColor','w',  'MarkerFaceColor',[0, 1, 1])
        %                 elseif (intensity(cidx, 1) >= 1.05)
        %                     color_dict(cidx, 3) = (intensity(cidx, 1) - mid_ab) / (max_ab - mid_ab);
        %                     plot(horizontal_range(cidx, 1), vertical_range(cidx, 1), 'o', 'MarkerSize',5, 'MarkerEdgeColor','w',  'MarkerFaceColor',[0, 1, 0])
        %                 end
        %                 %         % Now start with the plot
        %                 % plot(horizontal_range(cidx, 1), vertical_range(cidx, 1), 'd', 'MarkerSize',3, 'MarkerEdgeColor','w',  'MarkerFaceColor',[0, color_dict(cidx, 2)*5 , color_dict(cidx, 3)*5])
        %                 %scatter(horizontal_range(cidx, 1), vertical_range(cidx, 1), 20, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[0, color_dict(cidx, 2) , color_dict(cidx, 3)]);
        
        
        % Make sure everything stays on the canvas
        hold on
    end
    % Now start with the plot
    
end
%set(gca,'YDir','reverse')
% Done with plot
hold off
axis on
set(ax, 'XTick', [-5 45 95 145 195 245 295 345 395 445 495 545 595 645 695 745 795 845 895 945])
set(ax, 'XTickLabel',{'0','52.1','104.2','156.3','208.4','260.5','312.6','364.7','416.8','468.9','521.1','573.2','625.3','677.4','729.5','781.6','833.7','885.8','937.9','990.0'} )
set(ax, 'YTick', [-350 -300 -250 -200 -150 -100 -50 0 50 100 150 200])
set(ax, 'YTickLabel',{'350','300','250','200','150','100','50','0','-50','-100','-150','-200'} )
set(gca,'XDir','Reverse','Ydir','Reverse')
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
colormap(C_Back)
h = colorbar();
set(h,'YTick',[1/35,3/35,5/35,7/35,10/35,12/35,14/35,16/35,18/35,20/35,22/35,24/35,25/35,27/35,29/35,31/35,34/35],'YTickLabel',{1E-6,3E-6,5E-6,7E-6,1.0E-5,2E-5,3E-5,4E-5,5E-5,6E-5,7E-5,8E-5,1E-4,3E-4,5E-4,7E-4,1E-3})
title(strcat("Backscatter ",scanType, " ", fileDate," ", num2str(tag_digit), " ", ang_label, " ", num2str(snrBound)))
%set(gca,'xdir','reverse')

print(gcf,strcat(scanType, "_", fileDate, "_", num2str(tag_digit), "_", ang_label, "_Backscater.png"),'-dpng','-r1200');
% set(g,'paperunits','centimeter')
% set(g,'papersize',[84.1,118.9])
% set(g,'paperposition',[0 0 84.1 118.9]);
% print(g,strcat(scanType, "_", fileDate, "_", num2str(tag_digit), "_", ang_label, "_Backscater.pdf"),'-dpdf','-opengl');
%close
%linear_render(M, gateNum, rangDist)

end