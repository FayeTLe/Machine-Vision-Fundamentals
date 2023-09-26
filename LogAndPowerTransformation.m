close all;
clear;
clc;

% Read input image
origImg = imread("fourierspectrum.pgm");
imshow(origImg);

% Call log transformation function
logOutput = logTrans(origImg);
figure(2);imshow(logOutput);

% Call power law transformation
powOutput = powTrans(origImg);
figure(3); imshow(powOutput);

% Log transformation function
function outImg = logTrans(img)
rows = size(img,1);
cols = size(img,2);

% Conver uint8 image to double 
img = im2double(img);

% Create a new image
outImg = zeros(rows,cols);

%maxVal = max(img,[],"all");
%range = getrangefromclass(img);
%c = maxVal/log(1+range(2));
c = 10;

outImg(:,:) = c.*log(1+img(:,:));

end

% Power law transformation function
function outImg = powTrans(img)

% Convert uint8 image to double
img = im2double(img);

outImg = zeros(size(img,1),size(img,2));
%maxVal = max(img,[],"all");
%range = getrangefromclass(img);
%c = maxVal/log(1+range(2));
c= 1;
gamma = 0.3;
outImg(:,:) = c.*(img(:,:).^gamma);

end