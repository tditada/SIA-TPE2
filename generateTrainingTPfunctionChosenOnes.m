function  [ matrix, V ]  = generateTrainingTPfunctionChosenOnes(amount)
	X = [linspace(-1,-0.95,amount/5), linspace(-0.9,-0.6,amount/5), linspace(-0.5,-0.2,amount/5), linspace(0.1,0.5,amount/5), linspace(0.8,1,amount/5)];
	matrix = transpose(X);
	V = TPfunction(matrix);
end