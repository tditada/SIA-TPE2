function [ matrix, V ] = generateTrainingAnd( n )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
matrix = zeros(2^n,n);
V = zeros(n,1);
for i = 1:2^n
    tmp = i;
    for j = n:-1:1
        if (tmp > 2^(j - 1))
            matrix(i,j) = 1;
            tmp  = tmp - 2^(j - 1);
        end
    end
    % part that calculates the AND
    and = 1;
    for j = 1:n
        if (matrix(i,j) == 0)
            and = 0;
            break
        end
    end
    V(i) = and;
end

end

