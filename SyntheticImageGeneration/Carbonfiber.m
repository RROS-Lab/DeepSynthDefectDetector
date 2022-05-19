%% This file creates all the maps for the 8x8 cf. This file is reconfigured to take into account the actual measurements 

 

%% Creating the B+W matte

clear;clc; close all;

 

x = 1000;

y = 1000;

 

matte = zeros(x,y);

 

v = fix(y/8);

z = fix(x/6.76); % From Seed. Â± 0.4

 

% Locate rectangles

for i = 1:4

    rectLocation{i} = [1+2*v*(i-1),1+(i-1)*x/4];

end

% Hard code in the four other rectangles 

 

rectLocation{5} = [1+v,1+5*x/8];

rectLocation{6} = [1+3*v,1+7*x/8];

rectLocation{7} = [1+5*v,1+x/8];

rectLocation{8} = [1+7*v,1+3*x/8];

 

% Draw rectangles

for j = 1:length(rectLocation)

    for i = 1:z

        a = fix(rectLocation{j}(1));

        b = fix(rectLocation{j}(2));

        matte(a:v+a,i+b-1) = ones(1,v+1);

    end

end

 

matte(:,1:size(matte,2)-999) = matte(:,1:size(matte,2)-999) + matte(:,1000:end);

matte = matte(1:1000,1:1000);

%figure();imshow(matte);

 

%% Creating the horizontal bump map

 

horiz = zeros(x,y);

 

for j = 1:length(rectLocation)

    max = fix((y-z)/2);

    for i = 1:max

        a = fix(rectLocation{j}(1));

        b = fix(rectLocation{j}(2));

        horiz(a:v+a-1,i+b+z) = i/max;

        horiz(a:v+a-1,i+b+z+max) = (max-i)/max;

    end

end

 

horiz(:,1:size(horiz,2)-999) = horiz(:,1:size(horiz,2)-999) + horiz(:,1000:end);

horiz = horiz(1:1000,1:1000);

 

%figure();imshow(horiz);

 

%% Creating the vertical bump map

 

vert = zeros(x,y);

 

for j = 1:length(rectLocation)

    for i = 1:v/2

        a = fix(rectLocation{j}(1));

        b = fix(rectLocation{j}(2));

        vert(a+i,b:z+b) = i/v*2;

        vert(a+fix(v/2)+i,b:z+b) = (v/2-i)/(v/2);

    end

end

 

vert(:,1:size(vert,2)-999) = vert(:,1:size(vert,2)-999) + vert(:,1000:end);

vert = vert(1:1000,1:1000);

 

%figure();imshow(vert+horiz);

 

 

%% Creating the horizontal stitchings 

 

horizStitchings = zeros(x,y);

 

stitchingsThickness = fix(y/17); % Seed. 17 Â± 1

 

for j = 1:length(rectLocation)

    max = fix((y-z)/2);

    for i = 1:max

        a = fix(rectLocation{j}(1));

        b = fix(rectLocation{j}(2));

        horizStitchings(a:stitchingsThickness+a-1,i+b+z) = 1;

        horizStitchings(a:stitchingsThickness+a-1,i+b+z+max) = 1;

    end

end

 

horizStitchings(:,1:size(horizStitchings,2)-999) = horizStitchings(:,1:size(horizStitchings,2)-999) + horizStitchings(:,1000:end);

horizStitchings = horizStitchings(1:1000,1:1000);

%figure();imshow(horizStitchings);

 

%figure();imshow(horiz);

horizStitchingsBump = zeros(x,y);

 

for j = 1:length(rectLocation)

    max = fix((y-z)/2);

    for i = 1:max

        a = fix(rectLocation{j}(1));

        b = fix(rectLocation{j}(2));

        horizStitchingsBump(a:stitchingsThickness+a-1,i+b+z) = i/(y/2-z);

        horizStitchingsBump(a:stitchingsThickness+a-1,i+b+z+max) = (y/2-z-i)/(y/2-z);

    end

end

 

horizStitchingsBump(:,1:size(horizStitchingsBump,2)-999) = horizStitchingsBump(:,1:size(horizStitchingsBump,2)-999) + horizStitchingsBump(:,1000:end);

horizStitchingsBump = horizStitchingsBump(1:1000,1:1000);

 
%{
figure();imshow(horizStitchingsBump);
%}
 

%% Create the vertical stitchings 

 

vertStitchings = zeros(x,y);

 

j = 6;

for i = 1:v

    a = fix(rectLocation{j}(1));

    b = fix(rectLocation{j}(2));

    vertStitchings(i+a,b:stitchingsThickness+b-1) = 1;

end

 
%{
figure();imshow(vertStitchings);
%}
 

%% Create the vertical stitchings Bump Map 

 

vertStitchingsBump = zeros(x,y);

vertStitchingsBump2 = zeros(x,y);

 

j = 6;

max = fix(v/2);

for i = 1:max

    a = fix(rectLocation{j}(1));

    b = fix(rectLocation{j}(2));

    vertStitchingsBump(i+a,b:stitchingsThickness+b-1) = i/(v/2);

    vertStitchingsBump(i+a+max,b:stitchingsThickness+b-1) = (max-i)/(v/2);

end

 

max = stitchingsThickness/2;

 

for i = 1:max

    a = fix(rectLocation{j}(1));

    b = fix(rectLocation{j}(2));

    vertStitchingsBump2(a:a+v,b+i) = i/max;

    vertStitchingsBump2(a:a+v,b+i+max) = (max-i)/max;

end

 
%{
figure();imshow(vertStitchingsBump);

figure();imshow(vertStitchingsBump2);
%}
 

%% Write out images


% Create destination folder, you can change this to whatever you like
destinationFolder = 'D:/DeepSynthImageFolder/';
if ~exist(destinationFolder, 'dir')
  mkdir(destinationFolder);
end
imwrite(matte, strcat(destinationFolder,'matte.png'));

imwrite(vert+horiz, strcat(destinationFolder,'vert+horiz.png'));

imwrite(horizStitchings, strcat(destinationFolder,'horizStitchings.png'));

imwrite(horizStitchingsBump, strcat(destinationFolder,'horizStitchingsBump.png'));

imwrite(vertStitchings, strcat(destinationFolder,'vertStitchings.png'));

imwrite(vertStitchingsBump, strcat(destinationFolder,'vertStitchingsBump.png'));

imwrite(vertStitchingsBump2, strcat(destinationFolder,'vertStitchingsBump2.png'));

