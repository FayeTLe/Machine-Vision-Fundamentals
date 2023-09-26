close all;
clear;
clc;

% Read input image 
origImg = imread("banker.jpeg");
imshow(origImg);

figure(2);histogram(origImg,'Normalization','probability');
equalImg = hisEqu(origImg);

figure(3); imshow(uint8(equalImg),[]);
figure(4); histogram(equalImg,'Normalization','probability');

% Histogram Equalization function
function outImg = hisEqu(img)
rows = size(img,1);
cols = size(img,2);

% Create a new image
outImg = zeros(rows,cols);
range = getrangefromclass(img);
maxRange = range(2);

% Create a matrix to hold the pixel values and their propability
origData = zeros(maxRange+1,3);

% Create an array to hold the new pixel values 
newValues = zeros(maxRange+1,1);

% List all the possible pixel values in the first column
for i = 1:maxRange
    origData(i+1,1) = origData(i,1) + 1;
end 

% Calculate the possibilities
for i = 1:rows
    for j = 1:cols
        origData(img(i,j)+1,2) = origData(img(i,j)+1,2) + 1;
    end
end

totalPix = rows.*cols;
origData(:,3) = origData(:,2)/totalPix;

newValues(:,1) = origData(:,3);

% Calculate new pixel values
for i = 1:maxRange
    newValues(i+1,1) = newValues(i+1,1) + newValues(i,1);
end

newValues(:,1) = round(maxRange.*newValues(:,1));

% Put the new values in the new image
for i = 1:rows
    for j = 1:cols
        outImg(i,j) = newValues(img(i,j)+1,1);
    end
end

end
