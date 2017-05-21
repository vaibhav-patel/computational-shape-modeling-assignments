% Author - Aditya Tatu
% Date - Oct 2013
% Usage - pts = getpointsASM(I)
% Inputs : I - The image I will be shown on which the user may click on the
%              desired landmarks. Assumed to be grayscale or in RGB format.
% Outputs: pts - This will be a k x 2 array for k landmarks. Column 1 
%                contains image column coordinates, while column 2 stores
%                image row coordinates. Column nos. increase from left to 
%                right, while row nos increase from top to bottom.
%----------------------------------------------------------------------------
function pts = getpointsASM(I)
if size(I,3) > 1
    I = rgb2gray(I);
end
button =1;
x1 = [];
y1 = [];
while button==1
    title('Left click to enter points and Press any other key to stop');hold on;
    imshow(I);hold on;axis image;plot(x1,y1,'r*','MarkerSize',5);hold on;
    [x,y,button] = ginput(1);
    if button == 1
        x1 = [x1;x];
        y1 = [y1;y];
    end
end

pts = [x1 y1];
close all;
    
    
