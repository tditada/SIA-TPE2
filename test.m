%% Test
clear; clf
trainingAmount = 200;
middleAmount = 15;
maxIt = 10000000;
calcAllFreq = 200;
ETol = 0.25;
saturationControl = 25;
gName = 'exponencial';
[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
training = [training, expected];

w_1 = csvread('W_1_neurons_1_15.csv');
w_2 = csvread('W_2_neurons_15_1.csv');
W{1} = w_1;
W{2} = w_2;
% trainNet(W, trainingAmount, hiddenAmount, maxIt, ETol, gName, saturationControl, hasAdaptativeEta, hasMomentum, a_etha, b_etha)
[W, dif] = trainNet(W, trainingAmount, 1,maxIt, ETol, gName, -1, -1, -1, 0.2, 0.5);