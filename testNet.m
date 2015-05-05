%% testNet: testea la red con los pesos dados
function [Out] = testNet(W, testing, expected, gName, hiddenAmount)
	% WAmmount = hiddenAmount+1;
	inputAmount = size(testing,2);
	testingAmount = size(testing,1);
	testing = [-1*ones(size(testing,1),1) testing];
	layers=hiddenAmount+1;
	for j=1:testingAmount
		% V = transpose(testing(j,:));
		% for i=1:WAmmount
			% if(i==WAmmount)
			% 	gName = 'lineal';
			% end
			% [h, V] = calculateLayer(W{i}, V, gName);
			V_aux=transpose(testing(j,:));
			gName2=gName;
			for i=1:layers
				if(i==layers)
					gName2='lineal';
				end
				[h_aux, V_aux] = calculateLayer(W{i}, V_aux, gName2);
				h{i}=h_aux;
				V{i}=V_aux;
			end
		% end
		Out(j) = V_aux(2);
	end
	disp('out');
	disp(Out);

	clf
	figure(1);
	plot(testing(:,2)', Out); hold on;
	plot(testing(:,2)', expected, 'r*'); hold off; shg
	title('testing');
end