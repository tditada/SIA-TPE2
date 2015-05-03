%% Test
clear; clf
trainingAmount = 200;
middleAmount_1 = 6;
middleAmount_2 = 3;
maxIt = 10000000;
calcAllFreq = 20;
ETol = 1;
calcAllFreq = trainingAmount;
ETol = 0.5;
saturationControl = 25;
gName = 'sigmodea';
[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
training = [training, expected];

[W_1, W_2, W_3, diff, out] = multiLayeredPerceptron2(training, middleAmount_1, middleAmount_2, gName, maxIt, calcAllFreq, ETol);