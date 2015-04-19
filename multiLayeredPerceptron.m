function ret = multiLayeredPerceptron(inputAmount, middleAmount, outputAmount, learningFunction, gName)
	[training, expected] = generateTraining(learningFunction, inputAmount);
	firstLayerWeights = twoLayerGenerator(inputAmount, middleAmount);
	secondLayerWeights = twoLayerGenerator(middleAmount, outputAmount);
	firstOutput = layerOutput(training, firstLayerWeights, gName, middleAmount);
	secondOutput = layerOutput(firstOutput, secondLayerWeights, gName, outputAmount);
	disp('first layer weights');
	disp(firstLayerWeights);
	disp('second layer weights');
	disp(secondLayerWeights);
	disp('training');
	disp(training);
	disp('first output');
	disp(firstOutput);
	ret = secondOutput;
	disp('ret');
	disp(ret);
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