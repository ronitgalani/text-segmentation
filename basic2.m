imo = imread('Document_Mansion.jpg');
im = im2double(imo);
im = rgb2gray(im);
t = graythresh(im);
imb = im > t;
imb = ~imb;
ime = edge(imb,'canny');

norows = size(ime,1);
nocols = size(ime,2);


% for c = 1:nocols
% 	in = 0;
% 	fill = 0
% 	for r = 1:norows
% 		% outside
% 		if in == 0
% 			if fill == 0

% 			if ime(r,c) == 1
% 				in = 1
% 			end
% 		% inside
% 		else
% 			% no fill yet
% 			if fill == 0
% 				if ime(r,c) == 1
% 					continue
% 				else
% 					ime(r,c) = 1
% 					fill = 1
% 				end
		
% 			% fill
% 			else
% 				if ime(r,c) ~= 1
% 					ime(r,c) = 1
% 				else
% 					fill = 0
% 				end
% 			end
% 		end
% 	end
% end
