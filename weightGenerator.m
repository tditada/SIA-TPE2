function  weights = weightGenerator( inputAmount, outputAmount )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

weights = zeros(outputAmount, inputAmount + 1);

for i = 1:outputAmount
    for j = 1:inputAmount + 1
        weights(i,j) = 2*rand - 1;
    end
end

end