function o = g(gName, x, threshold)
	switch gName
		case 'step'
			o = stepFunction(x, threshold);
			break;
		case 'sigmodea'
			o = tanh(0.5*x);
			break;
		case 'lineal'
			break;
		otherwise
			disp('not a valid function');
	end
end