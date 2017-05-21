function [Alb,Lc,LB]= computeLaplaceBeltrami( V,F )
% compute Laplacian Beltrami Operator

[Areaweights,Cotmatrix]=computeCotmatrix( V,F );

Ainv=diag((Areaweights).^-1);
LB=Ainv*(Cotmatrix);
Alb = Areaweights;
Lc = Cotmatrix;
end

function [Areaweights,Cotmatrix]= computeCotmatrix( V,F)
% Usage: cot = computeCotmatrix( V,F )
% Purpose: Compute cot laplacian and areaweights for laplacian
%          ct(i,j)=1/2*(cot(alpha)+cot(beta)), if (i,j)in an edge
%                 = sum (ct(i,k)) for all k,   if i=j
%                 = 0                          else
% Input: M a mesh object
% Output: Cotmatrix and Areaweights

% V = [M.X M.Y M.Z];
% F = M.TRI;

NV=size(V,1);

Edges1 = V(F(:,1),:) - V(F(:,2),:);
Edges2 = V(F(:,2),:) - V(F(:,3),:);
Edges3 = V(F(:,3),:) - V(F(:,1),:);


T1=F(:,1);
T2=F(:,2);
T3=F(:,3);

% Find edge lengths of face triangles
L1 = normv(Edges2);
L2 = normv(Edges3);
L3 = normv(Edges1);

% Edge length and angles at each vertex in each triangle
A1 = (L2.^2 + L3.^2 - L1.^2) ./ (2.*L2.*L3);
A2 = (L1.^2 + L3.^2 - L2.^2) ./ (2.*L1.*L3);
A3 = (L1.^2 + L2.^2 - L3.^2) ./ (2.*L1.*L2);
A = [A1,A2,A3];
A = acos(A);

% Cot laplacian matrix store negative of cot laplacian
I = [T1;T2;T3];
J = [T2;T3;T1];
S = 0.5*cot([A(:,3);A(:,1);A(:,2)]);
In = [I;J;I;J];
Jn = [J;I;I;J];
Sn = [-S;-S;S;S];
ct=sparse(double(In), double(Jn), double(Sn),NV,NV);
Cotmatrix = ct;

% Can be done this way also
% In = [I;J];
% Jn = [J;I];
% Sn = [S;S];
% ct = sparse(In,Jn,Sn,M.NV,M.NV);
% ct=ct-diag(sum(ct,2));
% Cotmatrix=ct;

% Compute areas using mixed scheme. (A is angle matrix)
EL=[L1,L2,L3];

% Voronoi areas
cotA = 0.5*cot(A);
vp1 = [2,3,1]; vp2 = [3,1,2];
Av = 1/4 * (EL(:,vp1).^2 .* cotA(:,vp1) + EL(:,vp2).^2 .* cotA(:,vp2));

% Triangle areas
N = cross(V(T1,:)-V(T2,:), V(T1,:) - V(T3,:));
At = normv(N);

% Use barycentric area when cot is negative
locs = find(cotA(:,1) < 0);
Av(locs,1) = At(locs)/4; Av(locs,2) = At(locs)/8; Av(locs,3) = At(locs)/8;
locs = find(cotA(:,2) < 0);
Av(locs,1) = At(locs)/8; Av(locs,2) = At(locs)/4; Av(locs,3) = At(locs)/8;
locs = find(cotA(:,3) < 0);
Av(locs,1) = At(locs)/8; Av(locs,2) = At(locs)/8; Av(locs,3) = At(locs)/4;


% Vertex areas = sum triangles near by
I = [T1;T2;T3];
J = ones(size(I));
S = [Av(:,1);Av(:,2);Av(:,3)];
Areaweights = sparse(double(I), double(J), double(S), NV,1);
% % Normalize areas to sum to 1
% M.Areaweights = Areaweights / sum(Areaweights);

end

function norm  = normv( v )
norm = sqrt(sum(v.^2,2));
end

