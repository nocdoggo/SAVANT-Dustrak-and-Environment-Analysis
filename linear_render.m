function linear_render(M, gateNum, rangDist)

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
    max_temp = max(M((idx + 1):(idx + gateNum)));
    min_temp = min(M((idx + 1):(idx + gateNum)));
    mid_temp = mean(M((idx + 1):(idx + gateNum)));
    
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
figure

% Start to process the matrix
for idx = 1:(gateNum + 1):ending_idx
    
    % Obtain the angle of the scan
    ang = M(idx, 3);
    
    % Obtain the degree of the scan
    degree = M(idx, 2);
    
    % Obtain the time of the starting time of each scan
    start_time = M(idx, 1);
    
    % Obtain the matrix we are working with
    intensity = M((idx + 1):(idx + gateNum), 3);
    
    % Obtain the gate range
    gate_range = M((idx + 1):(idx + gateNum), 1);
    
    % Obtain the height info
    height_range = gate_range * rangDist * sin(ang / 180);
    
    % Obtain the real hrizontal distance info
    horizontal_range_relative = gate_range * rangDist * cos(ang / 180);
    
    % Scale the horizontal distance
    horizontal_range = horizontal_range_relative * cos((270 - degree) / 180);
    
    % Scale the vertical distance
    vertical_range = horizontal_range_relative * sin((270 - degree) / 180);
    
    % Now try to figure out the color map for the intensity
    
    % Initialize the color dict
    color_dict = zeros(gateNum, 3);
    
    % Color code initialization
    
    for cidx = 1:gateNum
        
        % Check the value
        if intensity(cidx, 1) < mid_ab
            color_dict(cidx, 2) = (intensity(cidx, 1) - min_ab) / (mid_ab - min_ab);
        else
            color_dict(cidx, 3) = (intensity(cidx, 1) - mid_ab) / (max_ab - mid_ab);
        end
%         % Now start with the plot
%         plot(horizontal_range(cidx, 1), vertical_range(cidx, 1), 'd', 'MarkerEdgeColor','w',  'MarkerFaceColor',[0, color_dict(cidx, 2) , color_dict(cidx, 3)])
        scatter(horizontal_range(cidx, 1), vertical_range(cidx, 1), 20, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[0, color_dict(cidx, 2) , color_dict(cidx, 3)]);
        %cidx
        
        % Make sure everything stays on the canvas
        hold on
    end
    % Now start with the plot

end

% Done with plot
hold off
set(gca,'xdir','reverse')

end