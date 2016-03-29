%% Wavefront algorithm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Input : 2D matrix  - initial map                           %
%          1x2 array  - starting position                     %
%          1x2 array  - goal position                         %
%  Output: 2D matrix  - wavefront planner map                 %
%          Nx2 matrix - optimal trajectory from start to goal %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [value_map, trajectory]=wavefront(map, start, goal)
    dx = [-1 1 1 -1 0 0 -1 1];
    dy = [-1 -1 1 1 -1 1 0 0];
    %4 or 8 point connectivity
    nN = 8;
    %size of the map
    [height, width] = size(map);
    l = 1;   % pointer to the first element of the queue
    r = 2;   % pointer to the last element of the queue
    value_map = map; % init the value_map
    value_map(goal(1), goal(2)) = 2; % mark the goal point
    % declare a static queue for better performance
    queue = zeros(size(map, 1)*size(map, 2), 2); %[];
    % add the goal point to the queue. the wave starts from this position
    queue(1, 1) = goal(1);
    queue(1, 2) = goal(2);
    % repeat until the queue is not empty
    while l < r
        x = queue(l, 1); % get the first x coordinate
        y = queue(l, 2); % get the first y coordinate
        % starting from x and y propogate the wave
        for i = 1:nN
            % if it's not out of boundaries, not a wall and has not visited
            % yet
            if x+dx(i) > 0 && x+dx(i) <= height && y+dy(i) > 0 && y+dy(i) <= width && value_map(x+dx(i), y+dy(i)) == 0
                % set a value
                value_map(x+dx(i), y+dy(i)) = value_map(x, y) + 1;
                % add the coordinates to the queue
                queue(r, 1) = x+dx(i);
                queue(r, 2) = y+dy(i);
                r = r + 1;
            end;
        end;
        l = l + 1; % get the next element from the queue
    end;
    %Trajectory building.
    % begin from the start position
    x = start(1);
    y = start(2);
    % initialize an array for storing the trajectory
    trajectory = zeros(value_map(x,y)-1, 2); %[]
    steps = 1;
    trajectory(steps, 1) = x;
    trajectory(steps, 2) = y;
    % the start position is reachable
    if value_map(x, y) ~= 0
        % repeat
        while 1
            % declare directions to go
            dir_x = 0;
            dir_y = 0;
            % look at the neighbours
            for i = 1:nN
                % if it's not out of boundaries and has less value than the
                % current point
                if x+dx(i) > 0 && x+dx(i) <= height && y+dy(i) > 0 && y+dy(i) <= width && value_map(x+dx(i), y+dy(i)) > 1 && value_map(x+dx(i), y+dy(i)) < value_map(x, y)
                    % save the directions
                    dir_x = dx(i);
                    dir_y = dy(i);
                end;
            end;
            % get the coordinates of the next pixels using the obtained
            % directions
            x = x + dir_x;
            y = y + dir_y;
            % increase the step
            steps = steps + 1;
            % and add new points to the trajectory
            trajectory(steps, 1) = x;
            trajectory(steps, 2) = y;
            % stop the loop when we reach to the goal
            if x == goal(1) && y == goal(2)
                break;
            end;
        end;
    end;