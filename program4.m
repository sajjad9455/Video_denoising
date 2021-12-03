clc;
clear all;

[filename, pathname] = ...
     uigetfile({'*.mp4;';'*.mpg;';'*.wmv;';'*.*'},'SELECT VIDEO FILE');
 movieFullFileName  =strcat(pathname,filename);
	videoObject = VideoReader(movieFullFileName)
	% Determine how many frames there are.
    fontSize = 12;
	numberOfFrames = videoObject.NumberOfFrames;
	vidHeight = videoObject.Height;
	vidWidth = videoObject.Width;
    
    for frame = 1 : numberOfFrames
%         figure
		% Extract the frame from the movie structure.
		thisFrame = read(videoObject, frame);
%         image(thisFrame);
      figure(1)
		imshow(thisFrame);
        imwrite(thisFrame,'InputImage.jpg');
        caption = sprintf(' Input Video Frame %4d of %d.',  frame,  numberOfFrames );
        title(caption, 'FontSize', fontSize);
		% Display it
        rgbImage=im2double(thisFrame);
% grayImage = rgb2gray(rgbImage); 
% Noised_image=imnoise(rgbImage,'gaussian');
Noised_image=imnoise(rgbImage,'salt & pepper');

figure(2)
imshow(Noised_image)
 caption = sprintf(' salt & pepper Video ');
   title(caption, 'FontSize', fontSize)
%% Gaussian noise Filter Algorithm

[rows, columns, numberOfColorBands] = size(Noised_image);
% figure
% imshow(rgbImage);
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

outim=Gaussiandenoise(redChannel, 1.0, 100);
outim1=Gaussiandenoise(greenChannel, 1.0, 100);
outim2=Gaussiandenoise(blueChannel, 1.0, 100);

rgbFixed = cat(3, outim, outim1, outim2);

figure(3)
imshow(rgbFixed);title('Filter Output Video (DVL)')
imwrite(rgbFixed,'OutputImage.jpg');

%% PSNR , MSE , SSIM , ENTROPY
img= imread('InputImage.jpg');
cover_object1= imread('OutputImage.jpg');


peak_Signal_Noise=PSNR_RGB1(double(img),double(cover_object1))
% set(handles.edit1,'string',psnr1);

ssim_value = ssim(cover_object1,img)
% set(handles.edit3,'string',ssimval);
Bit_Error_Rate = Biter(cover_object1,img)

figure(4)
	meanRedLevels(frame) = mean(ssim_value);
% 		axes(handles.axes3);
		hold off;
        plot(meanRedLevels, 'b-','LineWidth', 2);
		hold on;
		plot(meanRedLevels, 'b-','LineWidth', 2);
		grid on;
        title('SSIM Plot', 'FontSize', fontSize);
        pause(0.01)

 end