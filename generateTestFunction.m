function [tests, expected] = generateTestFunction(amount)
	tests= transpose(linspace(-1,1,amount));
	expected = TPfunction(tests);
end