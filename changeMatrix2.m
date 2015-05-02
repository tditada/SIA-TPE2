function [ firstLayer, secondLayer, thirdLayer ] = changeMatrix2(E, h_1, V_1, W_2, h_2, V_2, W_3, h_3, o, S, gName)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% Calculates one term in the sums on slide 11 and 12. The symbols are:
% E - input [-1, E]'
% h_1 - calculated value in first layer (before g(h_1))
% V - calculated value in first layer (after g(h_1)). [-1, V]'
% W_2 - matrix with weigths between second layer and third layer.
% W_3 - matrix with weigths between third layer and output.
% h_2 - calculated value in second layer (before g(h_2))
% h_3 - calculated value in third layer (before g(h_3))
% o - calculated value in second layer (after g(h_2)) [-1, o]'
% S - desired output
% gName - name of the g-function to use.

outputAmount = size(S,1);
inputAmount = size(E,1);
layerAmount_2 = size(h_2,1);
layerAmount_1 = size(h_1,1);

g_3_prim = zeros(outputAmount,1);
for i = 1:outputAmount
    g_3_prim(i) = gDerivated('lineal', h_3(i));
end

delta_3 = (S - o(2:end)).*g_3_prim;
thirdLayer = delta_3*transpose(V_2);

g_2_prim = zeros(layerAmount_2,1);
for i = 1:layerAmount_2
    g_2_prim(i) = gDerivated(gName, h_2(i));
end

delta_2 = transpose(W_3(:,2:end))*delta_3.* g_2_prim;
secondLayer = delta_2*transpose(V_1);

g_1_prim = zeros(layerAmount_1,1);
for i = 1:layerAmount_1
    g_1_prim(i) = gDerivated(gName, h_1(i));
end

delta_1 = transpose(W_2(:,2:end))*delta_2.* g_1_prim;
firstLayer = delta_1*transpose(E);

disp(firstLayer);
disp(secondLayer);
disp(thirdLayer);
end