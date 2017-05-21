close all;
clear;
load('vaaa.mat')
%%
data1=v;
len=20;
s=33;
images=zeros(len,s);
for ind=1:len
    images(ind,:)=data1((ind-1)*s+1:ind*s,1) + i*data1((ind-1)*s+1:ind*s,2);
end
% 4-a
mnshp=myProcrustesMean(images' ,0.25,0);
plot(mnshp,'r*-');
title('Mean shape of the bottles')
saveas(gcf,'10.jpeg');
images=images';
for ind=1:len
    images(:,ind)=myProcrustesAlign(images(:,ind),mnshp,0);
end
figure;
for ind=1:len
    plot(images(:,ind),'b*');
    hold on;
end
plot(mnshp,'r','lineWidth',3);
title('Blue dots represents the data points, red curve is the mean shape')
saveas(gcf,'1.jpeg');
figure;
for indi=1:s
    points=[];
    for indj=1:len
        points=[points; images(indi,indj)];
    end
    plot(points,'o-','MarkerFaceColor',[0.5,0.5,0.5]);
    hold on;
end
title('Individual variance between the landmarks')
saveas(gcf,'2.jpeg');

cvv=zeros(size(images,1),size(images,1));
for ind=1:len
    cvv=cvv+((images(:,ind)-mnshp)*(images(:,ind)-mnshp)');
end

lv=eig(cvv);
figure;
plot(lv);
title('eigenvalues of the covariance matrix of input');
saveas(gcf,'3.jpeg');

figure
bar(1:1:s,lv)
title('bar chart - eigenvalues of the covariance matrix of input');
saveas(gcf,'4.jpeg');

variance_95=sum(lv)*(0.95);
sv=sort(lv,'descend');
curr_sum=0;
eigens=[]
for ind=1:len
    curr_sum=curr_sum+sv(ind);
    if(curr_sum<variance_95)
        eigens=[eigens; sv(ind)]
    end
end
eigensvalues_needed_95_percent_variation=size(eigens,1)

[vect,values]=eig(cvv);

figure;
plot(images(:,1),'r*-')
hold on;
in_y=images(:,1)'*vect;
for ind=27:33
    in_y(ind)=0;
end
constructed=in_y*vect';
plot(constructed','bo-')
legend('Original image','Constructed after cutting 7 dimensions')
title('PCA - dimension reduction');
saveas(gcf,'5.jpeg');


k=[-2;-1;0;1;2];
e1=sv(1);
e2=sv(2);

delta=1/(e1*1000);
figure;
for ind=1:5
    subplot(1,5,ind);
    plot(mnshp+k(ind)*delta*vect(:,s),'bo-')
    title(strcat(num2str(k(ind))))
end
saveas(gcf,'6.jpeg');

figure
for ind=1:5
    subplot(1,5,ind);
    plot(mnshp+k(ind)*delta*vect(:,s-1),'bo-')
    title(strcat(num2str(k(ind))))
end
saveas(gcf,'7.jpeg');

%new_timepass
in_y=mnshp'*vect;
k=[-2;-1;0;1;2];
e1=sv(1);
e2=sv(2);
delta=1/(e1*1000);
figure
for ind=1:5
    tmp=in_y'+k(ind)*delta*vect(:,s);
    constructed=tmp'*vect';
    subplot(1,5,ind);
    plot(constructed','r*-');
    title(strcat(num2str(k(ind))))
end
saveas(gcf,'8.jpeg');

in_y=mnshp'*vect;
k=[-2;-1;0;1;2];
e2=sv(2);
delta=1/(e1*1000);
figure
for ind=1:5
    tmp=in_y'+k(ind)*delta*vect(:,s-1);
    constructed=tmp'*vect';
    subplot(1,5,ind);
    plot(constructed','r*-');
    title(strcat(num2str(k(ind))))
end
saveas(gcf,'9.jpeg');








