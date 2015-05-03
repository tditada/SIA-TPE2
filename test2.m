%% Test
clear; clf
trainingAmount = 200;
middleAmount_1 = 6;
middleAmount_2 = 3;
maxIt = 10000000;
calcAllFreq = 20;
ETol = 0.25;
saturationControl = 25;
gName = 'exponencial';
[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
training = [training, expected];

[W_1, W_2, W_3, dif] = multiLayeredPerceptron2Momentum(saturationControl, training, middleAmount_1, middleAmount_2, gName, maxIt, calcAllFreq, ETol);