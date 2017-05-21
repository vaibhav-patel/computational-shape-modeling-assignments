clear;
close all;
inp = ones(2,1);  %input vector of u,v
m = 3;
a = ones(m,1);  % coefficient vector a
u0 = inp(1);
v0 = inp(2);
n = (-3 + sqrt(9 + 8*(m-1)))/2;  %calculated n from m given in the vector a


x = u0-1:0.01:u0+1;
y = v0-1:0.01:v0+1;
[X,Y] = meshgrid(x,y);    %creating mesh for ploting.
Z = zeros(length(x),length(y));

for i = 1:length(X)
    for j = 1:length(Y)
        Z(i,j) = sum( func(m,n,x(i),y(j)).*a );     %func returns given polynomial functions value at x(i),y(j)
    end;
end;
figure;



%sigmau = [1, 0 , differ(m,n,1,1,1)];

sigmau = [1,0,differ(m,n,u0,v0,1)]
sigmav = [0,1,differ(m,n,u0,v0,2)]
normal = cross(sigmau,sigmav)
n = norm(normal);
%to plot sigmau and sigmav - bases of tangent space
U = zeros(size(Z));
V = zeros(size(Z));
W = zeros(size(Z));
U((length(x)+1)/2,(length(y)+1)/2) = sigmau(1);
V((length(x)+1)/2,(length(y)+1)/2) = sigmau(2);
W((length(x)+1)/2,(length(y)+1)/2) = sigmau(3);
 %hold on;
quiver3(X,Y,Z,U,V,W,15)
hold on;

U((length(x)+1)/2,(length(y)+1)/2) = sigmav(1);
V((length(x)+1)/2,(length(y)+1)/2) = sigmav(2);
W((length(x)+1)/2,(length(y)+1)/2) = sigmav(3);
 
 
quiver3(X,Y,Z,U,V,W,15)
hold on;

U((length(x)+1)/2,(length(y)+1)/2) = normal(1);
V((length(x)+1)/2,(length(y)+1)/2) = normal(2);
W((length(x)+1)/2,(length(y)+1)/2) = normal(3);

legend('SigmaU','SigmaV','Normal')
%lines to plot tangent bases completed
Z=Z-0.001.*Z;
h=mesh(X,Y,Z)
hold on

quiver3(X,Y,Z,U,V,W,15,'r','linewidth',1.5)
hold off

%set(h,'zdata',get(h,'xdata')*1.000000001);
title('Surface given by (u,v,f(u,v))')

F1 = zeros(2,2);  %first fundamental form

F1(1,1) = sum(sigmau.*sigmau);
F1(2,2) = sum(sigmav.*sigmav);
F1(1,2) = sum(sigmau.*sigmav);
F1(2,1) = sum(sigmav.*sigmau);
F1

dbyuu = (differ(m,n,u0+0.001,v0,1) - differ(m,n,u0+0.001,v0,1))/0.001;   %second partial derivative of f w.r.t u
dbyuv = (differ(m,n,u0,v0+0.001,1) - differ(m,n,u0,v0+0.001,1))/0.001;    %delf by delu delv
dbyvv = (differ(m,n,u0,v0+0.001,2) - differ(m,n,u0,v0+0.001,2))/0.001;   %second partial derivative of f w.r.t f   


F2 = zeros(2,2); %second fundamental form

F2(1,1) = dbyuu/n; %n is norm of normal
F2(2,2) = dbyvv/n; 
F2(1,2) = dbyuv/n;
F2(2,1) = dbyuv/n;

F2
