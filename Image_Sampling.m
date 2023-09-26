close all;
clear;
clc;

%Read input image
origImage = imread ("rose.jpg");
imshow(origImage);

%Call function sampling to get 512x512 image
image512 = sampling(origImage, [512 512]);
figure(2); imshow(uint8(image512),[]);

%Call function sampling to get 256x256 image
image256 = sampling(image512, [256 256]);
figure(3); imshow(uint8(image256),[]);

%Call function sampling to get 128x128 image
image128 = sampling(image256, [128 128]);
figure(4); imshow(uint8(image128),[]);

%{
Call function sampling to get 256x256 image from
128x128 image
%}
imageBig256 = sampling(image128, [256 256]);
figure(5); imshow(uint8(imageBig256),[]);

%{
Call function sampling to get 512x512image from
256x256 image
%}
imageBig512 = sampling(image256, [512 512]);
figure(6); imshow(uint8(imageBig512),[]);

% Call function sampling to get 1024x1024 image from
% 512x512 image

imageBig1024 = sampling(image512, [1024 1024]);
figure(7); imshow(uint8(imageBig1024),[]);

% function sampling takes an image and a dimension 
% vector 
function outImage = sampling(inImage, dim)

% create a new image with the desired dimension
outImage = zeros(dim(1),dim(2));

% get the rows and columns of the input image
rows = size(inImage,1);
cols = size(inImage,2);

% If down-sampling, every pixel value of the new
% image is every other value of the original image
if rows > dim(1)
    outImage(:,:) = inImage(1:2:rows, 1:2:cols);

else

   % If up-sampling, first assign the original pixel
   % values to every other pixels in every other rows 
   % and columns.
   outImage(1:2:dim(1),1:2:dim(2)) = inImage(:,:);

   % Then assign the value of the original pixels to their
   % new neighbor pixels

   outImage(:,2:2:dim(2)) = outImage(:,1:2:dim(2));

   outImage(2:2:dim(1),:) = outImage(1:2:dim(2),:);
   
   outImage(2:2:dim(1),2:2:dim(2)) = outImage(1:2:dim(1),1:2:dim(2));

end
end





