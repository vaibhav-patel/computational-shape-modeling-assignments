close all;
clear all;
load('cat0.mat')
x = surface.X;
y = surface.Y;
z = surface.Z;
tri = surface.TRIV;
V = [x y z];
[Alb,Lc,LB] = computeLaplaceBeltrami(V,tri);
fx = x;
fy = y;
fz = z;
%Random init. of x,y,x around initial x,y,z
r = -3 + 3*rand(length(x),1);
x = fx+r;
r = -3 + 3*rand(length(x),1);
y = fy+r;
r = -3 + 3*rand(length(x),1);
z = fz+r;
alpha = 0.1;
lambda =0.01;
%computeCost(LB,g,f,lambda);
c = zeros(50,1);
figure;
trisurf(tri,x,y,z);
for i = 1:200
    V = [x y z];
    [Alb,Lc,LB] = computeLaplaceBeltrami(V,tri);    %Updating LBO in each iteration
   %co-ordinate updates
    gradient = -0*(fx-x) + lambda*(LB + LB')*x;
    x = x - alpha*gradient;
    gradient = -0*(fy-y) + lambda*(LB + LB')*y;
    y = y - alpha*gradient;
    gradient = -0*(fz-z) + lambda*(LB + LB')*z;
    z = z - alpha*gradient;
    if(mod(i,3)==1)
      %  figure;
      %  trisurf(tri,x,y,z);
    end;
end;

figure;
trisurf(tri,x,y,z);