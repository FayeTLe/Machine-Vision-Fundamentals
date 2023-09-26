close all;
clear;
clc;

%Read input image
origImage = imread("rose.jpg");
figure(1);
imshow(origImage);

% Call function quantization to get 7 bit gray level 
% image
image128bit = quantization(origImage, 128);
figure(2);
imshow(uint8(image128bit),[]);

% Call function quantization to get 6 bit gray level 
% image
image64bit = quantization(origImage, 64);
figure(3);
imshow(uint8(image64bit),[]);

% Call function quantization to get 5 bit gray level 
% image
image32bit = quantization(origImage, 32);
figure(4);
imshow(uint8(image32bit),[]);

% Function quantization takes an input image
% and a desired gray level range 
function outImage = quantization(inImage,dRange)

% Get the rows and columns from the input image
rows = size(inImage,1);
cols = size(inImage,2);

% Get the input image range 
% 8 bits = 256 
imgRange = getrangefromclass(inImage);

% Get the group range 
groupRange = (imgRange(2) + 1)/dRange;

% Create an array to hold the sum
% and number of members of each 
% group
inGroups = cell(1,dRange);
inGroups(:,:) = {zeros(1,2)};

% Create a matrix to hold the
% average of each group
newValues = zeros(1,dRange);

outImage = zeros(rows,cols);

% Use a loop to sort the pixels into
% different groups 
for i = 1:rows
    for j = 1:cols
        groupNum = round(inImage(i,j)/groupRange);

        if groupNum <= 0
            groupNum =+ 1;
        elseif groupNum > 128
            groupNum =- 1;
        end
    
        % Calculate the sum and number of members
        % of each group
        inGroups{1,groupNum}(1,1) =+ inImage(i,j);
        inGroups{1,groupNum}(1,2) =+ 1;
    end
end

% Calculate the average of each group
    for i = 1:dRange
    newValues(1,i) = round(inGroups{1,i}(1,1)/inGroups{1,i}(1,2));
    end

% Assign the new values to the output image
for i = 1:rows
    for j = 1:cols
        groupNum = round(inImage(i,j)/groupRange);

        if groupNum <= 0
            groupNum =+ 1;
        elseif groupNum > 128
            groupNum =- 1;
        end
        
        outImage(i,j) = newValues(1,groupNum);
    end
end
end