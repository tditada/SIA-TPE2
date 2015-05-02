<<<<<<< HEAD
%% testNet: testea la red con los pesos dados
function [outputs] = testNet(W_1, W_2, diff, testing, expected, gName)

	training = [testing, expected];
	trainingAmount = size(testing, 1);
	clear; clf

	subplot(1,2,1);
	plot(diff); shg;

	Out = zeros(trainingAmount,1);
	for i=1:trainingAmount
	    [h_1, V] = calculateLayer(W_1, transpose(training(i)), gName);
	    [h_2, o] = calculateLayer(W_2, V, 'lineal');
	    Out(i) = o(2);
	end
	subplot(1,2,2);
	plot(training(:,1),Out); hold on;
	plot(training(:,1),expected,'r*'); shg

end

=======
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
>>>>>>> 8c75712b3bf0a11f880831e7a7029b2f545108d7
