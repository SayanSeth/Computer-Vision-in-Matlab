% This Programme is for callibrating Single Camera
% Provide the path of images which will be used for callibrating

% Define images to process
imageFileNames = 
    {'C:\Users\sssay\Documents\MATLAB\Images\image_0001.png',...
    'C:\Users\sssay\Documents\MATLAB\Images\image_0002.png',...
    'C:\Users\sssay\Documents\MATLAB\Images\image_0003.png',...
    'C:\Users\sssay\Documents\MATLAB\Images\image_0004.png',...
    'C:\Users\sssay\Documents\MATLAB\Images\image_0005.png',...
    'C:\Users\sssay\Documents\MATLAB\Images\image_0006.png',...
    'C:\Users\sssay\Documents\MATLAB\Images\image_0007.png',...
    'C:\Users\sssay\Documents\MATLAB\Images\image_0008.png',...
    'C:\Users\sssay\Documents\MATLAB\Images\image_0009.png',...
    'C:\Users\sssay\Documents\MATLAB\Images\image_0010.png',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 21;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')
