function [W_1_best, W_2_best, diff, w_v] = multiLayeredPerceptron(trainingSet, middleAmount, gName, maxIt, calcAllFreq, ETol)

training = trainingSet(:,1:end-1);
expected = trainingSet(:,end);
inputAmount = size(training,2);

W_1 = weightGenerator(inputAmount, middleAmount);
W_2 = weightGenerator(middleAmount, 1);

E_best = -1;

training = [-1*ones(size(training,1),1) training];

change_weight = 0.01;

for i = 1:maxIt
    fL = zeros(size(W_1));
    sL = zeros(size(W_2));
    E = 0;
    if (mod(i,calcAllFreq) == 0)
        for training_number = 1:size(training,1)
            [h_1, V] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
            [h_2, o] = calculateLayer(W_2, V, 'lineal');
            E = E + (expected(training_number) - o(2))^2;
            
%            [fLd, sLd] = changeMatrix(transpose(training(training_number,:)), h_1, V, W_2, h_2, o, expected(training_number), gName);
%            fL = fL + fLd;
%            sL = sL + sLd;
        end
        if (E > E_best && E_best ~= -1)
            fL = 0; sL = 0;
            W_1 = W_1_best;
            W_2 = W_2_best;
        else 
            E_best = E;
            W_1_best = W_1;
            W_2_best = W_2;
        end
        
        diff(i/calcAllFreq) = 1/2*E;
        w_v(i/calcAllFreq) = change_weight;
        if (E < ETol)
            break;
        end
    else
        training_number = floor(rand()*size(training,1)+1);
        [h_1, V] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
        [h_2, o] = calculateLayer(W_2, V, 'lineal');
        
        [fL, sL] = changeMatrix(transpose(training(training_number,:)), h_1, V, W_2, h_2, o, expected(training_number), gName);
    end
    
    W_1 = W_1 + change_weight*fL;
    W_2 = W_2 + change_weight*sL;

    if (change_weight > 0.00001)
        change_weight = change_weight*0.99;
    else
        change_weight = 0.0001;
    end
end

end
