%% testNet: testea la red con los pesos dados
function [h, V, Out, E] = forwardPropagation(W, testing, expected, gName, layers, print, iteration)
	% disp(WAmmount);
	training = [testing, expected];
	testingAmount = size(testing, 1);

	Out = zeros(testingAmount,1);
	diff = 0;
	E=0;
	for i=1:testingAmount
		% if (mod(i,testingAmount) == 0 || i == 1)
		%transpose(training(training_number,:)
		V_aux=transpose(testing(i,:));
		for j=1:layers
			if(j==layers)
				gName = 'lineal';
			end;
			[h_aux, V_aux] = calculateLayer(W{j},V_aux,gName);
			% V_aux = V_aux(2:end); %le saco el -1
			h{j} = h_aux;
			V{j} = V_aux;
		end
		E = E + 1/2*(expected(i) - V_aux(2))^2;
	    Out(i) = V_aux(2);
	    % Adding a new data point over error-history.
	    disp('expected');
	    disp(expected(i));
	    disp('V_aux');
	    disp(V_aux(2));
	    disp('E');
	    disp(E);
	    fflush(stdout);
	    % if(iteration ~= 1)
	    % 	disp('E2');
	    % 	disp(E);
	    %     diff = E;
	    % end
	end

	if(print!=-1)
		subplot(1,2,1);
		plot(diff); shg;
		subplot(1,2,2);
		plot(training(:,1)',Out); hold on;
		plot(training(:,1)',expected,'r*'); shg
	end
end