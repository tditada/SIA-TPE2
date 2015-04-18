function ret=scalarSum(val, pes)
	ret=0;
	n = size(val,2);
	for i = 1:n
		ret = ret + val(i)*pes(i);
	end
end