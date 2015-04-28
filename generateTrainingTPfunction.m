function  [ matrix, V ]  = generateTrainingTPfunction()
	x=-1:0.2:-1;
	matrix=transpose(x);
	V = TPfunction(transpose(x));
end