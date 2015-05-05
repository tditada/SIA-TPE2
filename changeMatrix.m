function [ firstLayer, secondLayer ] = changeMatrix(E, h_1, V, W_2, h_2, o, S, gName)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% Calculates one term in the sums on slide 11 and 12. The symbols are:
% E - input [-1, E]'
% h_1 - calculated value in first layer (before g(h_1))
% V - calculated value in first layer (after g(h_1)). [-1, V]'
% W_2 - matrix with weigths between second layer and output.
% h_2 - calculated value in second layer (before g(h_2))
% o - calculated value in second layer (after g(h_2)) [-1, o]'
% S - desired output
% gName - name of the g-function to use.

outputAmount = size(S,1);
inputAmount = size(E,1);
layerAmount = size(h_1,1);

g_2_prim = zeros(outputAmount,1);
for i = 1:outputAmount
    g_2_prim(i) = gDerivated('lineal', h_2(i));
end

delta_2 = (S - o(2:end)).*g_2_prim;
secondLayer = delta_2*transpose(V);

g_1_prim = zeros(layerAmount,1);
for i = 1:layerAmount
    g_1_prim(i) = gDerivated(gName, h_1(i));
end

delta_1 = transpose(W_2(:,2:end))*delta_2.* g_1_prim;
firstLayer = delta_1*transpose(E);

end

