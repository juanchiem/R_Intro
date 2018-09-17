
#########################
#VECTORES               #
#########################

# Vector: coleccion ordenada de elementos del MISMO tipo

## Ejemplos


x <- c(1, 2, 3)               #numerico

a <- c(-1,5,9,10.5)           #numerico

y <- c("a", "b", "c")         #de caracteres

z <- c(TRUE, TRUE, FALSE)     #logico



## "c()" concatena vectores:

# Genere un vector "b" que una "x" y "a"



# ?Cuantos elementos tiene el vector b?



## Generando secuencias

x <- c(1, 2, 3, 4, 5)  # ya lo conocemos
x <- 1:10
y <- -5:3

# Genere la secuencia 8,7,6,5,4



## ?Y si queremos la secuencia 4,6,8,... hasta 20?

seq(from = 4, to = 20, by = 2)

# o

seq(4,20,2)   # ?Por que funciona este comando?


# Genere usando comandos para secuencias el vector de componentes
# 1, 2, 3, 4, 5, 6, 73, 72, 71, 70, 69, 68, 3, 6, 9, 12, 15, 18


## Vectores con valores repetidos

rep(1, 5)
x <- 1:3
rep(x, 2)
rep(x, c(2,4,1))
rep(x, length = 8)

# Genere el vector de componentes
# "azul", "azul","azul", "azul", "amarillo", "amarillo", "verde", "verde","verde"
# Guardelo con el nombre "col"


# ?Es un factor?


## Recordemos que podemos convertir cualquier vector en factor:

fcol1 <- as.factor(col)


## Otra forma de  generar factores:

gl(3, 5)
gl(3, 5, length = 30)
gl(3, 5, labels = c("grupo A", "grupo B", "grupo C"))


# Genere un factor con elementos
# 1,1,1,2,2,2,3,3,3,4,4,4,1,1,1,2,2,2,3,3,3,4,4,4,1,1,1,2,2,2,3,3,3,4,4,4



#################
## Seleccion de elementos de un vector

x <- c(3,52,-8,2,1,7,11,-3,0,6,23,17)
x[1]
x[3]
x[c(1, 3)]

# Seleccione los primeros 8 elementos de x



# ?Y si queremos sustituir un elemento del vector?
## sustituya el tercer elemento de x por 88


x[3] <-  88
x

## ?Y si queremos suprimir coordenadas?

x[-3]

# Suprima la primera y la cuarta coordenada del vector x



## ?Y si queremos ordenar el vector?

sort(x)

# ?Y si lo queremos ordenado de mayor a menor?



# ?Que hace la funcion "order"?



## Podemos pedirle la edad minima

min(x)
which.min(x)                  # ?Que obtenemos con este comando?

# ?Y la edad maxima?



###############################
#        MATRICES             #
###############################


## Queremos generar una matriz 5x4 con estos datos ("matrix"):

x <- 1:20

A <- matrix(x, nrow = 5, ncol = 4)                  # ? Que obtenemos?


# ?Y si la quiero llenar por filas?

?matrix




## Algunas medidas resumen para matrices:


summary(A)
mean(A)
sd(A)


## Coordenadas de la matriz

# Podemos obtener los elementos de una matriz como con los vectores:

A[1,2]                   # el primer lugar indica la fila y el segundo, la columna


## En general, ?como elegimos una fila o columna de la matriz?

## Extraiga la columna 4

A[,4]


# Extraiga la fila 5



# Extraiga la matriz formada por las columnas 1 y 2




# Extraiga la matriz formada por las columnas 1 y 3 y las filas 2, 3, 5




# Si queremos calcular la media para una sola columna?

# Calcule la media de la primer columna de A




# Calcule la varianza de la tercera fila de A




## Si queremos un vector con las medias de todas las columnas?
# Funcion "apply"

apply(A, 2, mean)



# calcule la suma de las filas de A:




## Para formar matrices combinando vectores utilizamos
## las funciones "rbind" y "cbind".

x <- seq(5, 10, by = 0.5)
y <- 11:21

W <- rbind(x, y)
Z <- cbind(x, y)


## "cbind" y "rbind" funcionan para matrices tambien:

A1 <- matrix(0, 2, 2)
A2 <- matrix(4:6, 2, 3)
A3 <- matrix(c(8, -2, 0, -1, 5, 6), 3, 2)


# Realice algunas combinaciones







## Podemos dar nombre a las filas y columnas.

## Ejemplo: Los siguientes resultados fueron obtenidos durante un
# estudio sobre la concentracion de zinc (ppm) en muestras de distintas zonas
# de un lago.

#        fondo superficie
# Norte   0.43       0.42
# Sur     0.27       0.24
# Este    0.57       0.39
# Oeste   0.53       0.41
# Centro  0.70       0.61

# ?Como generamos esa matriz?

x <-


  zinc <-


  ## Nos faltan los nombres

  zonas <- c("Norte", "Sur", "Este", "Oeste", "Centro")
variables <- c("fondo", "superficie")

# "rownames" y "colnames"

zinc <- matrix(x, nrow = 5)
rownames(zinc) <- zonas
colnames(zinc) <- variables
zinc

## Tambien se puede crear directamente la matriz con nombres:

