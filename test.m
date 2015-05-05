%% Test
clear; clf
trainingAmount = 200;
middleAmount = 13;
maxIt = 10000000;
ETol = 0.25;
saturationControl = 25;
gName = 'exponencial';
[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
training = [training, expected];

% w_1 = csvread('W_1_neurons_1_15.csv');
% w_2 = csvread('W_2_neurons_15_1.csv');
w_1 = csvread('W_1_neurons_1_15.csv');
w_2 = csvread('W_2_neurons_15_1.csv');
W{1} = w_1;
W{2} = w_2;
% trainNet(W, trainingAmount, hiddenAmount, maxIt, ETol, gName, saturationControl, hasAdaptativeEta, hasMomentum, a_etha, b_etha)
[W, dif] = trainNet(W, trainingAmount, 1,maxIt, ETol, gName, -1, 1, -1, 0.2, 0.9);

csvwrite('exp_mom_1capa_15neu_w1.csv',W{1});

csvwrite('exp_mom_1capa_15neu_w2.csv',W{2});