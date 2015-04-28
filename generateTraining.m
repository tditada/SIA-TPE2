function [training, expected] = generateTraining(learningFunction, inputAmount)
	switch learningFunction
		case 'and'
			[training, expected]=generateTrainingAnd(inputAmount);
		case 'or'
			[training, expected]=generateTrainingOr(inputAmount);
		case 'parity'
			[training, expected]=generateTrainingParity(inputAmount);	
		case 'symmetry'
			[training, expected]=generateTrainingSymmetry(inputAmount);
		otherwise
			disp('malisimo');
	end
end