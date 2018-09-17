########################################################
# Una primera sesion de R
########################################################

# El "#" indica que lo que viene es un comentario


#################################
# R como calculadora
#################################

# Calcule 2 + 3




# Calcule la raiz cuadrada de 10




# Calcule el perimetro del circulo de radio 5




# Calcule 270 dividido la suma entre 12 y 78




# Calcule el cuadrado de 8



# Calcule el logaritmo de 10



## Obtener ayuda

?log
help("log")

log(10, base = 10)

log(10,10)

log10(10)




###############################
# Asignaciones
###############################

radio <- 5     # asignamos el numero 5 al objeto "radio"
radio          # vemos su valor
print(radio)   # otra forma de ver su valor


## Otras formas de hacer asignaciones

radio = 5      # es mas conveniente utilizar <-
radio
5 -> radio     # raramente se usa asi
radio

# Podemos operar con los objetos y crear objetos que contengan los resultados
# de un calculo (o de un analisis estadistico)

# Ejemplo: Calcule el perimetro del circulo de radio 5 y guardelo en el objeto "per"





## Asignamos un vector a un objeto

a <- c(1,2,3,4,5)


# Podemos ver el contenido de "a"




## Aritmetica vectorial

# Creamos el vector de coordenadas 6,7,8,9,10 y lo llamamos "b"



# Suma de dos vectores. Calcule la suma de a y b



# Producto de un escalar por un vector. Calcule el doble de a




## ¿Que se obtiene haciendo el siguiente producto entre los vectores a y b?

a*b




######################################
# R como herramienta estadística
######################################


## Queremos generar 40 numeros aleatorios de una
# distribucion normal estandar

help("normal") # no funciona!
?normal
??normal

help.search("normal")
apropos("normal")
apropos("norm")

#  MUY UTIL: GOOGLE!!!!
# "R: normal random number generator"

# generamos un vector de tamaño 40 de esta distribucion



## Algunas medidas descriptivas basicas

mean(x); sd(x); var(x)

summary(x)

# Genere un vector "y" con 20 realizaciones de una normal con media 5 y
# desvio estandar 2. Calcule la media y la varianza de y




#####################################
# R como herramienta grafica
#####################################

# Ejemplos

hist(x)

boxplot(x)


## La funcion "plot"

x <- c(-4,-3,-2,-1,0,1,2,3,4)  # Observar que hemos reemplazado el objeto "x"
# que definimos arriba
y <- x^2

plot(x,y)

plot(x,y, type="b", col="red")





#################################
# Objetos - Clases
#################################

a <- 4  # asignamos el numero 4 al objeto "a"

class(a)


b <- c(1,2,3)  # asignamos un vector (numerico) al objeto "b"

class(b)
str(b)

calle1 <- "Rafael Nuñez"

# ¿Que tipo de objeto es calle1?



# Formermos el vector calles, agregando a calle1 la calle "Octavio Pinto"



## ¿Es calles un objeto de tipo numerico?
is.numeric(calles)        # da como resultado TRUE (si el objeto es de tipo numerico)
# o FALSE (si no lo es)

# ¿Es de tipo "character"?




## La clase "logical"
# Un objeto en esta clase toma valores TRUE (cuando una condicion es verdadera)
# o FALSE (cuando la condicion es falsa)

a <- c(1,2,3)
b <- c(2,1,3)

r <- a < b
r

class(r)

# Operadores logicos

# ¿Que hacen los operadores "==", "!=", ">="



# Hay otros: "&" y "|"


## Existe tambien la clase "factor":
# variable categorica con un numero finito de categorias/niveles,
# que R "reconoce", "guarda" y "sabe" trabajar

a <- c("A", "A", "B", "A", "B")

class(a)
levels(a)   # funcion que muestra los niveles de un factor

is.factor(a)
a <- as.factor(a)    # tambien podemos definirlo con otro nombre
a

# ¿De que clase es ahora "a"?



# Ahora veamos cuales son los niveles (categorías) de "a"



# Calculemos el numero de observaciones en cada nivel, usando la funcion "table"




### Datos faltantes

## "NA" nos permite indicar que falta un dato

z <- c(1,2,3,NA,4)

# Calcular la media de los valores en z



# ¿Que hace la funcion "is.na()"?




## Otro tipo de datos que se consideran "NA" son los "NaN" (Not a Number)

a <- 0/0   # Estos no son valores faltantes sino indeterminaciones
a
is.nan(a)
is.na(a)

is.nan(z)

is.na(Inf - Inf)
is.nan(Inf - Inf)




### Tipos de objetos

# Vectores: Coleccion ordenada de elementos del MISMO tipo.


# Arreglos (?array): Generalizacion de vectores a mas dimensiones,
# por ejemplo, matrices (?matrix).


# Hojas de datos (?data.frame): Como las matrices, pero con columnas de diferentes
# tipos. Es el objeto más habitual para los datos experimentales.


# Listas (?list):  Forma generalizada de vector en la que cada componente puede ser
# de distinto tipo (numero, vector, matriz, LISTA, etc...).
# Son contenedores generales de datos. Muy flexibles, pero sin estructura.
# Muchas funciones devuelven un conjunto de resultados de distinta longitud y
# distinto tipo en forma de lista.


# Funciones (help("function"))



## Si queremos ver cuales son los objetos del espacio de trabajo

ls()
objects()

## Podemos borrar todos los objetos del espacio de trabajo

rm(list = ls())

# o algunos. Por ejemplo, x e y



################################################
#  No nos olvidemos de guardar el script      ##
#  y la sesion, o los objetos que queramos  ##
################################################

## Cambiar de directorio

setwd("C:/")  # Tambien puede hacerse desde el menu (Session -> Set working directory)


## Guardar todo el espacio de trabajo:

save.image("primera_sesion.RData")  # ¿Como lo hacemos desde el menu?


## Guardar solo algunos objetos

save(a, b, r, file = "prim_ses.RData")


## Podemos cargar un espacio de trabajo

load("prim_ses.RData")            # ¿Como lo hacemos desde el menu?
