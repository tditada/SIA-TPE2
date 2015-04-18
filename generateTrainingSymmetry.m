function [ matrix, V ] = generateTrainingSymmetry( n )
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
    % part that calculates the Symmetric
    symmetric = 1;
    for j = 1:round(n/2)
        if (matrix(i,j) ~= matrix(i,n + 1 - j))
            symmetric = 0;
            break
        end
    end
    V(i) = symmetric;
end

end

