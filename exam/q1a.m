clear;
close all;

%% A point on the axis
myproj([0 0 15] , [10 0.2])
title('Point on the positive z axis')

%% A point on the axis negative
figure
myproj([0 0 -15] , [10 0.2])
title('Point on the negative z axis')

%% A point on outside
figure
myproj([16 16 15] , [10 0.2])
title('Point outside the cone')
%% A point in the inside
figure
myproj([6 6 15] , [10 0.2])
title('Point inside the cone, not on axis')

%% A point in the inside
figure
myproj([-2 -4 -3] , [10 0.2])
title('negative point')








