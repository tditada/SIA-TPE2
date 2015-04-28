%% Test
clear;
trainingAmount = 100;
middleAmount = 15;
maxIt = 100000;
calcAllFreq = 25;
ETol = 0.005;
learningFunction = 'symmetry';
gName = 'sigmodea';
[training, expected] = generateTrainingTPfunction(trainingAmount);
training = [training, expected];

[W_1, W_2, diff] = multiLayeredPerceptron(training, middleAmount, gName, maxIt, calcAllFreq, ETol);
plot(diff); shg;

%%
clf;
Out = zeros(trainingAmount,1);
for i=1:trainingAmount
    [h_1, V] = calculateLayer(W_1, transpose(training(i)), gName);
    [h_2, o] = calculateLayer(W_2, V, gName);
    Out(i) = o(2);
end
plot(training(:,1),Out); hold on;
plot(training(:,1),expected,'r'); shg