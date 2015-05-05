function [W, dif, out] = multiLayeredPerceptron2(W_1, W_2, W_3, trainingSet, gName, maxIt,ETol, saturationControl, hasAdaptativeEta, hasMomentum, a_etha, b_etha)

%Layers amount (without the entry layer)

    training = trainingSet(:,1:end-1);
    expected = trainingSet(:,end);
    trainingAmount = size(training, 1);
    inputAmount = 1;
    alpha = 0.2;
    delta_prev_1 = 0;
    delta_prev_2 = 0;
    delta_prev_3 = 0;
    saturationDeltaTangente = 0.001;
    saturationDeltaExponencial = 0.01;

    W_1_best = W_1; W_2_best = W_2; W_3_best = W_3;

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
    if (mod(i,trainingAmount) == 0 || i == 1)
        %To calculate how the error changes.
        for training_number = 1:size(training,1)
            [h_1, V_1] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
            [h_2, V_2] = calculateLayer(W_2, V_1, gName);
            [h_3, o] = calculateLayer(W_3, V_2, 'lineal');
            E = E + 1/2*(expected(training_number) - o(2))^2;

            % Adding a new data point over error-history.
            if(i ~= 1)
                dif(i/trainingAmount) = E;
            end
        end

        % Part that regulates how change_weight changes. Decrease if the
        % error doesn't decrease. Increase if error decreases many times in
        % a row.
        if(hasAdaptativeEta!=-1)
            if( i!=1 && mod(i/trainingAmount,25)==0)
                if (E >= E_best && E_best ~= -1)
                    W_1 = W_1_best;
                    W_2 = W_2_best;
                    W_3 = W_3_best;
                    alpha = 0;
                    change_weight = b_etha*change_weight;
                    decreaseCounter = 0;
                    if (change_weight < 10^-10)
                        change_weight = 0.05;
                    end
                elseif (E < E_best || E_best == -1)
                    E_best = E;
                    W_1_best = W_1;
                    W_2_best = W_2;
                    W_3_best = W_3;
                    alpha = 0.2;
                    decreaseCounter = decreaseCounter + 1;
                    if (decreaseCounter == 5)
                        change_weight = change_weight + a_etha;
                        decreaseCounter = 0;
                        if (change_weight >1)
                          change_weight = 0.5;
                        end
                    end
                end
            end
        end
        % Output. Both to command-line and to screen.
        if (mod(i,10*trainingAmount) == 0)
            Out = zeros(size(training,1),1);
            for j=1:size(training,1)
                [h_1, V_1] = calculateLayer(W_1, transpose(training(j,:)), gName);
                [h_2, V_2] = calculateLayer(W_2, V_1, gName);
                [h_3, o] = calculateLayer(W_3, V_2, 'lineal');
                Out(j) = o(2);
                out=Out;
            end
            subplot(1,2,1);title('error cuadrático medio'); plot(dif);
            subplot(1,2,2);title('aprendizaje');
            plot(training(:,2)',Out); hold on;
            plot(training(:,2)',expected,'r*'); hold off; shg;
        end
        
        % Break if error is smaller than tollerance
        if (E < ETol)
            W{1} = W_1;
            W{2} = W_2;
            W{3} = W_3;
            subplot(1,2,1); title('error cuadrático medio');plot(dif);
            subplot(1,2,2); title('aprendizaje');
            plot(training(:,2)',Out); hold on;
            plot(training(:,2)',expected,'r*'); hold off; shg;
            disp('Error:');
            disp(E);
            disp(' ');
            disp('Cantidad de epocas');
            disp(i/trainingAmount);
            return;
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

            if(hasMomentum)
                W_1 = W_1 + delta_prev_1 * alpha;
                W_2 = W_2 + delta_prev_2 * alpha;
                W_3 = W_3 + delta_prev_3 * alpha;
                delta_prev_1 = change_weight*fL + delta_prev_1 * alpha;
                delta_prev_2 = change_weight*sL + delta_prev_2 * alpha;
                delta_prev_3 = change_weight*tL + delta_prev_3 * alpha;
            end
        end

    end

    if(saturationControl!=-1)
        %Calculate saturation
        if (i != 1 && mod(i, trainingAmount*saturationControl) == 0)
            if (gName == 'tangente')
                sat_delta = saturationDeltaTangente;
            else if (gName == 'exponencial')
                sat_delta = saturationDeltaExponencial;
            end
            %Calculate if there is saturation
            saturation = false;
            for u= 1: size(W_1,1)
                for v = 1: size(W_1,2)
                    if(abs(W_1(u,v)) < sat_delta)
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
                        if (abs(W_2(u,v)) < sat_delta)
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
                        if (abs(W_3(u,v)) < sat_delta)
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
                disp('saturacion epoca');
                disp(i);
                disp(' ');
                delta = rand()/10;
                W_1 = W_1 + delta;
                W_2 = W_2 + delta;
                W_3 = W_3 + delta;
            else
                disp('no saturation');
            end
        end
    end
end
