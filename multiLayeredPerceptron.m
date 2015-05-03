function [W, diff] = multiLayeredPerceptron(trainingSet, middleAmount, gName, maxIt, ETol, hasAdaptativeEta)

training = trainingSet(:,1:end-1);
expected = trainingSet(:,end);
inputAmount = size(training,2);
trainingAmount = size (training, 1);

% Generate random weights.
W_1 = weightGenerator(inputAmount, middleAmount);
W_2 = weightGenerator(middleAmount, 1);
W_1_best = W_1; W_2_best = W_2;

% Adding the first column of -1 to training-set.
training = [-1*ones(size(training,1),1) training];

% Start values
change_weight = 0.001;
E_best = -1;
decreaseCounter = 0;

for i = 1:maxIt
    fL = zeros(size(W_1));
    sL = zeros(size(W_2));
    E = 0;
    if (mod(i,trainingAmount) == 0 || i == 1)
        %To calculate how the error changes.
        for training_number = 1:size(training,1)
            [h_1, V] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
            [h_2, o] = calculateLayer(W_2, V, 'lineal');
            E = E + 1/2*(expected(training_number) - o(2))^2;
        end

        % Part that regulates how change_weight changes. Decrease if the
        % error doesn't decrease. Increase if error decreases many times in
        % a row.
        if(hasAdaptativeEta!=-1)
            if (E >= E_best && E_best ~= -1)
                W_1 = W_1_best;
                W_2 = W_2_best;
                change_weight = 0.5*change_weight;
                decreaseCounter = 0;
                if (change_weight < 10^-10)
                    change_weight = 0.1;
                end
            elseif (E < E_best || E_best == -1)
                E_best = E;
                W_1_best = W_1;
                W_2_best = W_2;
                decreaseCounter = decreaseCounter + 1;
                if (decreaseCounter == 5)
                    change_weight = change_weight + 0.4;
                    decreaseCounter = 0;
                end
            end
        end
        % Adding a new data point over error-history.
        if(i ~= 1)
            diff(i/trainingAmount) = E;
        end
        
        % Output. Both to command-line and to screen.
        if (mod(i,20*trainingAmount) == 0)
            disp(W_1_best);
            disp(W_2_best);
            disp(i/maxIt);
            disp(E_best);
            Out = zeros(size(training,1),1);
            for j=1:size(training,1)
                [h_1, V] = calculateLayer(W_1_best, transpose(training(j,:)), gName);
                [h_2, o] = calculateLayer(W_2_best, V, 'lineal');
                Out(j) = o(2);
            end
            subplot(1,2,1); plot(diff(20:end));
            subplot(1,2,2);
            plot(training(:,2)',Out); hold on;
            plot(training(:,2)',expected,'r*'); hold off; shg;
        end
        
        % Break if error is smaller than tollerance
        if (E < ETol)
            W{1} = W_1_best;
            W{2} = W_2_best;
            break;
        end
    else
        % To calculate how we should change the weights and changing the weights.
        training_number = floor(rand()*size(training,1)+1);
        [h_1, V] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
        [h_2, o] = calculateLayer(W_2, V, 'lineal');
        
        [fL, sL] = changeMatrix(transpose(training(training_number,:)), h_1, V, W_2, h_2, o, expected(training_number), gName);
        
        W_1 = W_1 + change_weight*fL;
        W_2 = W_2 + change_weight*sL;
    end

end

end
