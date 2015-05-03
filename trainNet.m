%% trainNet: funcion de entrenamiento
function [W, diff] = trainNet(W_1, W_2, W_3, trainingAmount, hiddenAmount, middleAmount, maxIt, ETol, gName, saturationControl, hasAdaptativeEta)
% middle amount tiene celdas una por cada cantidad en la capa oculta respectiva 
% if saturation control = -1, no saturation.
	[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
	training = [training, expected];
	if(hiddenAmount==2 && saturationControl==-1)
		[W, diff] = multiLayeredPerceptron2(W_1, W_2, W_3, training, middleAmount, gName, maxIt, ETol, hasAdaptativeEta);
	elseif(hiddenAmount==2 && saturationControl!=1)
		[W, diff] = multiLayeredPerceptronWithSaturationControl2(W_1, W_2, W_3, saturationControl, training, middleAmount, gName, maxIt, ETol, hasAdaptativeEta)
	elseif(hiddenAmount==1 && saturationControl==-1)
		[W, diff] = multiLayeredPerceptron(W_1, W_2, training, middleAmount, gName, maxIt, ETol, hasAdaptativeEta);
	elseif(hiddenAmount==1 && saturationControl!=-1)
		[W, diff] = multiLayeredPerceptronWithSaturationControl(W_1, W_2, saturationControl, trainingSet, middleAmount, gName, maxIt, ETol, hasAdaptativeEta);
	end

end