zinc <- matrix(x, nrow = 5, dimnames = list(zonas, variables))


# Seleccione los valores de concentracion de zinc en:
# - zona sur
# - fondo
# - zona sur y fondo








# Guardemos esta matriz en el archivo "lago.RData"

save(zinc,file="lago.RData")

############################################
#        HOJAS DE DATOS (DATA FRAMES)      #
############################################

## Que pasa si los datos que tenemos son de distinto tipo?
# (variables continuas y categoricas, por ejemplo)

# Las hojas de datos ("data.frames") son la forma mas usual para almacenar
# los datos experimentales.

# Pueden pensarse como matrices donde las columnas son de diferentes clases.


x1 <- 1:10
x2 <- 24:33
x3 <- gl(2, 5, labels = c("si","no"))
x4 <-letters[1:10]


# Consideremos una matriz X cuyas columnas sean x1, x2 y X3.
# Y una matriz Y cuyas columnas sean x1, x2, x3 y x4.

X <- cbind(x1, x2, x3)
Y <- cbind(x1, x2, x3, x4)


# De que tipo es cada columna de X y de Y? Es eso lo que queriamos?




## Lo adecuado es utilizar la funcion "data.frame"

Z <- data.frame(x1, x2, x3, x4)


## o, asignando otros nombres a las columnas:

Z <- data.frame(A = x1, B = x2, C = x3, D = x4)
Z

# Podemos convertir una matriz con datos numericos en una hoja de datos.
# Carguemos el archivo "lago.RData"

load("lago.RData")
zinc

# Convierta la matriz zinc en un data frame, usando el comando "as.data.frame".
# Llamelo zinc.df





## Tambien podemos a??adir alguna columna a un data frame:

especialista <- c("Toledo", "Toledo", "Toledo", "Buteler", "Buteler")
zinc.df <- data.frame(zinc.df, especialista)


## Operador $

## Es facil acceder y crear nuevas columnas con el operador "$" cuando estas
# tienen nombre

zinc.df$fondo

zinc.df$fecha <- factor(c(1,2,1,2,1),labels=c("marzo","abril"))


# Tambien puede usarse la notacion matricial para extraer filas y columnas
# Extraiga la columna 2




# Extraiga los datos de zona Este

zinc.df["Este",]


# Que informacion nos da "str" y "summary" de un data frame?




# Le dijimos que "especialista" era factor?

class(especialista)
class(zinc.df$especialista)


# "data.frame" convierte los vectores de caracteres en factores automaticamente.




###############################################################################################
# ##  Operaciones con matrices:
#
# # Operaciones con matrices
#
# # A %*% B : producto de matrices
# # t(A) : traspuesta de la matriz A
# # solve(A) : inversa de la matriz A
# # solve(A,b) : soluci??n del sistema de ecuaciones  Ax=b.
# # svd(A) : descomposici??n en valores singulares
# # qr(A) : descomposici??n QR
# # eigen(A) : valores y vectores propios
# # diag(b) : matriz diagonal.  b  es un vector)
# # diag(A) : matriz diagonal. A  es una matriz)
# # A %o% B == outer(A,B) : producto exterior de dos vectores o matrices
# # outer(X, Y, FUN = "*", ...) proporciona de forma predifinda el producto exterior de los dos arrays.
# # Sin embargo, podemos introducir otras funciones e incluso nuestras propias funciones en el argumento FUN.
#
# ##  Ejemplo:
# # calcule la inversa y los autovalores y autovectores de A
# A  =  matrix(c(1,3,3,9,5,9,3,5,6), nrow = 3)
#
#
# ?zapsmall
#
#
#
#
#
# ######################################
# #         ARREGLOS                   #
# ######################################
#
# ## Otra forma de generar matrices:
#
# # Las matrices son arreglos ("array") de dimension 2
#
#
# ## Supongamos que queremos generar una matriz 3x6 con los elementos del
# # vector b
#
#
# b <- seq(-2, by = 2, length.out = 18)
#
# B1 <- array(b, dim = c(3,6))
#
#
# ## Pero "array" nos permite tener arreglos de mas dimensiones.
#
# ## Consideremos un arreglo de 3 dimensiones
#
# D <- array(1:24, c(3,4,2))
#
#
# # ?Como seleccionamos los elementos de un arreglo?
#
# # Seleccione el numero 1
#
#
# # Seleccione el numero 13
#
#
#
# # Seleccione el numero 15
#
#
#
# ## Tambien podemos considerar subconjuntos de un array
#
# D[, , 1]  # es un array de dimension c(3,4)
#
#
#
# ## Funcion "attach"
# # Sirve cuando vamos a trabajar con un conjunto de datos y queremos escribir menos!
# # Permite que las columnas dentro de un data frame puedan tratarse temporalmente
# # como variables con ese nombre.
# # Los objetos con el mismo nombre de alguna columna NO son reemplazados.
#
# fondo
#
# zinc.df$fondo
#
# attach(zinc.df)
#
# fondo
#
# # Calcule la concentracion media de zinc en los valores de la superficie
#
#
#
# # Para desconectar una hoja de datos, use "detach"
#
# detach(zinc.df)
# fondo
# superficie
# fecha
# especialista
