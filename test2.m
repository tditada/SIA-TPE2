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

W{1} = w_1;
W{2} = w_2;
if(w_3!=-1)
	W{3} = w_3;
end

% trainNet(W, trainingAmount, hiddenAmount, maxIt, ETol, gName, saturationControl, hasAdaptativeEta, hasMomentum, a_etha, b_etha)
[W, dif] = trainNet(W, trainingAmount, 2,maxIt, ETol, gName, -1, -1, -1, 0.2, 0.5);