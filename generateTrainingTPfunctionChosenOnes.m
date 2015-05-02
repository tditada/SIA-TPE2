function  [ matrix, V ]  = generateTrainingTPfunctionChosenOnes(amount)
	X = [linspace(-1,-0.95,amount/6), linspace(-0.9,-0.6,amount/6), linspace(-0.5,-0.155,2*(amount/6)), linspace(0.1,0.5,amount/6), linspace(0.8,1,amount/6)];
	aux = randperm(size(X,2));
	matrix = zeros(1, size(X,2));
	for i = 1:size(X,2)
		matrix(i) = X(aux(i));
	end
	matrix = transpose(X);
	V = TPfunction(matrix);
end