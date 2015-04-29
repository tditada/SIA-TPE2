function o = gDerivated(gName, x)
	switch gName
		case 'sigmodea'
			o = 0.5*(1-(tanh(0.5*x)^2));
        case 'lineal'
            o = 1;
		otherwise
			disp('not a valid function');
	end
end