%% Test
clear; clf
trainingAmount = 100;
middleAmount = 15;
maxIt = 10000000;
calcAllFreq = trainingAmount;
ETol = 0.005;
gName = 'sigmodea';
[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
training = [training, expected];

[W_1, W_2, diff] = multiLayeredPerceptronWithSaturation(training, middleAmount, gName, maxIt, calcAllFreq, ETol);
subplot(2,1,1)
plot(diff); shg;

%%
clf;
Out = zeros(trainingAmount,1);
for i=1:trainingAmount
    [h_1, V] = calculateLayer(W_1, transpose(training(i)), gName);
    [h_2, o] = calculateLayer(W_2, V, gName);
    Out(i) = o(2);
end
subplot(2,1,2)
plot(training(:,1),Out); hold on;
plot(training(:,1),expected,'r'); shg