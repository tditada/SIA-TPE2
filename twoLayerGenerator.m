function [ firstLayer, secondLayer ] = twoLayerGenerator( inputAmount, layerAmount, outputAmount )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

firstLayer = zeros(layerAmount, inputAmount + 1);
secondLayer = zeros(outputAmount, layerAmount + 1);

for i = 1:layerAmount
    for j = 1:inputAmount + 1
        firstLayer(i,j) = rand*2 - 1;
    end
end

for i = 1:outputAmount
    for j = 1:layerAmount + 1
        secondLayer(i,j) = rand*2 - 1;
    end
end

end