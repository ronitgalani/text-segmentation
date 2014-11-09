%% Text Segmentation
%% Team 5 - Ronit Galani, Devesh Rai
%% Initial results

close all;
clear;

% img = 'Document_3Handprint.jpg';
% img = 'Document_Mansion.jpg';
% img = 'Document_Mansion2.jpg';
img = 'Document_Mugshot.jpg';
% img = 'Document_Mugshot2.jpg';
% img = 'Document_TomHorn.jpg';
% img = 'Document_voynich_pg-39-40.jpg';
% img = 'Document_Will.jpg';
% img = 'cursive2.jpg';
% img = 'cursive3.jpg';
% img = 'c3.jpg';


%% READ AND CONVERT TO GRAYSCALE
im = imread(img);
im_double = im2double(im);
im_gray = rgb2gray(im_double);
im_width = size(im,1);
im_height = size(im,2);


%% NOISE REMOVAL
% im_medfilt = medfilt2(im_gray,[3 3]);
im_medfilt = im_gray;
%%

%% THRESHOLDING
% th = graythresh(im_midfilt);
% im_thresh = im_midfilt > th;
im_thresh = im_gray;
%%

%% EDGE DETECTION
im_edge = edge(im_thresh,'canny'); 
% figure, imshow(im_edge), title('edges');
%%


%% HOUGH LINE DETECTION MODULE
% [H,T,R] = hough(im_edge);
% % figure, imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
% % xlabel('\theta'), ylabel('\rho');
% % axis on, axis normal, hold on;
% P  = houghpeaks(H, 500, 'Threshold', ceil(0.1*max(H(:))), 'NHoodSize', [1 1]);
% % P  = houghpeaks(H);
% x = T(P(:,2)); y = R(P(:,1));
% % plot(x,y,'s','color','white'), title('hough');

% % Find lines and plot them
% lines = houghlines(im_edge,T,R,P,'FillGap',2,'MinLength',30);
% figure, imshow(im), title('HOUGHLINES'), hold on
% max_len = 0;
% for k = 1:length(lines)
%    	xy = [lines(k).point1; lines(k).point2];
%    	xy
%    	plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','blue');

%   	% Plot beginnings and ends of lines
%    	plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    	plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

%    	im_edge(xy(1,1):xy(2,1), xy(1,2):xy(2,2)) = 0;

%    	% Determine the endpoints of the longest line segment
%    	len = norm(lines(k).point1 - lines(k).point2);
%    	if ( len > max_len)
%     	max_len = len;
%       	xy_long = xy;
%    	end
% end

% % highlight the longest line segment
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','green');
%%


%% IMAGE DILATION
se = strel('square',2);
im_dilated = imdilate(im_edge, se);
% figure, imshow(im_dilated), title('img dilation');
%%


%% IMAGE FILLING
im_filled = imfill(im_dilated, 'holes');
% figure, imshow(im_filled), title('img filling')
% im_filled = im_edge;
% im_filled = im_dilated;
%%

%% DISPLAY INTERMEDIATE STEPS
figure, 
subplot(2,3,1), imshow(im),         title('1. Original Image'),
subplot(2,3,2), imshow(im_medfilt), title('2. Median Filter')
subplot(2,3,3), imshow(im_thresh),  title('3. Thresholding')
subplot(2,3,4), imshow(im_edge),    title('4. Detected edges')
subplot(2,3,5), imshow(im_dilated), title('5. Dilated')
subplot(2,3,6), imshow(im_filled),  title('6. Filled')
%%


%% GET CONNECTED COMPONENTS
[im_components no_components] = bwlabel(im_filled);
% disp(no_components);
% figure, imshow(im_components, []), title('im_components');
%%

%% DRAW BOUNDING BOXES
% st = regionprops(im_components, 'BoundingBox');
% im_box = [st.BoundingBox];

% figure, imshow(im);
% for k = 1 : length(st)
%  	thisBB = st(k).BoundingBox;
%  	rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)], 'EdgeColor','r','LineWidth',2)
% end
%%

L = im_components;
mx = max(L(:)); 

% width of box to be drawn
box_width = 2;

component_length_thresh = 0.25 * im_width;
component_height_thresh = 0.25 * im_height;

for ic = 1:mx
	[r,c] = find(L==ic);
	minr = min(r);
	maxr = max(r);
	minc = min(c);
	maxc = max(c);

	%% COMPONENT REJECTION MODULE
	% discard non-textual objects
	% if (maxc - minc) > maxlength
	% 	continue
	% end
 
	% if (maxr - minr) > maxheight
	% 	continue
	% end
	%%

	%% ROW DIVISION
	% norowpixels1 = zeros(1, (maxr-minr+1));
	% for row = minr:maxr
	% 	for col = minc:maxc
	% 		if (im_dilated(row, col) >= 1)
	% 			norowpixels1(1, (row-minr+1)) = norowpixels1(1, (row-minr+1)) + 1;
	% 		end
	% 	end
	% end

	% avgrowpixels = mean(norowpixels1);
	% % mincolpixels = min(nocolpixels1);

	% thr = 10;

	% for rowi = 1:(size(norowpixels1,2))
	% 	if (norowpixels1(1,rowi) < (avgrowpixels - thr))
	% 		im((minr+rowi), minc:maxc, 1) = 0;
	% 		im((minr+rowi), minc:maxc, 2) = 255;
	% 		im((minr+rowi), minc:maxc, 3) = 0;
	% 	end
	% end
	%%


	%% COLUMN DIVISION
	% nocolpixels1 = zeros(1, (maxc-minc+1));

	% for col = minc:maxc
	% 	for row = minr:maxr
	% 		if (im_dilated(row, col) >= 1)
	% 			nocolpixels1(1, (col-minc+1)) = nocolpixels1(1, (col-minc+1)) + 1;
	% 		end
	% 	end
	% end

	% avgcolpixels = mean(nocolpixels1);
	% % mincolpixels = min(nocolpixels1);

	% thc = 5;

	% for coli = 1:(size(nocolpixels1,2))
	% 	if (nocolpixels1(1,coli) < (avgcolpixels - thc))
	% 		im(minr:maxr, (minc+coli), 1) = 0;
	% 		im(minr:maxr, (minc+coli), 2) = 0;
	% 		im(minr:maxr, (minc+coli), 3) = 255;
	% 	end
	% end
	%%


	%% DRAW BOXES
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
	%%
end

figure, imshow(im), title(strcat('Results - ', img))