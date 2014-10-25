imo = imread('Document_Mansion.jpg');
im = im2double(imo);
im = rgb2gray(im);
t = graythresh(im);
imb = im > t;
imb = ~imb;
ime = edge(imb,'canny');

sumr = sum(imb');
thresh = 20;
t1 = find(sumr <= thresh);
sumr(t1) = 0;
sumr = logical(sumr);
diffr = diff(sumr);
findr = find(diffr ~= 0);

sizer = size(findr,2);
sizer2 = floor(size(findr,2)/2);
outr = zeros(1,sizer2);

boxwd = 2;

% figure,
for j = 1:2:sizer
	k = ceil(j/2);
	% outr(1,k) = imb(findr(j):findr(j+1), :);
	
	%imt = imb(findr(j):findr(j+1), :);
	%subplot(sizer2,1,k), imshow(imt);

	%top
	imo(findr(j)-boxwd:findr(j), :, 1) = 255;
	imo(findr(j)-boxwd:findr(j), :, 2) = 0;
	imo(findr(j)-boxwd:findr(j), :, 3) = 0;

	%bottom
	imo(findr(j+1):(findr(j+1)+boxwd), :, 1) = 255;
	imo(findr(j+1):(findr(j+1)+boxwd), :, 2) = 0;
	imo(findr(j+1):(findr(j+1)+boxwd), :, 3) = 0;

	%left
	imo((findr(j)-boxwd):(findr(j+1)+boxwd), 1:boxwd, 1) = 255;
	imo((findr(j)-boxwd):(findr(j+1)+boxwd), 1:boxwd, 2) = 0;
	imo((findr(j)-boxwd):(findr(j+1)+boxwd), 1:boxwd, 3) = 0;

	%right
	imo((findr(j)-boxwd):(findr(j+1)+boxwd), (end-boxwd):end, 1) = 255;
	imo((findr(j)-boxwd):(findr(j+1)+boxwd), (end-boxwd):end, 2) = 0;
	imo((findr(j)-boxwd):(findr(j+1)+boxwd), (end-boxwd):end, 3) = 0;

end

figure, imshow(imo)

