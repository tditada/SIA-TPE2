%% testNet: testea la red con los pesos dados
function [outputs] = testNet(W, testing, expected, gName, hiddenAmount)
	WAmmount = hiddenAmount+1;
	inputAmount = size(testing,2);
	testingAmount = size(testing,1);
	testing = [-1*ones(size(testing,1),1) testing];
	for j=1:testingAmount
		% V = transpose(testing(j,:));
		% for i=1:WAmmount
			% if(i==WAmmount)
			% 	gName = 'lineal';
			% end
			% [h, V] = calculateLayer(W{i}, V, gName);
			
			[h_1, V] = calculateLayer(W{1}, transpose(testing(j,:)), gName);
			[h_2, o] = calculateLayer(W{2}, V, 'lineal');
			
		% end
		Out(j) = o(2);
	end
	disp('out');
	disp(Out);
	figure(1);
	plot(testing(:,2), Out); hold on;
	plot(testing(:,2), expected, 'r*'); hold off; shg
end