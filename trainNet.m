%% trainNet: funcion de entrenamiento
function [W_1, W_2, diff] = trainNet(trainingAmount, middleAmount, maxIt, Etol, gName)

	calcAllFreq = trainingAmount;
	[training, expected] = generateTrainingTPfunction(trainingAmount,0);
	training = [training, expected];

	[W_1, W_2, diff] = multiLayeredPerceptron(training, middleAmount, gName, maxIt, calcAllFreq, ETol);

end