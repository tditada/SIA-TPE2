%% trainNet: funcion de entrenamiento
function [W, diff] = trainNet(trainingAmount, hiddenAmount, middleAmount, maxIt, ETol, gName, saturationControl, hasAdaptativeEta, hasMomentum,a_etha, b_etha)
% middle amount tiene celdas una por cada cantidad en la capa oculta respectiva 
% if saturation control = -1, no saturation.
	[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
	training = [training, expected];
	if(hiddenAmount==2 && saturationControl==-1)
		[W, diff] = multiLayeredPerceptron2(training, middleAmount, gName, maxIt, ETol, hasAdaptativeEta,a_etha, b_etha);
	elseif(hiddenAmount==2 && saturationControl!=-1)
		[W, diff] = multiLayeredPerceptronWithSaturationControl2(saturationControl, training, middleAmount, gName, maxIt, ETol, hasAdaptativeEta,a_etha, b_etha)
	elseif(hiddenAmount==1 && saturationControl==-1)
		[W, diff] = multiLayeredPerceptron(training, middleAmount, gName, maxIt, ETol, hasAdaptativeEta,a_etha, b_etha);
	elseif(hiddenAmount==1 && saturationControl!=-1)
		[W, diff] = multiLayeredPerceptronWithSaturationControl(saturationControl, trainingSet, middleAmount, gName, maxIt, ETol, hasAdaptativeEta,a_etha, b_etha);
	end
	disp(W);
end