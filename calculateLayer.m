function [ hVector, output ] = calculateLayer( weights, input, gName )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%NOTE: input should be of the form (-1 e_1 e_2 e_3...). The output
% will be of the same form i.e. (-1 o_1 o_2 o_3...), but hVector of the
% form (h_1 h_2 h_3...). This to fasten the calculation process.

hVector = weights*input;
output = zeros(size(hVector,1) + 1, 1);
output(1) = -1;
for i = 1:size(hVector,1);
    % apply for 'step'
    output(i + 1) = g(gName, hVector(i), 1);
end

end

