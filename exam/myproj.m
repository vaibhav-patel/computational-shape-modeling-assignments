function result = myproj(p , u_and_v)
% Usage: result = myproj(p , u_and_v)
% Purpose: It find the minimum distance point from the given point P. The
% cordinates are just the input. Even if it is not given we can
% randomly start the algorithm and reach to the minima.
% Input: P a point and u,v
% Output: A surface plot on we can see the local cordinates reaching to
% minima
x1 = p(1);
x2 = p(2);
x3 = p(3);
plot3(x1,x2,x3,'*r');
hold on;
u0 = u_and_v(1);
v0 = u_and_v(2);
plot3(u0*cos(u0),u0*sin(u0),u0,'dr');
hold on;
a = 0.001;
iters = 200;
u = u0;
v = v0;
f1 = @(x,y) x*cos(y);
f2 = @(x,y) x*sin(y);
f3 = @(x,y) x;
fsurf(f1,f2,f3,[0.01 12 0 2*pi])
hold on;
for i = 1:iters
    u = u - a*(2*(2*u - x1*cos(v) -x2*sin(v) -x3));
    v = v - a*(2*u*x1*sin(v) - 2*u*x2*cos(v));
    if(i>30)
        plot3(u*cos(v),u*sin(v),u,'-O','lineWidth',3);
        hold on;            
    end;
end;
