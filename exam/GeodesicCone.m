function result = GeodesicCone(P1,P2)
abscissa1 = P1(1);
abscissa2 = P2(1);
ordinate1 = P1(2);
ordinate2 = P2(2);
dt = 0.005; 
t = 0:dt:1;  
iter = 1/dt + 1;
f1 = @(x,y) x*cos(y);
f2 = @(x,y) x*sin(y);
f3 = @(x,y) x;
fsurf(f1,f2,f3,[0 6 0 2*pi])
hold on;
for i=1:iter
    x = t(i)*abscissa1 + (1-t(i))*abscissa2;
    y = t(i)*ordinate1 + (1-t(i))*ordinate2;
    u = sqrt((x*x + y*y)/2);
    v = sqrt(2)*acos(x/(u*sqrt(2)));
    plot3(u*cos(v),u*sin(v),u,'*r','lineWidth',4);
    hold on;
end;