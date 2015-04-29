%% Test
clear; clf
trainingAmount = 100;
middleAmount = 30;
maxIt = 50000;
calcAllFreq = 100;
ETol = 0.005;
gName = 'sigmodea';
[training, expected] = generateTrainingTPfunction(trainingAmount,0);
training = [training, expected];

[W_1, W_2, diff, w_v] = multiLayeredPerceptron(training, middleAmount, gName, maxIt, calcAllFreq, ETol);
subplot(2,2,1);
plot(diff(10:end)); shg;
subplot(2,2,3);
semilogy(w_v(10:end))

%
Out = zeros(trainingAmount,1);
for i=1:trainingAmount
    [h_1, V] = calculateLayer(W_1, transpose(training(i)), gName);
    [h_2, o] = calculateLayer(W_2, V, 'lineal');
    Out(i) = o(2);
end
subplot(2,2,2);
plot(training(:,1),Out); hold on;
plot(training(:,1),expected,'r*'); shg