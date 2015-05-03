%% Test
clear; clf
trainingAmount = 200;
middleAmount_1 = 6;
middleAmount_2 = 3;
maxIt = 10000000;
calcAllFreq = 20;
ETol = 1;
gName = 'sigmodea';
[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
training = [training, expected];

[W_1, W_2, W_3, diff, out] = multiLayeredPerceptron2(training, middleAmount_1, middleAmount_2, gName, maxIt, calcAllFreq, ETol);

%%
subplot(1,2,1);
plot(diff); shg;
subplot(1,2,2);
plot(sort(training(:,1))',out); hold on;
plot(sort(training(:,1))',expected,'r*'); shg