function ret=simplePerceptron(n)

disp('Entrando al perceptron simple');
umbral=0.5;
tasa= 0.05;
weight=zeros(1,n); %hacer aleatorio
[training, V] = generateTrainingAnd(n);

while 1
    count = 0;
%     for j=1:n
%         disp(weight(j));
%     end
    for i=1:size(training,1)
        sum= training(i,:)*weight';
%         disp('sum y V')
%         disp(sum)
%         disp(V(i))
        if (sum > umbral)
            ret=1;
        else
            ret=0;
        end
        error = V(i)-ret;
        if(error~=0)
            count = count + 1;
            for z=1:n
                weight(z) = weight(z)+ tasa*error*training(i,z);
            end
        end
    end
    if (count == 0)
        break;
    end
end

ret = weight;

end