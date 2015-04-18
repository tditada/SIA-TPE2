function ret=simplePerceptron(n)

disp('Entrando al perceptron simple');
threshold=0.5;
learning_rate= 0.1;
weight=zeros(n,1); %PREGUNTAR RANGO
[training, expected] =generateTrainingAnd(n);

while 1
    count = 0;
    for i=1:size(training,1)
        for j=1:size(weight,2)
            disp(weight(j));
        end
        sum= training(i,1:2^n)*transpose(weight);
        if (sum > threshold)
            ret=1;
        else
            ret=0;
        end
        error = V(i)-ret;
        if(error~=0)
            count = count + 1;
            for z=1:size(weight,2)
                weight(z) = weight(z)+ learning_rate*error*training(i,z);
            end
        end
    end
    if (count == 0)
        break;
    end
end

end