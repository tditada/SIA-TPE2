function o = g(gName, x, threshold)
	switch gName
		case 'step'
			o = stepFunction(x, threshold);
		case 'tangente'
			o = tanh(0.5*x);
		case 'exponencial'
			o = 1/(1+e^(-2*0.5*x));
		case 'lineal'
			o = x;
		otherwise
			disp('Invalid g function');
	end
end