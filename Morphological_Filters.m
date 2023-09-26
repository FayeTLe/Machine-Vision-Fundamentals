close all;
clear;
clc;

% Read input image
origImg = imread("fingerprint_BW.png");
imshow(origImg);

% Create a structuring element
se = strel('cube',3);

% Using opening operation
openImg = imopen(origImg,se);
figure(2); imshow(openImg);

% Using closing operation
closeImg = imclose(origImg,se);
figure(3); imshow(closeImg);

% Using median filter
medianImg = medfilt3(origImg);
figure(4); imshow(medianImg);