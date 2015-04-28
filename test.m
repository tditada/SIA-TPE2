%% Test
clear;
inputAmount = 3;
middleAmount = 10;
maxIt = 100000;
caclAllFreq = 100;
ETol = 0.005;
learningFunction = 'parity';
gName = 'sigmodea';
[training, expected] = generateTraining(learningFunction, inputAmount);
training = [training, expected];

[W_1, W_2, diff] = multiLayeredPerceptron(training, middleAmount, gName, maxIt, caclAllFreq, ETol);

plot(diff); shg;