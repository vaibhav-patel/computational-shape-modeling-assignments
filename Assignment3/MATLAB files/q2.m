close all;
clear all;
load('cat0.mat')
x = surface.X;
y = surface.Y;
z = surface.Z;
tri = surface.TRIV;
t = 10;
u = zeros(length(x),t);
u(:,1) = rand(length(x),1);
trisurf(tri,x,y,z);
V = [x y z];
[Alb,Lc,LB] = computeLaplaceBeltrami(V,tri);
dt = 1.0;
size(LB)
mul = inv(eye(size(LB))+dt*LB);      % + sign shows use of -L
for i = 1:t-1
   % V = [x y z];
   % [Alb,Lc,LB] = computeLaplaceBeltrami(V,tri);
    mul = inv(eye(size(LB))+dt*LB);
    x = mul*x;
    y = mul*y;
    z = mul*z;   
   % figure;
    %trisurf(tri,x,y,z);
end;
figure;
trisurf(tri,x,y,z);
