%% Test
clear; clf
trainingAmount = 200;
middleAmount = 15;
maxIt = 10000000;
calcAllFreq = trainingAmount;
ETol = 0.005;
gName = 'sigmodea';
[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
training = [training, expected];

<<<<<<< HEAD
[W_1, W_2, diff] = multiLayeredPerceptronWithSaturation(training, middleAmount, gName, maxIt, calcAllFreq, ETol);

%%
%subplot(1,2,1);
%plot(diff); shg;

%Out = zeros(trainingAmount,1);
%for i=1:trainingAmount
%    [h_1, V_1] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
%    [h_2, V_2] = calculateLayer(W_2, V_1, gName);
%    [h_3, o] = calculateLayer(W_3, V_2, 'lineal');
%    Out(j) = o(2);
%end
%subplot(1,2,2);
%plot(training(:,1),Out); hold on;
%plot(training(:,1),expected,'r*'); shg
=======
[W_1, W_2, diff] = multiLayeredPerceptron(training, middleAmount, gName, maxIt, calcAllFreq, ETol);
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
>>>>>>> 8c75712b3bf0a11f880831e7a7029b2f545108d7
