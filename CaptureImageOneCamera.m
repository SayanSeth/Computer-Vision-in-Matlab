% This programme capture images from one camera and save it
% in a particular location 
clc;
clear;
close all;
% cam = webcamlist;
cam = videoinput('winvideo',2);
preview(cam);

pause(10);

savepath = 'C:\Users\sssay\Documents\MATLAB\Images';  %the folder
nametemplate = 'image_%04d.png';  %name pattern
imnum = 0;        %starting image number

for i = 1 : 10    %if you want to do this 50 times
   im = getsnapshot(cam);
   
   h = msgbox('Operation Completed','Success');
   imnum = imnum + 1;
   file = sprintf(nametemplate, imnum);  %create filename
   fullname = fullfile(savepath, file);  %folder and all
   imwrite( im, fullname);  %write the image there as png
   
   pause(5);

end


closepreview(cam);
clc;
clear;
close all;
