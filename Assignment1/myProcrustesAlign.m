% Author - Zorro
% Date - Jan 2017
% Usage - pa = myProcrustesAlign(p,q)
% Inputs : set of landmarks p and set of landmarks q
% Outputs: pa - It will align the set of landmarks p to landmarks in
%               q. The inputs p,q and output pa should be k × 2 matrices, where k is the number of
%               landmarks
%----------------------------------------------------------------------------
function pa= myProcrustesAlign(p,q,visuals)

%translation 
trans_p = p-repmat(mean(p,1),size(p,1),1);
trans_q = q-repmat(mean(q,1),size(q,1),1);

%Scaling
scaled_p=trans_p/( sum(real(trans_p).^2) + sum(imag(trans_p).^2))^(0.5);
scaled_q=trans_q/( sum(real(trans_q).^2) + sum(imag(trans_q).^2))^(0.5);

%rotation
% We first have to find the rotation matrix R
rotated=scaled_p'*scaled_q/(scaled_p'*scaled_p);
S=(rotated'*rotated)^(0.5);
thetaV=angle(rotated);
pa=scaled_p*rotated;
if visuals==1
    figure;
    subplot(1,3,1);
    plot(scaled_p)
    title('curve 1')
    subplot(1,3,2);
    plot(scaled_q)
        title('curve 2')

    subplot(1,3,3);
    plot(pa)
    title('curve 1 aligned')
end



