function ret=generateWeightMatrix(matrix1, matrix2)
	for i=1:size(matrix1,1)
		ret(i,1)=(matrix1(i,1)+matrix2(i,1))/2;
	end
end