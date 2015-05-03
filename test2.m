%% Test
clear; clf
trainingAmount = 200;
middleAmount{1} = 6;
middleAmount{2} = 3;
maxIt = 10000000;
ETol = 0.25;
saturationControl = 25;
gName = 'tangente';
[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
training = [training, expected];

%function [W, diff] = trainNet(trainingAmount, hiddenAmount, middleAmount, maxIt, Etol, gName, saturationControl)
%[W, diff] = multiLayeredPerceptron2(training, middleAmount, gName, maxIt, ETol);
%function [W, diff] = trainNet(trainingAmount, hiddenAmount, middleAmount, maxIt, Etol, gName, saturationControl)
[W, diff] = trainNet(trainingAmount, 2, middleAmount,maxIt, ETol, gName, saturationControl,1, -1, 0.2, 0.5);
%[W, diff] = trainNet();
% testNet()