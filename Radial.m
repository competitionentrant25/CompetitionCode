function radial_average = Radial(II, center, maxR)

% Radial takes radial average of the image I, around the center upto maxR)
x0 = center(1);
y0 = center(2);

for radius = 1:maxR
    
    num_pxls = 2*pi*radius;
    theta = 0:1/num_pxls:2*pi;
    
    xx = x0 + radius*cos(theta);
    yy = y0 + radius*sin(theta);
    
    sampled_radial_slice = interp2(double(II),xx,yy);
    
    radial_average(radius) = mean(sampled_radial_slice);
   
end 
