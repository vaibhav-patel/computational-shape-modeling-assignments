close all;
clear all;
load('cat0.mat')
x = surface.X;
y = surface.Y;
z = surface.Z;
tri = surface.TRIV;
V = [x y z];
[Alb,Lc,LB] = computeLaplaceBeltrami(V,tri);
%LB = LB;
f = -20 + 20*rand(length(x),1);     %random init. of cuntion f
r = -2 + 2*rand(length(x),1);
g = f+r;    %random g around f
alpha = 0.01;
lambda =0.1;
computeCost(LB,g,f,lambda);
c = zeros(50,1);
figure;
trisurf(tri,x,y,z,f);
caxis([-20 20]);
for i = 1:400
    gradient = -2*(f-g) + lambda*(LB + LB')*g;
    g = g - alpha*gradient;
    c(i) =   computeCost(LB,g,f,lambda);
end;
figure;
plot(c)
xlabel('Value of the Cost function');
ylabel('Iterations of Gradient Descent');
title('Decreasing Cost Function with Gradient descent')

figure;
trisurf(tri,x,y,z,g);
caxis([-10 10]);