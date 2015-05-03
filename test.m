%% Test
clear; clf
trainingAmount = 200;
middleAmount = 15;
maxIt = 10000000;
calcAllFreq = 200;
ETol = 0.5;
saturationControl = 25;
gName = 'sigmodea';
[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
training = [training, expected];

[W_1, W_2, diff] = multiLayeredPerceptronWithSaturationControl(saturationControl, training, middleAmount, gName, maxIt, calcAllFreq, ETol);