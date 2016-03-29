%% This script is to load maps and to call wavefront and brushfire functions.
%a simple map
map=[
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 0 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 1;
    1 0 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1;
    1 0 0 0 1 1 1 1 1 0 0 0 0 0 1 1 0 0 0 1;
    1 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 1;
    1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1;
    1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;];
%map = load('maze.mat');
%map = load('mazeBig.mat');
map = load('obstaclesBig.mat');
map = map.map;
val_out = brushfire(map);
%figure, imagesc(val_out), colormap(hot), axis equal;
tic
%[a, b] = wavefront(map, [13, 2], [3, 18]); %map
%[a, b] = wavefront(map, [45, 5], [5, 150]); %maze.mat
%[a, b] = wavefront(map, [671, 16], [18, 788]); %mazeBig
[a, b] = wavefront(map, [656, 21], [17, 784]); %obstaclesBig
toc
for i = 1 : size(b,1)
    map(b(i,1), b(i, 2)) = 2;
end;
figure, imagesc(map), colormap(gray), hold on, axis equal;
