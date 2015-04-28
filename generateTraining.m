function [training, expected] = generateTraining(learningFunction, inputAmount)
	switch learningFunction
		case 'and'
			[training, expected]=generateTrainingAnd(inputAmount);
			break;
		case 'or'
			[training, expected]=generateTrainingOr(inputAmount);
			break;
		case 'xor'
			[training, expected]=generateTrainingXor(inputAmount);
			break;
		case 'parity'
			[training, expected]=generateTrainingParity(inputAmount);
			break;	
		case 'symmetry'
			[training, expected]=generateTrainingSymmetry(inputAmount);
			break;
		otherwise
			disp('malisimo');
	end
end