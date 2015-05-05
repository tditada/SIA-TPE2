function  [ matrix, V ]  = generateTrainingTPfunction(amount,random)
if random == 1
    X = zeros(amount,1);
    for i = 1:amount
        X(i) = 2*rand() - 1;
    end
    matrix=sort(X);
else
    matrix = linspace(-1,1,amount)';
end
V = TPfunction(matrix);
end