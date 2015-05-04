function [W, diff] = multiLayeredAll(W, saturationControl, trainingSet, layers, middleAmount, gName, maxIt, ETol, hasAdaptativeEta, a_etha, b_etha)
    graphics_toolkit('gnuplot');
    training = trainingSet(:,1:end-1);
    expected = trainingSet(:,end);
    trainingAmount = size (training, 1);
    inputAmount = 1;
    saturationDeltaTangente = 0.001;
    saturationDeltaExponencial = 0.01;

    for i=1:layers
        W_best{i} = W{i};
    end

    % Adding the first column of -1 to training-set.
    training = [-1*ones(size(training,1),1) training];

    % Start values, entre 0,05 y 0,5
    change_weight = 0.5;
    E_best = -1;
    decreaseCounter = 0;

    for i = 1:maxIt
        for j=1:layers
            deltaW{j}=zeros(size(W{j}));
        end
        E = 0;
        if (mod(i,trainingAmount) == 0 || i == 1)
            [h, V, Out, E] = forwardPropagation(W, training, expected, gName, layers, -1,i);
            if(i ~= 1)
                diff(i/trainingAmount) = E;
            end
            % Part that regulates how change_weight changes. Decrease if the
            % error doesn't decrease. Increase if error decreases many times in
            % a row.
            % if(hasAdaptativeEta!=-1)
            %     if( i!=1 && mod(i/trainingAmount,25)==0)
            %         if (E >= E_best && E_best ~= -1)
            %             for i=1:middleAmount+1
            %                 W{i} = W_best{i};
            %             end
            %             change_weight = b_etha*change_weight;
            %             decreaseCounter = 0;
            %             if (change_weight < 10^-10)
            %                 change_weight = 0.05;
            %             end
            %         elseif (E < E_best || E_best == -1)
            %             E_best = E;
            %             for i=1:middleAmount+1
            %                 W_best{i} = W{i};
            %             end
            %             decreaseCounter = decreaseCounter + 1;
            %             if (decreaseCounter == 5)
            %                 change_weight = change_weight + a_etha;
            %                 decreaseCounter = 0;
            %                 if (change_weight >1)
            %                   change_weight = 0.5;
            %                 end
            %             end
            %         end           
            %     end
            % end
            % Output. Both to command-line and to screen.
            if (mod(i,trainingAmount) == 0)
                subplot(1,2,1);
                plot(diff); shg;
                subplot(1,2,2);
                plot(training(:,2),Out); hold on; 
                plot(training(:,2),expected,'r*'); hold off; shg

                % subplot(1,2,1); plot(diff);
                % subplot(1,2,2);
                % plot(training(:,2)',Out); hold on;
                % plot(training(:,2)',expected,'r*'); hold off; shg;
                % [h, V, Out, E, diff] = forwardPropagation(W, training, expected, gName, layers+,1);
            end
            
            % Break if error is smaller than tollerance
            if (E < ETol && i!=1)
            %     W{1} = W_1;
            %     W{2} = W_2;
            %     W{3} = W_3;
                return;
            end
        else
            % To calculate how we should change the weights and changing the weights.
            training_number = floor(rand()*size(training,1)+1);
            [h_1, V_1] = calculateLayer(W{1}, transpose(training(training_number,:)), gName);
            [h_2, V_2] = calculateLayer(W{2}, V_1, gName);
            [h_3, o] = calculateLayer(W{3}, V_2, 'lineal');
            
            [fL, sL, tL] = changeMatrix2(transpose(training(training_number,:)), h_1, V_1, W{2}, h_2, V_2, W{3}, h_3, o(2:end), expected(training_number), gName);
            
            % W_1 = W_1 + change_weight*fL;
            % W_2 = W_2 + change_weight*sL;
            % W_3 = W_3 + change_weight*tL;

            % training_number = floor(rand()*size(training,1)+1);
            % [h, V, Out, E, diff] = forwardPropagation(W, training, expected, gName, layers,-1);
            %[fL, sL, tL] = changeMatrix2(transpose(training(training_number,:)), h{1}, V{1}, W{2}, h{2}, V{2}, W{3}, h{3}, o(2:end), expected(training_number), gName);
            deltaW{1}=fL;
            deltaW{2}=sL;
            deltaW{3}=tL;
            % disp('detaW');
            % disp(deltaW);      
            % fflush(stdout);    
            for k=1:layers
                W{k} = W{k} + change_weight*deltaW{k};
                fflush(stdout);
            end
        end

        % %Calculate saturation
        % if (i != 1 && mod(i, trainingAmount*saturationControl) == 0)
        %     disp('in sat');
        %     if (gName == 'tangente')
        %         sat_delta = saturationDeltaTangente
        %     else if (gName == 'exponencial')
        %         sat_delta = saturationDeltaExponencial
        %     end
        %     %Calculate if there is saturation
        %     saturation = false;
        %     for u= 1: size(W_1,1)
        %         for v = 1: size(W_1,2)
        %             if(abs(W_1(u,v)) < sat_delta)
        %                 disp('saturacion');
        %                 disp(W_1(u,v));
        %                 saturation = true;
        %                 break;
        %             end
        %         end
        %     end
        %     if (!saturation)
        %         for u = 1: size(W_2, 1)
        %             for v = 2: size(W_2,2)
        %                 if (abs(W_2(u,v)) < sat_delta)
        %                     disp('saturacion');
        %                     disp(W_2(u,v));
        %                     saturation = true;
        %                     break;
        %                 end
        %             end
        %         end
        %     end
        %     if (!saturation)
        %         for u = 1: size(W_3, 1)
        %             for v = 2: size(W_3,2)
        %                 if (abs(W_3(u,v)) < sat_delta)
        %                     disp('saturacion');
        %                     disp(W_3(u,v));
        %                     saturation = true;
        %                     break;
        %                 end
        %             end
        %         end
        %     end
        %     %if there is saturation
        %     if (saturation)
        %         disp('saturacion epoca');
        %         disp(i);
        %         disp(' ');
        %         delta = rand()/10;
        %         W_1 = W_1 + delta;
        %         W_2 = W_2 + delta;
        %         W_3 = W_3 + delta;
        %     else
        %         disp('no saturation');
        %     end
        % end
    end

end
