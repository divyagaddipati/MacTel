function P = POI(img)

if size(img,1) ~= 352 && size(img,2) ~= 352 
    img = imresize(img, [352 352]);
end

[y, x] = size(rgb2gray(img));
y = y/2; x = x/2;
imc1 = uint8(zeros(size(img)));

% Taking a patch of size 120x120 around the center of the image
imc1(y-60:y+60,x-60:x+60,:) = img(y-60:y+60,x-60:x+60,:);
imc2 = rgb2gray(imc1);
% figure, imshow(imc2)

%% Finding the horizontal line using hough transform
imc_ab_h = straightline(imc2,1); 
BW_h = edge(imc_ab_h,'canny');
[H_h,T_h,R_h] = hough(BW_h);
P_h = houghpeaks(H_h,5,'threshold',ceil(0.3*max(H_h(:))));
lines_h = houghlines(BW_h,T_h,R_h,P_h,'FillGap',8,'MinLength',9);
% figure, imshow(imc_ab_h), hold on
l = 1;
for k = 1:length(lines_h)
   if lines_h(k).theta == -90 && lines_h(k).rho < 0
       pos_h(l) = k;
       c_h(l) = lines_h(k).point1(2);
       l = l+1;
   end
end
[~, b_h] = sort(c_h);
f_h = pos_h(b_h);
xy_h = [lines_h(f_h(2)).point1; lines_h(f_h(2)).point2];
% plot(xy_h(:,1),xy_h(:,2),'LineWidth',1,'Color','green');
% plot(xy_h(1,1),xy_h(1,2),'*','Color','yellow');

%% Finding the vertical line using hough transform

% Rotate the image by 90 and finding the horizontal line
imc_ab1_v = imrotate(imc2,-90); 
imc_ab_v = straightline(imc_ab1_v,1);

BW_v = edge(imc_ab_v,'canny');
[H_v,T_v,R_v] = hough(BW_v);
P_v = houghpeaks(H_v,5,'threshold',ceil(0.3*max(H_v(:))));
lines_v = houghlines(BW_v,T_v,R_v,P_v,'FillGap',8,'MinLength',8);
l = 1;
for k = 1:length(lines_v)
   if lines_v(k).theta == -90 && lines_v(k).rho < 0
       pos_v(l) = k;
       c_v(l) = lines_v(k).point1(2);
       l = l+1;
   end
end
[~, b_v] = sort(c_v);
f_v = pos_v(b_v);
xy_v = [lines_v(f_v(2)).point1; lines_v(f_v(2)).point2];
% hold on
% plot(xy_v(:,2),xy_v(:,1),'LineWidth',1,'Color','green');
% plot(xy_v(1,2),xy_v(1,1),'*','Color','yellow');
% hold on

%% Finding intersection of the lines
% x1 = xy_h(1,1); y1 = xy_h(1,2);
% x2 = xy_v(1,2); y2 = xy_v(1,1);

P = InterX([xy_h(1,1) xy_h(2,1);xy_h(1,2) xy_h(2,2)],[xy_v(1,2) xy_v(2,2);xy_v(1,1) xy_v(2,1)]);
% plot(P(1,:),P(2,:),'r*')