
%Problem 4-a
data1=[];
for ind=1:20
    str1=strcat('images/cars/bmw',int2str(ind),'.jpeg');
    data1=[data1; getpointsASM(imread(str1))]
end
save('ab.mat','data1');

