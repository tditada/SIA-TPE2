function ret=simplePerceptron()

disp('Entrando al perceptron simple');
umbral=0.5;
tasa= 0.1;
weight=zeros(1,2); %hacer aleatorio
%training=[[0,0,0];[0,1,0];[1,0,0];[1,1,1]];
[training, V] =generateTrainingAnd(2);

while 1
    count = 0;
    for i=1:size(training,1)
        for j=1:size(weight,2)
            disp(weight(j));
        end
        n=size(training,2);
        sum= training(i,1:n)*weight';
        if (sum > umbral)
            ret=1;
        else
            ret=0;
        end
        error = V(i)-ret;
        if(error~=0)
            count = count + 1;
            for z=1:size(weight,2)
                weight(z) = weight(z)+ tasa*error*training(i,z);
            end
        end
    end
    if (count == 0)
        break;
    end
end

end