function  [ matrix, V ]  = generateTrainingTPfunction(amount)
	X = zeros(amount,1);
    for i = 1:amount
        X(i) = 2*rand() - 1;
    end
	matrix=sort(X);
	V = TPfunction(matrix);
end