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
Noised_image=imnoise(rgbImage,'gaussian');
Noised_image=imnoise(Noised_image,'salt & pepper',0.08);

figure(2)
imshow(Noised_image);title('gaussian + salt & pepper(8%) Video')
[M,F2]=RNLMF(Noised_image);
% p_AWMF = psnr(double(S),double(M))

% figure
figure(3)
imshow(M,[]);title('Filter Output Video (RNLM)')
imwrite(M,'OutputImage.jpg');

%% PSNR , MSE , SSIM , ENTROPY
img= imread('InputImage.jpg');
cover_object1= imread('OutputImage.jpg');


peak_Signal_Noise=PSNR_RGB1(double(img),double(cover_object1))
% set(handles.edit1,'string',psnr1);

ssim_value = ssim(cover_object1,img)
% set(handles.edit3,'string',ssimval);
Bit_Error_Rate = Biter(cover_object1,img)

grayImage = rgb2gray(thisFrame);
		meanGrayLevels(frame) = mean(grayImage(:));
		
		% Calculate the mean R, G, and B levels.
		meanRedLevels(frame) = mean(mean(thisFrame(:, :, 1)));
		meanGreenLevels(frame) = mean(mean(thisFrame(:, :, 2)));
		meanBlueLevels(frame) = mean(mean(thisFrame(:, :, 3)));
		
		% Plot the mean gray levels.
% 		axes(handles.axes3);
figure(4)
	meanRedLevels(frame) = max(peak_Signal_Noise);
% 		axes(handles.axes3);
		hold off;
        plot(meanRedLevels, 'b-','LineWidth', 2);
		hold on;
		plot(meanRedLevels, 'b-','LineWidth', 2);
		grid on;
        title('PSNR Plot', 'FontSize', fontSize);
        pause(0.01)

    end
