function [ Iwarp,Imerge ] = warpImage(Iin, Iref, H)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    minXY = [20000, 20000];
    maxXY = [0,0];
    
    originImgSize = size(Iin);
    corners = [1,1; originImgSize(2),1 ; 1,originImgSize(1);originImgSize(2),originImgSize(1)];  % four corners of the image
    for y = 1:4
        vector = [corners(y,1); corners(y,2); 1];
        newVec = H * vector;
        newVec = newVec/newVec(3);    % turn z to 1
        for i = 1:2
            if newVec(i) < minXY(i)
                minXY(i) = newVec(i);
            end
            if newVec(i) > maxXY(i)
                maxXY(i) = newVec(i);
            end
        end
    end
    
    newImageXY = maxXY;
    offSet = [0,0];
    for i = 1:2
        if minXY(i) < 0
            offSet(i) = abs(minXY(i));
            newImageXY(i) = newImageXY(i) + offSet(i);
        end
    end
    
    newImageXY = round(newImageXY);
    Iwarp = zeros(newImageXY(2),newImageXY(1),3);
    invH = inv(H);
    for y = 1:newImageXY(2)
        for x = 1:newImageXY(1)
            vector = [x; y; 1];
            originV = (invH * vector);
            originV = originV / originV(3);    % turn the z to 1
            originV = round(originV);
            if originV(1) < 1 | originV(1) > originImgSize(2) |  originV(2) < 1 | originV(2) > originImgSize(1)
                Iwarp(y,x) = 0;
            else
                
                Iwarp(y,x,:) = Iin(originV(2),originV(1), :);
%                 cnt = 1;
%                 if(originV(2)>1)
%                     Iwarp(y,x,:) = Iwarp(y,x,:) + Iin(originV(2)-1,originV(1), :);
%                     cnt = cnt+1;
%                 end
%                 if(originV(2)<originImgSize(1))
%                     Iwarp(y,x,:) = Iwarp(y,x,:) + Iin(originV(2)+1,originV(1), :);
%                     cnt = cnt+1;
%                 end
%                 if(originV(1)>1)
%                     Iwarp(y,x,:) = Iwarp(y,x,:) + Iin(originV(2),originV(1)-1, :);
%                     cnt = cnt+1;
%                 end
%                 if(originV(1)<originImgSize(2))
%                     Iwarp(y,x,:) = Iwarp(y,x,:) + Iin(originV(2),originV(1)+1, :);
%                     cnt = cnt+1;
%                 end
%                 Iwarp(y,x,:) = Iwarp(y,x,:)/cnt;
%                 aValue = average(Iin, originV(1:2));
%                 for i = 1:3
%                     Iwarp(y,x,i) = aValue(i);
%                 end
            end
        end
    end
    
    Imerge = Iwarp;
    imgRefYX = size(Iref);
    for x = 1:imgRefYX(2)
        for y = 1:imgRefYX(1)
            newXY = [x,y] + round(offSet);
            Imerge(newXY(2),newXY(1),:) = Iref(y,x,:);
        end
    end
end



