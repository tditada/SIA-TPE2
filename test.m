%% Test
clear; clf
trainingAmount = 200;
middleAmount = 15;
maxIt = 10000000;
calcAllFreq = 200;
ETol = 0.5;
saturationControl = 25;
gName = 'exponencial';
[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
training = [training, expected];

w_1 = csvread('W_1_neurons_1_15.csv');
w_2 = csvread('W_2_neurons_15_1.csv');

[W_1, W_2, diff] = multiLayeredPerceptronWithSaturationControl(w_1, w_2, -1, saturationControl, training, middleAmount, gName, maxIt, calcAllFreq, ETol);