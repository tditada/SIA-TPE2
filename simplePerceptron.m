function ret=simplePerceptron(n)

disp('Entrando al perceptron simple');
tasa= 0.5;
weight=zeros(1,n + 1);
for i = 1:n + 1
    weight(i) = 2*rand() - 1;
end
[training, V] = generateTrainingAnd(n);
training = [-1 * ones(size(training,1),1) training];
while 1
    count = 0;
    for i=1:size(training,1)
        sum= training(i,:)*weight';
        if (sum > 0)
            ret=1;
        else
            ret=0;
        end
        error = V(i)-ret;
        if(error~=0)
            count = count + 1;
            for z=1:n + 1
                weight(z) = weight(z)+ tasa*error*training(i,z);
            end
        end
    end
    if (count == 0)
        break;
    end
    if (tasa > 0.05)
        tasa = tasa - 0.05;
    elseif (tasa < 0.05)
        tasa = 0.01;
    end
end

ret = weight;

end