function o = gDerivated(gName, x)
	switch gName
		case 'tangente'
			o = 0.5*(1-(tanh(0.5*x)^2));
		case 'exponencial'
			o = 2*0.5*(1/(1+e^(-2*0.5*x)))*(1-(1/(1+e^(-2*0.5*x))));
        case 'lineal'
            o = 1;
		otherwise
			disp('Invalid gDerivated function');
	end
end