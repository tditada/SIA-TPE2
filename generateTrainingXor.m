function [ matrix, V ] = generateTrainingXor( n )
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
    % part that calculates the XOR
    V(i) = mod(sum(matrix(i,:)),2);
end

end

