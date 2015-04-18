function ret=simplePerceptronMatrix(n)

    disp('Entrando al perceptron simple');
    threshold=0.5;
    learning_rate= 0.05;
    weight=zeros(n,1); %PREGUNTAR RANGO
    g_ret=zeros(2^n,1);
    [training, expected] = generateTrainingAnd(n);

    while 1
        for j=1:size(weight,1)
            disp(weight(j));
        end
        weighted_sum=training*weight;
        for i=1:2^n
            g_ret(i,1)=stepFunction(weighted_sum(i,1),threshold);
        end
        errors=expected-g_ret;
        if(sum(errors)!=0)
            for i=1:2^n %fila del training
                aux=weight;
                for z=1:n %fila del weight
                   aux(z,1) = aux(z,1)+ learning_rate*errors(i,1)*training(i,z);
                end
                weight=generateWeightMatrix(weight,aux);
            end
        else
            break;
        endif
    end
end