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
w_1 = csvread('W_1_neurons_1_6.csv');
w_2 = csvread('W_2_neurons_6_3.csv');
w_3 = csvread('W_3_neurons_3_1.csv');
W{1} = w_1;
W{2} = w_2;
if(W_3!=-1)
	W{3} = W_3;
end
[W, diff] = trainNet(W, trainingAmount, 2, middleAmount,maxIt, ETol, gName, saturationControl,1, -1, 0.2, 0.5);
%[W, diff] = trainNet();
% testNet()