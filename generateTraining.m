function [training, expected] = generateTraining(learningFunction, inputAmount)
	switch learningFunction
		case 'and'
			[training, expected]=generateTrainingAnd(inputAmount);
			break;
		case 'or'
			[training, expected]=generateTrainingOr(inputAmount);
			break;
		case 'parity'
			[training, expected]=generateTrainingParity(inputAmount);	
			break;
		case 'simetry'
			[training, expected]=generateTrainingSimetry(inputAmount);
			break;
		otherwise
			disp('malisimo');
	end
end