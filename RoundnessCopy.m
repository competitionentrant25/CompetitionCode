function [ Centroids ] = RoundnessCopy(raw,background)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    rawImg = imread(raw);
    backImg = imread(background);
    %adjusted = imsubtract(rawImg,baackImg);
    adjusted = rawImg;
    adjusted = rgb2gray(adjusted);
    adjusted = imsharpen(adjusted);
    adjusted = imadjust(adjusted);
    imshow(adjusted);
    hold on;
    adjusted = imbinarize(adjusted);
    imshow(adjusted);
    adjusted = bwareaopen(adjusted,10);
    adjusted = imfill(adjusted,'holes');
    imshow(adjusted);
    [B,L] = bwboundaries(adjusted,'holes');
    imshow(label2rgb(L,@jet,[.5,.5,.5]));
    hold on;
    for i = 1:length(B)
        boundary = B{i};
        plot(boundary(:,2),boundary(:,1),'w','LineWidth',2);
    end
    stats = regionprops(L,'Area','Centroid');
    threshold = 0.8;
    Centroids = ones(0,2);
    for i = 1:length(B)
        boundary = B{i};
        delta_sq = diff(boundary).^2;
        perimeter = sum(sqrt(sum(delta_sq,2)));
        
        area = stats(i).Area;
        
        roundness = 4*pi*area/perimeter^2;
        
        roundness_string = sprintf('%2.2f',roundness);
        
        if roundness>threshold
            centroid = stats(i).Centroid;
            plot(centroid(1),centroid(2),'ko');
            %Centroids = [Centroids(1,1:length(Centroids)),centroid(1);Centroids(2,1:length(Centroids)),centroid(2)];
        
            text(boundary(1,2)-35,boundary(1,1)+13,roundness_string,'Color','black',...
            'FontSize',8,'FontWeight','bold')
        end
        
    end
title(['Metrics closer to 1 indicate that ',...
       'the object is approximately round']);

