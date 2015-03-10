img1 = imread('wdc1.jpg');
img2 = imread('wdc2.jpg');
matchingPointsCnt = 10;

u = [];
v = [];
x = [];
y = [];
for i = 1:matchingPointsCnt
    imshow(img1);
    [uu,vv] = ginput(1);
    u = [u;uu];
    v = [v;vv];
    
    imshow(img2);
    [xx,yy] = ginput(1);
    x = [x;xx];
    y = [y;yy];
end


subplot(1,2,1);
imshow(img1)
hold on 
scatter(u,v,'filled','r');
subplot(1,2,2);

imshow(img2)
hold on 
scatter(x,y,'filled','r');

t1 = zeros(matchingPointsCnt,2);
t2 = zeros(matchingPointsCnt,2);

for i = 1:matchingPointsCnt
    t1(i,1) = u(i);
    t1(i,2) = v(i);
    t2(i,1) = x(i);
    t2(i,2) = y(i);
end

for i = 1:matchingPointsCnt
    img1(floor(t1(i,2)),floor(t1(i,1)),1) = 255; 
    img1(floor(t1(i,2)),floor(t1(i,1)),2) = 0;
    img1(floor(t1(i,2)),floor(t1(i,1)),3) = 0;
    
    img2(floor(t2(i,2)),floor(t2(i,1)),1) = 255; 
    img2(floor(t2(i,2)),floor(t2(i,1)),2) = 0;
    img2(floor(t2(i,2)),floor(t2(i,1)),3) = 0;
end

hMatrix = computeH(t1,t2);
[ Iwarp,Imerge ] = warpImage(img1, img2, hMatrix);
imwrite(uint8(Iwarp), 'wdc1_warped.jpg');
imwrite(uint8(Imerge), 'wdc_merged.jpg');

