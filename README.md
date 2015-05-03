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
