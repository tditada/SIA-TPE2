%% trainNet: funcion de entrenamiento
function [W, dif] = trainNet(W, trainingAmount, hiddenAmount, maxIt, ETol, gName, saturationControl, hasAdaptativeEta, hasMomentum, a_etha, b_etha)
% middle amount tiene celdas una por cada cantidad en la capa oculta respectiva 
% if saturation control = -1, no saturation.
	[training, expected] = generateTrainingTPfunctionChosenOnes(trainingAmount);
	training = [training, expected];
	
	% (W_1, W_2, W_3, trainingSet, middleAmount, gName, maxIt,ETol, hasAdaptativeEta, saturationControl, hasMomentum, a_etha, b_etha)
	if(hiddenAmount==1)
		[W, dif] = multiLayeredPerceptron(W{1}, W{2}, training, gName, maxIt, ETol, saturationControl, hasAdaptativeEta, hasMomentum, a_etha, b_etha);
	elseif(hiddenAmount==2)
		[W, dif] = multiLayeredPerceptron2(W{1}, W{2}, W{3}, training, gName, maxIt, ETol, saturationControl, hasAdaptativeEta, hasMomentum, a_etha, b_etha);
	else
		disp('Invalid hidden amount');
		return;
	end
	disp(W);
end