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

