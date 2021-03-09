function [binaryImage]= getBinarySpheres(locX,locY,locZ,radius,maxCubeSide)
%   Input 
%   - locX,locY,locZ,radius : x,y,z coordinates of a spheres's centers 
%   - radius: vector with the radius of each sphere 
%   - maxCubeSide        : maxCubeSideOfTheSample;
%   Output 
%   - binaryImage3D   : 3-D binary image of a rock (0 = pore, 1 = grain)
% By Juan Pablo Daza, 2021

% Shift the input pack to the right location.
minX=min(locX-radius);minY=min(locY-radius);minZ=min(locZ-radius);
locX=locX-minX;locY=locY-minY;locZ=locZ-minZ;% get rid of any offsets

% Get the scale factor.
maxX=max(locX+radius);maxY=max(locY+radius);maxZ=max(locZ+radius);
sf=maxCubeSide/max([maxX,maxY,maxZ]);

% Scale locX, locY, locZ and radius of the pack to the cube size
locX = sf*locX;locY = sf*locY;locZ = sf*locZ;
radius = sf*radius;
% Create the geometry
maxAll=max([maxX,maxY,maxZ]);
sides=ceil(maxCubeSide*[(maxX/maxAll),(maxY/maxAll),(maxZ/maxAll)]);
sx=sides(1);sy=sides(2);sz=sides(3);
binaryImage = zeros(sides);

% Loop over each sphere to compute 0s and 1s
for ix=1:sx
    for iy=1:sy
        for iz=1:sz
            for is=1:max(size(radius))
                d=sqrt((ix-locX(is))^2+(iy-locY(is))^2+(iz-locZ(is))^2);
                if (d <= radius(is))
                    binaryImage(ix,iy,iz)=1;
                end
            end
        end
    end
end
end
