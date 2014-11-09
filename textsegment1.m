%% Text Segmentation
%% Team 5 - Ronit Galani, Devesh Rai
%% Initial results

close all;
clear;
% img = 'Document_3Handprint.jpg';
% img = 'Document_Mansion.jpg';
img = 'Document_Mansion2.jpg';
% img = 'Document_Mugshot.jpg';
% img = 'Document_TomHorn.jpg';
% img = 'Document_voynich_pg-39-40.jpg';
% img = 'Document_Will.jpg';
% img = 'cursive2.jpg';

im = imread(img);

im1 = im2double(im);
im1 = rgb2gray(im1);
imwd = size(im1,1);
imht = size(im1,2);

% remove noise
im1 = medfilt2(im1,[3 3]);

% threshold image
t = graythresh(im1);
im2 = im1 > t;

% im2 = im1;

% find edges
BW = edge(im2,'canny'); 

szr = 3; szc = 3;
msk = ones(szr,szc);

% msk = fspecial('gaussian');


% Smooth edges to reduce the number of connected components
B = conv2(double(BW),double(msk)); 


figure, subplot(2,3,1), imshow(im), title('1. Original Image'),
subplot(2,3,2), imshow(im1), title('2. Converting to grayscale and applying median filter')
% subplot(2,3,3), imshow(im2), title('im2')
subplot(2,3,4), imshow(BW), title('3. Detected edges')
subplot(2,3,5), imshow(B), title('4. Smoothing')

% get connect components
L = bwlabel(B,8);
mx = max(L(:)); 

% width of box to be drawn
boxwd = 2;

maxlength = 0.85*imwd;
maxheight = 0.85*imht;

L

for ic = 1:1
	[r,c] = find(L==ic);
	minr = min(r);
	maxr = max(r);
	minc = min(c);
	maxc = max(c);

	nocolpixels1 = zeros(1, (maxc-minc+1));

	for col = minc:maxc
		for row = minr:maxr
			if (im(row, col) >= 1)
				nocolpixels1(1, (col-minc+1)) = nocolpixels1(1, (col-minc+1)) + 1;
			end
		end
	end

	avgcolpixels = mean(nocolpixels1)

	thc = 2;

	nocolpixels2 = find(nocolpixels1 < (avgcolpixels - thc))

	% for col = minc:maxc
	% 	for row = minr:maxr
	% 		if im(row, col) == 1
	% 			nocolpixels1(1,col-) = nocolpixels1(1,col) + 1;
	% 		end
	% 	end
	% end	


	% discard non-textual objects
	% if (maxc - minc) > maxlength
	% 	continue
	% end
 
	% if (maxr - minr) > maxheight
	% 	continue
	% end

	% draw boxes
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

figure, imshow(im), title(strcat('Results - ', img))
