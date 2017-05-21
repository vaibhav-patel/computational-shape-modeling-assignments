function ret = mymeshdeform(V, tri , Fixed_points , Movable_points)
x = V(:,1);
y = V(:,2);
z = V(:,3);
trisurf(tri,x,y,z);
ks = 0.05; 
kb = 50;  
[Alb,Lc,Lb] = computeLaplaceBeltrami(V,tri);
V = V + hardConstrainSolve(ks*Lb + kb*Lb*Lb, zeros(size(Lb,1),3), Fixed_points, Movable_points);
trisurf(tri,V(:,1),V(:,2),V(:,3));
title(strcat('ks == ', num2str(ks), 'kb==' , num2str(kb) ))
