%% testNet: given W_1 and W_2, test the net with your training.
function [outputs] = testNet(W_1, W_2, training, expected, gName)

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