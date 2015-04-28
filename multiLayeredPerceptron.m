function ret = multiLayeredPerceptron()
%learningRate = 0.1;
% clear;
inputAmount = 2;
middleAmount = 2;
learningFunction = 'xor';
gName = 'sigmodea';

[training, expected] = generateTraining(learningFunction, inputAmount);
W_1 = weightGenerator(inputAmount, middleAmount);
W_2 = weightGenerator(middleAmount, 1);

W_1_best = W_1;
W_2_best = W_2;
E_best = 10000;

training = [-1*ones(size(training,1),1) training];

change_weight = 0.5;

diff = 0;

for i = 1:100000
    fL = zeros(size(W_1));
    sL = zeros(size(W_2));
    E = 0;
    if (mod(i,25) == 0)
        for training_number = 1:size(training,1)
            [h_1, V] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
            [h_2, o] = calculateLayer(W_2, V, gName);
            E = E + (expected(training_number) - o(2))^2;
            
            
            [fLd, sLd] = changeMatrix(transpose(training(training_number,:)), h_1, V, W_2, h_2, o, expected(training_number), gName);
            fL = fL + fLd;
            sL = sL + sLd;
        end
        if (E > E_best)
            fL = 0; sL = 0;
            W_1 = W_1_best;
            W_2 = W_2_best;
            E = E_best;
        end
        
        diff(i/25) = 1/2*E;
    else
        training_number = floor(rand()*size(training,1)+1);
        [h_1, V] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
        [h_2, o] = calculateLayer(W_2, V, gName);
        E = E + (expected(training_number) - o(2))^2;
        
        
        [fL, sL] = changeMatrix(transpose(training(training_number,:)), h_1, V, W_2, h_2, o, expected(training_number), gName);
    end
    
    W_1 = W_1 + change_weight*fL;
    W_2 = W_2 + change_weight*sL;
    if (mod(i,25) == 0)
        E_best = E;
        W_1_best = W_1;
        W_2_best = W_2;
    end
    if (change_weight > 0.01)
        change_weight = change_weight*0.97;
    else
        change_weight = 0.5;
    end
end

plot(diff); shg;

end