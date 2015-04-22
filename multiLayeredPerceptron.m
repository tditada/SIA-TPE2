function ret = multiLayeredPerceptron(inputAmount, middleAmount, learningFunction, gName)
%learningRate = 0.1;
[training, expected] = generateTraining(learningFunction, inputAmount);
W_1 = weightGenerator(inputAmount, middleAmount);
W_2 = weightGenerator(middleAmount, 1);

training = [-1*ones(size(training,1),1) training];

change_weight = 0.3;

diff = zeros(1000,1);

for i = 1:1000
    fL = zeros(size(W_1));
    sL = zeros(size(W_2));
    E = 0;
    for training_number = 1:size(training,1)
        [h_1, V] = calculateLayer(W_1, transpose(training(training_number,:)), gName);
        [h_2, o] = calculateLayer(W_2, V, gName);
        E = E + (expected(training_number) - o(2))^2;
        
        
        [fLd, sLd] = changeMatrix(transpose(training(training_number,:)), h_1, V, W_2, h_2, o, expected(training_number), gName);
        fL = fL + fLd;
        sL = sL + sLd;
    end
    
    W_1 = W_1 + change_weight*fL;
    W_2 = W_2 + change_weight*sL;
    if (change_weight > 0.05)
        change_weight = change_weight*0.95;
    elseif (change_weight <= 0.001)
        change_weight = 0.001;
    end
    diff(i) = 1/2*E;
end

plot(diff); shg;

%TO-DO: backpropagation
%vec_error = expected - ret;
%deriv = zeros(size(training,1), 1);
%for i = 1:size(training,1)
%	deriv(i,1) = gDerivated(gName, h2(1,1));
%end
end

function ans = layerOutput(training, firstLayerWeights, gName, outputSize)
ans = zeros(size(training,1), outputSize);
for i = 1:size(training,1)
    givenInput = transpose(training(i,:));
    aux = preOutput(givenInput, firstLayerWeights);
    for j = 1: size(aux,1);
        o = g(gName, aux(j,1), firstLayerWeights(j,1));
        ans(i, j) = o;
    end
end
end