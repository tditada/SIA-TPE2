function [W_1_best, W_2_best, W_3_best, diff] = multiLayeredPerceptron2Momentum(trainingSet, middleAmount_2, middleAmount_3, gName, maxIt, calcAllFreq, ETol)

    training = trainingSet(:,1:end-1);
    expected = trainingSet(:,end);
    trainingAmount = size (training, 1);
    inputAmount = 1;
    alpha = 0.9;

    % Generate random weights.
    W_1 = weightGenerator(inputAmount, middleAmount_2);
    W_2 = weightGenerator(middleAmount_2, middleAmount_3);
    W_3 = weightGenerator(middleAmount_3, 1);
    W_1_best = W_1; W_2_best = W_2; W_3_best = W_3;
    delta_prev_1 = 0;
    delta_prev_2 = 0;
    delta_prev_3 = 0;

    % Adding the first column of -1 to training-set.
    training = [-1*ones(size(training,1),1) training];

    % Start values, entre 0,05 y 0,5
    change_weight = 0.5;
    E_best = -1;
    decreaseCounter = 0;

    for i = 1:maxIt
        fL = zeros(size(W_1));
        sL = zeros(size(W_2));
        tL = zeros(size(W_3));
        E = 0;
        %cuando termina una epoca.
        if (mod(i,trainingAmount) == 0 || i == 1)
            %To calculate how the error changes.
            for training_number = 1:size(training,1)
                [h_1, V_1] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
                % disp('h_1');
                % disp(h_1);
                % disp('V_1');
                % disp(V_1);
                [h_2, V_2] = calculateLayer(W_2, V_1, gName);
                % disp('h_2');
                % disp(h_2);
                % disp('V_2');
                % disp(V_2);
                [h_3, o] = calculateLayer(W_3, V_2, 'lineal');
                % disp('h_3');
                % disp(h_3);
                % disp('o');
                % disp(o);
                E = E + 1/2*(expected(training_number) - o(2))^2;

                % Adding a new data point over error-history.
                if(i ~= 1)
                    diff(i/trainingAmount) = E;
                end
            end

            % Part that regulates how change_weight changes. Decrease if the
            % error doesn't decrease. Increase if error decreases many times in
            % a row.
            if( i!=1 && mod(i/trainingAmount,25)==0)
                if (E >= E_best && E_best ~= -1)
                    W_1 = W_1_best;
                    W_2 = W_2_best;
                    W_3 = W_3_best;
                    % W_1_prev = W_1_best_prev;
                    % W_2_prev = W_2_best_prev;
                    % W_3_prev = W_3_best_prev;
                    change_weight = 0.999*change_weight;
                    decreaseCounter = 0;
                    if (change_weight < 10^-10)
                        change_weight = 0.05;
                    end
                elseif (E < E_best || E_best == -1)
                    E_best = E;
                    W_1_best = W_1;
                    W_2_best = W_2;
                    W_3_best = W_3;
                    % W_1_best_prev = W_1_prev;
                    % W_2_best_prev = W_2_prev;
                    % W_3_best_prev = W_3_prev;
                    decreaseCounter = decreaseCounter + 1;
                    if (decreaseCounter == 5)
                        change_weight = change_weight + 0.4;
                        decreaseCounter = 0;
                        if (change_weight >1)
                          change_weight = 0.5;
                        end
                    end
                end           
            end
            % Output. Both to command-line and to screen.
            if (mod(i,trainingAmount) == 0)
               % disp(W_1_best);
               % disp(W_2_best);
               % disp(W_3_best);
               % disp(i/maxIt);
               % disp(E_best);
                Out = zeros(size(training,1),1);
                for j=1:size(training,1)
                    %TO-DO: revisar si va W_1 o W_1_best
                    [h_1, V_1] = calculateLayer(W_1, transpose(training(j,:)), gName);
                    [h_2, V_2] = calculateLayer(W_2, V_1, gName);
                    [h_3, o] = calculateLayer(W_3, V_2, 'lineal');
                    Out(j) = o(2);
                end
                subplot(1,2,1); plot(diff);
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
            
            W_1 = W_1 + change_weight*fL + delta_prev_1* alpha;
            W_2 = W_2 + change_weight*sL + delta_prev_2* alpha;
            W_3 = W_3 + change_weight*tL + delta_prev_3* alpha ;
            delta_prev_1 = change_weight*fL + delta_prev_1 * alpha;
            delta_prev_2 = change_weight*sL + delta_prev_2 * alpha;
            delta_prev_3 = change_weight*tL + delta_prev_3 * alpha;
        end

    end


    %Calculate saturation
    if (i != 1 && mod(floor(i / trainingAmount), saturationControl) == 0)
        %Calculate if there is saturation
        saturation = false;
        for u= 1: size(W_1,1)
            for v = 1: size(W_1,2)
                if(abs(W_1(u,v)) < 0.001)
                    disp('saturacion');
                    disp(W_1(u,v));
                    saturation = true;
                    break;
                end
            end
        end
        if (!saturation)
            for u = 1: size(W_2, 1)
                for v = 2: size(W_2,2)
                    if (abs(W_2(u,v)) < 0.001)
                        disp('saturacion');
                        disp(W_2(u,v));
                        saturation = true;
                        break;
                    end
                end
            end
        end
        if (!saturation)
            for u = 1: size(W_3, 1)
                for v = 2: size(W_3,2)
                    if (abs(W_3(u,v)) < 0.001)
                        disp('saturacion');
                        disp(W_3(u,v));
                        saturation = true;
                        break;
                    end
                end
            end
        end
        %if there is saturation
        if (saturation)
            disp('saturacion');
            disp(i);
            disp(' ');
            delta = rand()/10;
            W_1 = W_1 + delta;
            W_2 = W_2 + delta;
            W_3 = W_3 + delta;
        end
    end
end