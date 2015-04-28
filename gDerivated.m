function o = gDerivated(gName, x)
	switch gName
		case 'sigmodea'
			o = 0.5*(1-(tanh(0.5*x)^2));
		otherwise
			disp('Invalid gDerivated function');
	end
end