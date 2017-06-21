close all;
clear;
clc;

vid=videoinput('winvideo',1);


preview(vid);
pause(5);

for i = 1:50
    
    % take picture
    I = getsnapshot(vid);
    
    % Binarizing Yellow Object
    
    R = I(:,:,1); G = I(:,:,2); B = I(:,:,3);
    output = R > 130 & G > 130 & B < 50;
    
    % Morphological filtering
    
    bw = bwmorph(output,'dilate',5);
    
    % Calculate Centroid,Area,Bounding Box
    
    stats=regionprops(bw,'BoundingBox','Centroid','Area');
    
    
     n = length(stats);
     ba = zeros(1,n);
     
     % Skip the loop if no object Detected
     if n == 0
         continue
     end
     
     % comparing the areas of detected objects and filter out object of largest object
     
     for object=1:n
         ba(1,object)=stats(object).Area;
         
     end
    
         [k,m] = max(ba);
    
         bb=stats(m).BoundingBox;
         bc=stats(m).Centroid;
         
         
    % Inserting Text and Bounding Box
    
    text = ['X:',num2str(bc(1)) '  Y:' num2str(bc(2))];
    position = bc;
    box_color = 'black';
    
    I = insertText(I,position,text,'FontSize',18,'BoxColor',box_color,'BoxOpacity',1,'TextColor','white');
    imshow(I);
    hold on
    rectangle('Position',bb,'EdgeColor','Y','LineWidth',2);
    plot(bc(1),bc(2),'-r+');
    hold off;
    
    pause(.05);
end
    closepreview(vid);
    
    clc;
    clear;
    close all;
    
   
