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

[W_1, W_2, diff] = multiLayeredPerceptron(training, middleAmount, gName, maxIt, calcAllFreq, ETol);

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