# SIA-TPE2

Para leer los archivos csv de pesos fijos:
Entrar a octave, correr la siguiente linea

x = csvread(filename)

donde por ejemplo filename es 'W\_1\_neurons\_1\_15.csv'
con las comillas incluidas.
Asi se obtiene x, que es la matriz de pesos.

Los nombres de los archivos csv indican a que porcion
de los pesos corresponden, si es W\_1 significa desde
el input hasta la primer capa oculta, y asi siguiendo.
Despues tienen la palabra neurons, y despues sigue
la cantidad de neuronas de la capa de abajo, seguido
de la cantidad de nueronas de la capa de arriba.

##Instrucciones para correr con una capa oculta##
En octave, si no existen los archivos de la cantidad de
neuronas que se quiere, generarlos:
weight1 = weightGenerator(inputAmount, outputAmount);
weight2 = weightGenerator(inputAmount, outputAmount);
Por ejemplo, para 15 neuronas en la capa oculta:
weight1 = weightGenerator(1, 15);
weight2 = weightGenerator(15, 1);

Si se quiere guardarlos:
csvwrite('W_1_neurons_1_15.csv',weight1);
csvwrite('W_2_neurons_15_1.csv',weight2);

Asignarlos a una celda
A{1} = weight1;
A{2} = weight2;

Correr la funcion trainNet para entrenar la red con esos pesos
[W] = trainNet(A, trainingAmount, hiddenAmount, maxIt, ETol, gName, saturationControl, hasAdaptativeEta, hasMomentum, a_etha, b_etha)
donde A es la celda anterior,
trainingAmount es la cantidad de puntos deseados en el conjunto de entrenamiento,
hiddenAmount la cantidad de capas ocultas,
maxIt la maxima cantidad de iteraciones que se quiere correr en caso de que el error no baje a valores cercanos a cero,
ETol el error de tolerancia por el cual la función retornará cuando llegue a ese valor,
gName el nombre de la función de activación que se quiere usar, puede ser 'exponencial' o 'tangente',
saturationControl, si se quiere activar el control de saturación se debe poner un número distinto de -1 que represente cada cuantas épocas se checkea que no haya saturación, si no se quiere se debe poner -1,
hasAdaptativeEta, si se quiere que el algoritmo use eta adaptativo poner un número distinto de -1,
hasMomentum, si se quiere que el algoritmo use momentum poner un número distinto de -1,
a_etha, el número que se le suma a eta cuando el error disminuye,
b_etha, el número al cual se multiplica por eta cuando el error aumenta.

Esta función devuelve [W], siendo W los pesos que quedan en la red luego de ser entrenada.

Si se quiere probar esa red con esos pesos, hay que primero generar el conjunto de testeo de la siguiente manera:
[tests, expected_test] = generateTestFunction(amount);
siendo amount la cantidad de elementos que se quieren en el conjunto.
Despues correr la funcion testNet
[Out] = testNet(W, tests, expected_test, gName, hiddenAmount)
Siendo W, el W obtenido anteriormente, tests y expected_test lo generado anteriormente, gName debe ser el mismo nombre que utilizó para entrenar la red, y hiddenAmount la misma cantidad de capas ocultas que se usó para entrenar la red.

