function o = g(gName, x, threshold)
	switch gName
		case 'step'
			o = stepFunction(x, threshold);
			break;
		case 'sigmodea'
			break;
		case 'logic'
			break;
		otherwise
			disp('not a valid function');
	end
end