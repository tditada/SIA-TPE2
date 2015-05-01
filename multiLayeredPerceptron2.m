function [W_1_best, W_2_best, W_3_best, diff] = multiLayeredPerceptron2(trainingSet, middleAmount_2, middleAmount_3, gName, maxIt, calcAllFreq, ETol)

training = trainingSet(:,1:end-1);
expected = trainingSet(:,end);
inputAmount = 1;

% Generate random weights.
W_1 = weightGenerator(inputAmount, middleAmount_2);
W_2 = weightGenerator(middleAmount_2, middleAmount_3);
W_3 = weightGenerator(middleAmount_3, 1);
W_1_best = W_1; W_2_best = W_2; W_3_best = W_3;

% Adding the first column of -1 to training-set.
training = [-1*ones(size(training,1),1) training];

% Start values
change_weight = 0.001;
E_best = -1;
decreaseCounter = 0;

for i = 1:maxIt
    fL = zeros(size(W_1));
    sL = zeros(size(W_2));
    tL = zeros(size(W_3));
    E = 0;
    if (mod(i,calcAllFreq) == 0 || i == 1)
        %To calculate how the error changes.
        for training_number = 1:size(training,1)
            [h_1, V_1] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
            disp('h_1');
            disp(h_1);
            disp('V_1');
            disp(V_1);
            [h_2, V_2] = calculateLayer(W_2, V_1, gName);
            disp('h_2');
            disp(h_2);
            disp('V_2');
            disp(V_2);
            [h_3, o] = calculateLayer(W_3, V_2, 'lineal');
            disp('h_3');
            disp(h_3);
            disp('o');
            disp(o);
            E = E + 1/2*(expected(training_number) - o(2))^2;
        end

        % Part that regulates how change_weight changes. Decrease if the
        % error doesn't decrease. Increase if error decreases many times in
        % a row.
        
        if (E >= E_best && E_best ~= -1)
            W_1 = W_1_best;
            W_2 = W_2_best;
            W_3 = W_3_best;
            change_weight = 0.9*change_weight;
            decreaseCounter = 0;
            if (change_weight < 10^-10)
                change_weight = 0.1;
            end
        elseif (E < E_best || E_best == -1)
            E_best = E;
            W_1_best = W_1;
            W_2_best = W_2;
            W_3_best = W_3;
            decreaseCounter = decreaseCounter + 1;
            if (decreaseCounter == 5)
                change_weight = 2*change_weight;
                decreaseCounter = 0;
            end
        end
        % Adding a new data point over error-history.
        if(i ~= 1)
            diff(i/calcAllFreq) = E;
        end
        
        % Output. Both to command-line and to screen.
        if (mod(i,20*calcAllFreq) == 0)
           % disp(W_1_best);
           % disp(W_2_best);
           % disp(W_3_best);
           % disp(i/maxIt);
           % disp(E_best);
            Out = zeros(size(training,1),1);
            for j=1:size(training,1)
                [h_1, V_1] = calculateLayer(W_1_best, transpose(training(training_number,:)), gName);
                [h_2, V_2] = calculateLayer(W_2_best, V_1, gName);
                [h_3, o] = calculateLayer(W_3_best, V_2, 'lineal');
                Out(j) = o(2);
            end
            subplot(1,2,1); plot(diff(20:end));
            subplot(1,2,2);
            plot(training(:,2)',Out); hold on;
            plot(training(:,2)',expected,'r*'); hold off; shg;
        end
        
        % Break if error is smaller than tollerance
        if (E < ETol)
            break;
        end
    else
        % To calculate how we should change the weights and changing the weights.
        training_number = floor(rand()*size(training,1)+1);
        [h_1, V_1] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
        [h_2, V_2] = calculateLayer(W_2, V_1, gName);
        [h_3, o] = calculateLayer(W_3, V_2, 'lineal');
        
        [fL, sL, tL] = changeMatrix2(transpose(training(training_number,:)), h_1, V_1, W_2, h_2, V_2, W_3, h_3, o, expected(training_number), gName);
        
        W_1 = W_1 + change_weight*fL;
        W_2 = W_2 + change_weight*sL;
        W_3 = W_3 + change_weight*tL;
    end

end

end