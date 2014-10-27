close all;
clear;
% im = imread('Document_3Handprint.jpg');
% im = imread('Document_Mansion.jpg');
im = imread('Document_Mugshot.jpg');
% im = imread('Document_TomHorn.jpg');
% im = imread('Document_voynich_pg-39-40.jpg');
% im = imread('Document_Will.jpg');

im1 = im2double(im);
im1 = rgb2gray(im1);
imwd = size(im1,1);
imht = size(im1,2);

% Median filtering the image to remove noise
% im1 = medfilt2(im1,[3 3]);

t = graythresh(im1);

% im2 = im1 > t;
im2 = im1;

% finding edges
BW = edge(im2,'canny'); 

szr = 4; szc = 4;
msk = ones(szr,szc);
msk(1,:) = 0;
msk(:,1) = 0;
msk(end,:) = 0;
msk(:,end) = 0;

% Smoothing image to reduce the number of connected components
B = conv2(double(BW),double(msk)); 
 
% figure(1)
% subplot(1,2,1),imshow(im);title('orignal image');
% subplot(1,2,2),imshow(B);title('segmented image');

figure, subplot(2,3,1), imshow(im), title('orig'),
subplot(2,3,2), imshow(im1), title('im1')
subplot(2,3,3), imshow(im2), title('im2')
subplot(2,3,4), imshow(BW), title('BW')
subplot(2,3,5), imshow(B), title('B')


L = bwlabel(B,8);
mx = max(max(L)); 
boxwd = 2;

% maxlength = 300;
% maxheight = 300;
maxlength = 0.25*imwd;
maxheight = 0.25*imht;

for ic = 1:mx
	[r,c] = find(L==ic);
	minr = min(r);
	maxr = max(r);
	minc = min(c);
	maxc = max(c);

	if (maxc - minc) > maxlength
		continue
	end

	if (maxr - minr) > maxheight
		continue
	end

	% top
	im(minr, minc:maxc, 1) = 255;
	im(minr, minc:maxc, 2) = 0;
	im(minr, minc:maxc, 3) = 0;

	% bottom
	im(maxr, minc:maxc, 1) = 255;
	im(maxr, minc:maxc, 2) = 0;
	im(maxr, minc:maxc, 3) = 0;

	% left
	im(minr:maxr, minc, 1) = 255;
	im(minr:maxr, minc, 2) = 0;
	im(minr:maxr, minc, 3) = 0;

	% right
	im(minr:maxr, maxc, 1) = 255;
	im(minr:maxr, maxc, 2) = 0;
	im(minr:maxr, maxc, 3) = 0;
end

figure, imshow(im)


