%% Brushfire algorithm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Input : 2D matrix - map representation            %
%  Output: 2D matrix - map with repulsive potentials %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [value_map]=brushfire(map)
    dx = [0 1 0 -1 1 1 -1 -1];
    dy = [1 0 -1 0 -1 1 1 -1];
    %4 or 8 point connectivity
    nN = 8;
    %size of the map
    [height, width] = size(map);
    % initialize a static queue for faster performance
    queue = zeros(size(map, 1)*size(map, 2), 2); %[];
    l = 1;  % pointer to the first element of the queue
    r = 1;  % pointer to the last element of the queue
    %initialize queue;
    for i = 1:height
        for j = 1:width
            if map(i, j) == 1    % add all the borders to the queue
                queue(r, 1) = i;
                queue(r, 2) = j;
                r = r + 1;
            end;
        end;
    end;

    bmap = map; % copy of the map

    % repeat until the queue is not empty
    while l < r
        x = queue(l, 1); % get the first x coordinate
        y = queue(l, 2); % get the first y coordinate 
        % starting from x and y, try to give potentials to its neighbours
        for i = 1:nN
            % if it's not out of boundaries, not a wall and has no
            % potential yet
            if x+dx(i) > 0 && x+dx(i) <= height && y+dy(i) > 0 && y+dy(i) <= width && bmap(x+dx(i), y+dy(i)) == 0
                bmap(x+dx(i), y+dy(i)) = bmap(x, y) + 1; % set potential
                queue(r, 1) = x+dx(i); % add to the queue
                queue(r, 2) = y+dy(i); % add to the queue
                r = r + 1;             % set the pointer to the last element of the queue
            end;
        end;
        l = l + 1;      % get the next element from the queue
    end;
    value_map = bmap;   % return the matrix of potentials
end