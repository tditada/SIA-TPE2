function [training, expected] = generateTraining(learningFunction, inputAmount)
	switch learningFunction
		case 'and'
			[training, expected]=generateTrainingAnd(inputAmount);
		case 'or'
			[training, expected]=generateTrainingOr(inputAmount);
		case 'xor'
			[training, expected]=generateTrainingXor(inputAmount);
		case 'parity'
			[training, expected]=generateTrainingParity(inputAmount);	
		case 'symmetry'
			[training, expected]=generateTrainingSymmetry(inputAmount);
		otherwise
<<<<<<< HEAD
			disp('invalid function');
=======
			disp('Invalid function');
>>>>>>> 8c75712b3bf0a11f880831e7a7029b2f545108d7
	end
end
