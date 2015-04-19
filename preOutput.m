function ret=layerOutput(training, weights)
	aux = zeros(size(training,1)+1,1);
	aux(1,1)=-1;
	aux(2:size(aux,1), 1) = training(:,1);
	ret = weights * aux;
end