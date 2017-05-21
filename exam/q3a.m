clear;
close all;
load('dMDS.mat');
Dx2=Dx.*Dx;
n=size(Dx2,1);
Z=zeros(size(Dx2,1),size(Dx2,2));
for i1=1:n
    for j1=1:n
        Z(i1,j1)=(0.5)*(Dx2(i1,1)+Dx2(j1,1) - Dx2(i1,j1)  );
    end
end
ZZT=Z*Z';
eZ=eig(ZZT);
epsilon=0.001;
if(eZ< -epsilon)
    'danger'
end
% Value of M
M=0;
for i1=1:n
    if(eZ(i1)>epsilon)
        M=M+1;
    end
end

% Now, we are changing the value of M to 2
V=-1*ones(n,n);
for i1=1:n
    V(i1,i1)=n-1;
end
V_pinv=pinv(V);
%
epsilon=1e-10;
err_epsilon=0.001;
Z=rand(n,2);

iter=50;
plot(Z(:,1),Z(:,2),'.')
title('Initial configuration')

errs=zeros(iter,1);

DZ=zeros(n,n);
for i1=1:n
    for j1=1:n
        DZ(i1,j1)=   (sum(((Z(i1,:)-Z(j1,:)).^2)))^(0.5);
    end
end

B=Find_B(Dx,DZ,epsilon,n);
errs(1)= sum(sum((Dx-DZ).^2));    
stopped=1;
for i1=2:iter
    Zn=(1.0/n)*B*Z;
    Z=Zn;        
    DZ=zeros(n,n);
    for i2=1:n
        for j2=1:n
            DZ(i2,j2)=   (sum(((Z(i2,:)-Z(j2,:)).^2)))^(0.5);
        end
    end   
    B=Find_B(Dx,DZ,epsilon,n);
    i1
    sum(sum((Dx-DZ).^2))
    errs(i1)= sum(sum((Dx-DZ).^2)); 
    %if(errs(i1)-errs(i1-1) < err_epsilon )
    %    stopped=i1;
    %    break
    %end
    stopped=i1
end
figure
plot(1:stopped,errs(1:stopped))
figure
plot(Z(:,1),Z(:,2),'.')
title('Final configuration')

