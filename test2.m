%% Test
clear; clf
trainingAmount = 100;
testingAmount = 200;
middleAmount{1} = 6;
middleAmount{2} = 3;
maxIt = 10000000;
ETol = 0.15;
saturationControl = 25;
hiddenAmount = 2;
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
[W, dif] = trainNet(W, trainingAmount, hiddenAmount, maxIt, ETol, gName, -1, -1, -1, 0.2, 0.5);
filename = ['training_', gName,'_',int2str(hiddenAmount), 'capas_1neuronas', int2str(middleAmount{1}),'_2neuronas-',int2str(middleAmount{2}), '_trainingAmount', int2str(trainingAmount)];
print([filename,'.jpg']);

csvwrite('tan_2capas_6_3_w1.csv',W{1});
csvwrite('tan_2capas_6_3_w2.csv',W{2});
csvwrite('tan_2capas_6_3_w3.csv',W{3});

[tests, expected_tests] = generateTestFunction(testingAmount);

[outputs] = testNet(W, tests, expected_tests, gName, hiddenAmount);
filename_testing = ['testing_', gName,'_',int2str(hiddenAmount), 'capas_1neuronas', int2str(middleAmount{1}),'_2neuronas',int2str(middleAmount{2}),'_trainingAmount', int2str(trainingAmount)];
print([filename_testing, '.jpg']);