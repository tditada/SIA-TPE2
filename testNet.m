%% testNet: testea la red con los pesos dados
function [outputs] = testNet(W, diff, testing, expected, gName, hiddenAmount)
	WAmmount = hiddenAmount+1;
	training = [testing, expected];
	trainingAmount = size(testing, 1);
	clear; clf

	subplot(1,2,1);
	plot(diff); shg;

	Out = zeros(trainingAmount,1);
	for i=1:trainingAmount
		V=transpose(training(i,:));
		for  j=1:hiddenAmount
			if(i==WAmmount)
				gName = 'lineal';
			end
			[h, V] = calculateLayer(W{i},V,gName);
		end
	    Out(i) = V(2);
	end
	subplot(1,2,2);
	plot(training(:,1),Out); hold on;
	plot(training(:,1),expected,'r*'); shg

end