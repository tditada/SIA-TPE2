function  weights = weightGenerator( inputAmount, outputAmount )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

weights = zeros(outputAmount, inputAmount + 1);

for i = 1:outputAmount
    for j = 1:inputAmount + 1
        weights(i,j) = rand - 0.5;
    end
end

end