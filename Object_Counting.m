
close all;
clear;
clc;

% Read input image
origImg = imread("cell.jpg");
imshow(origImg);
title("Original image")

% Convert color image to grayscale image
grayImg = rgb2gray(origImg);

% Convert grayscale image to binary image 
bwImg = imbinarize(grayImg,0.03);
figure(2);
imshow(bwImg); 
title("Binary image")

% Label all the connected regions 
% and find the number of cells
[labeledImage, numberOfCircles] = bwlabel(bwImg);

% Find the size of each cell using regionprops method
cellMeas = regionprops(labeledImage);
area = max([cellMeas.Area]);   

% Find the label of the biggest cell 
maxIndex = 0;
for i = 1:numberOfCircles
    if area == cellMeas(i).Area
        maxIndex = i;
    end
end

% Find the biggest cell's linear index
firstBoundPoint = find(labeledImage==maxIndex,1,'first');

% Convert the linear index into row and column
rows = size(bwImg,1);
cols = size(bwImg,2);
[row col] = ind2sub([rows cols], firstBoundPoint);

% Find the boundary of the biggest cell
boundary = bwtraceboundary(bwImg,[row col],'N');

figure(3);
imshow(bwImg);
hold on;
plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth',3);
title("Number of pixels in the biggest cell: " + area + ", Number of cells: " + numberOfCircles)