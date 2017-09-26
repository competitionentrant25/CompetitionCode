clear all;
%image = imread('image.png');
image = imread('image.png');
imageGray = image(:,:,1);
imshow(imageGray);
[centerX,centerY] = ginput(1);

size = 70;
cropped = imageGray(centerY-size:centerY+size, centerX-size:centerX+size);
%imshow(cropped);

background = imopen(cropped, strel('disk', 20));
%imshow(background);

subtracted = imsubtract(cropped, background);
%imshow(subtracted);

adjusted = imadjust(subtracted);
imshow(adjusted);


%threshold
%level = graythresh(adjusted);
%level uses Otsu's method - minimize the intraclass variance of the black
%and white pixels so image pixels look more uniform

%T = .4;
%global threshold value --> cant see second rings
%BW = imbinarize(I,T);

%adaptive method - not global threshold constant, compares to pixels around
%the center pixel --> able to see second rings too but image is spotty
%BW = imbinarize(adjusted,'adaptive');


%adaptive threshold - sensitivity adjust capability
sensitivity = .5;
Tadapt = adaptthresh(adjusted ,sensitivity);
BW = imbinarize(adjusted, Tadapt);

imshow(BW);


%centerLines - radial average and plot;

[centerX2,centerY2] = ginput(1);
radial_average = Radial(BW, [centerX2, centerY2] , 60);
plot(radial_average, 'LineWidth', 5);

