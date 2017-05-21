% Author - Zorro
% Date - Jan 2017
% Usage - mnshp= myProcrustesMean(p,thr)
% Inputs : input p being a k × 2n matrix for n objects represented as k
% landmarks. The x and y coordinates will be assumed to be put in alternating columns of matrix p.
% Outputs: mnshp - t outputs the mean shape as a k × 2 matrix.
%                   The mean shape should be computed using the iterative algorithm mentioned in class,
%                   wherein the iterations should stop once the norm of difference of successive mean
%                   estimates is below the threshold given as an input in the variable thr.
%----------------------------------------------------------------------------
function mnshp= myProcrustesMean(p,thr,visuals)
k=size(p,2);
ri=randi(k);
mu=p(:,ri);
err=999999;

oldmu=zeros(size(p(:,1)));
count=0;
if visuals==1
    figure;   
end
while thr<err
    running_average=zeros(size(mu));
    for i=1:k
        p(:,i)=myProcrustesAlign(p(:,i),mu,0);
        running_average=running_average+p(:,i);
    end
    mu=running_average/k;
    err=((mu-running_average)'*(mu-running_average))^(0.5);
    if visuals==1
        plot(mu,'lineWidth',1);
        hold on;
        pause(.5);
    end
    if(abs(oldmu-mu)<0.0001)
        count=count+1;
    end
    if(count>5)
        break;
    end
    oldmu=mu;
end
if(visuals==1)
    hold on;
    for i=1:k
        data=p(:,i);
        %translation 
        data = data-repmat(mean(data,1),size(data,1),1);
        %Scaling
        data=data/( sum(real(data).^2) + sum(imag(data).^2))^(0.5); 
        plot(data,'o');
        hold on;
    end
    title('connected Line is the changing mean as iteration goes');
end
mnshp=mu;




