close all;
clear all;
load('cat0.mat')
x = surface.X;
y = surface.Y;
z = surface.Z;
tri = surface.TRIV;
V = [x y z];
[Alb,Lc,LB] = computeLaplaceBeltrami(V,tri);
[A B] = computeAB(V,tri);

%LB = -LB; 
A = full(A);
%[u s v] = svd(A);
[u,s] = eig(A,full(B));
size(u)
z = u'*B'*V;       %Full projection
approx = u(:,1:17)*z(1:17,:);   %Reconstruction
trisurf(tri,approx(:,1),approx(:,2),approx(:,3));



