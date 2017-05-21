close all;
clear all;
load('centaur0.mat')
x = surface.X;
y = surface.Y;
z = surface.Z;
tri = surface.TRIV;
t = 30;        %t is number of steps
disp('Initial heat values:' )
u(:,1) = -10 +  20*rand(length(x),1)
%u(:,1) = rand(length(x),1);
trisurf(tri,x,y,z,u(:,1));
caxis([-10 10]);
V = [x y z];
[Alb,Lc,LB] = computeLaplaceBeltrami(V,tri);
dt = 0.5;     %dt is the small coefficient multiplied to LB 
multi = inv(eye(size(LB))+dt*LB);   % + sign shows use of -L
for i = 1:t-1
    u(:,i+1) = multi*u(:,i);
    %figure;
    %trisurf(tri,x,y,z,u(:,i));
end;
figure;
trisurf(tri,x,y,z,u(:,t));
caxis([-10 10]);

disp('final heat values:')
u(:,t)

