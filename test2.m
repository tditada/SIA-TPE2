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


w_1 = csvread('W_1_neurons_1_6.csv');
w_2 = csvread('W_2_neurons_6_3.csv');
w_3 = csvread('W_3_neurons_3_1.csv');

%function [W, diff] = trainNet(trainingAmount, hiddenAmount, middleAmount, maxIt, Etol, gName, saturationControl)
%[W, diff] = multiLayeredPerceptron2(training, middleAmount, gName, maxIt, ETol);
%function [W, diff] = trainNet(trainingAmount, hiddenAmount, middleAmount, maxIt, Etol, gName, saturationControl, etha adaptativo)
[W, diff] = trainNet(w_1, w_2, w_3, trainingAmount, 2, middleAmount,maxIt, ETol, gName, -1, 1);
%[W, diff] = trainNet();
% testNet()