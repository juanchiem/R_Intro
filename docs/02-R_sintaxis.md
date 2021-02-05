# Sintaxis básica

La sintaxis en R es muy similar a la de otros lenguajes de programación como JAVA o C. Las normas básicas que definen la sintaxis de R son:

- No se tienen en cuenta los espacios en blanco: podemos o no dejar espacios para que el código se pueda ordenar de forma adecuada y poder entenderse.


```r
plot(pressur e)
plot( pressure )
```

- Se distinguen las mayúsculas y minúsculas (“case sensitive”): para variables en el código, podemos crear diferentes variables con nombres iguales pero alternando mayúsculas y minúsculas.


```r
LETTERS
letters
```

- Se pueden incluir comentarios: como vimos anteriormente los comentarios se utilizan para añadir información en el código.


```r
plot(pressur e) # da error

# grafico press vs temp
plot(pressure)

plot(pressure, # grafico press vs temp
     pch = 19, # cambio el tipo de puntos vacios a puntos llenos 
     col= "blue" # uso color azul para rellenarlos  
     )
```

- No es necesario terminar cada sentencia con el carácter de punto y coma (;): en la mayoría de lenguajes de programación, es obligatorio terminar cada sentencia con este carácter. En cambio, en R podemos o no terminar de esta forma.


```r
pressure; plot(pressure)
```

## R calculadora {#calc}

Ver [tablas resumen](#tablas_resumen) de operadores aritméticos y lógicos (al final del capítulo) 


```r
4 + 9
4 - 
  3 *
  1
# 4%1
4>3
4 == 3
4 == 4

(4 + 5 ) * 7 - (36/18)^3
```
(Recordando de la primaria el orden de las operaciones: 
paréntesis < exponentes (potencia o raiz) < productos/división < suma/resta)

> Ej 1: ¿Está bien la siguiente expresión? `5 + 3 * 10 %/% 3 == 15` 
Agregue paréntesis para que la expresión dé un resultado contrario.

</br>

<div class="rmdnote">
<p><strong>Rendimiento de trigo en función de la severidad de fusariosis de la espiga</strong> <span class="citation">[@madden2009assessing]</span></p>
<p>El intercepto de la regresión lineal estimada (rendimiento de trigo primaveral libre de enfermedad) fue de 4.10 t/ha, y la pendiente fue de 0.038 t/ha por unidad de aumento de la severidad de la enfermedad. El tipo de trigo tuvo efecto significativo en el intercepto pero no en la pendiente: trigo inviernal tuvo, en promedio, 0.85 t/ha mas rendimiento que el trigo primaveral.</p>
</div>

> ¿Cuánto sería el rendimiento de ambas variedades de trigo con 0, 1, 10 o 20% de severidad de la enfermedad?


```r
rto_prim_sev <-
rto_prim_0 <-

rto_inv_sev <-
rto_inv_0 <-
```



</br>

Algunos cálculos


```r
sqrt(3) # 3^0.5
2^(1/3) # ^(1/n)

log(10)
log(10, base=10)

round(4.3478, digits=3)  # ceiling(4.3478) floor(4.3478)
```

> que pasa cuando redondeamos a 0 digitos 4.5 y 3.5?


```r
# Ej 1: 5 + (3 * 10) %/% 3 == 15

# Ej 2: 4.1 - 0.038 * 10; (1-(3.72/4.1))*100
```

## Funciones 

Una función es un conjunto de sentencias organizadas conjuntamente para realizar una tarea específica. Los paquetes son básicamente un set de funciones generadas por los autores de los mismos pero el usuario puede crear sus propias funciones. La sintaxis básica de una función de R es la siguiente:


```r
nombre_funcion <- function(arg_1, arg_2, ...) {
   cuerpo_de_la_función
  
   output # return()
}
```

Las diferentes partes de una función son:

* Nombre de la función: este es el nombre real de la función. Se almacena en el entorno R como un objeto con este nombre. Generalmente, el nombre es intuitivo, por ejemplo, `mean` es la función que calcula la media, `round` es la funión que redondea un número. 

* Argumentos: Un argumento es un marcador de posición. Cuando se invoca una función, se pasa un valor al argumento. Los argumentos son opcionales; es decir, una función puede no contener argumentos. También los argumentos pueden tener valores por defecto.

* Cuerpo de la función: el cuerpo de la función contiene una colección de sentencias que definen lo que hace la función.

* Valor de retorno: el valor de retorno de una función es la última expresión en el cuerpo de la función que se va a evaluar.


```r
numb <- 1:6
round(mean(numb)) # floor() # ceiling() trunc() 
```

Si es necesario, el usuario puede generar sus propias funciones. 

> Al reportar los resultados de los tests de comparaciones de medias obtenidas luego del análisis de varianza es interesante agregar en los párrafos de los resultados cuánto se incrementó o se redujo  un tratamiento en referencia a un testigo en términos porcentuales. Genere una función que permita realizar estos cálculos. Tome como ayuda este [link](https://www.calculatorsoup.com/calculators/algebra/percent-change-calculator.php) para cotejar sus resultados.  


```r
perc_change <- function(v1, v2) 
{
  pc <- (v2-v1)/v1 *100
  return(paste(pc, "%"))
}

perc_change(80, 90)
```

> es lo mismo aumentar de 0.5 a 1 que de 1 a 1.5?

> cuánto es la diferencia porcentual de tener 20% de fusarium en un trigo primaveral en relación a uno invernal?

Claro que en la inmensa comunidad de usuario de R, ya hubo alguien que incluyó esa función en un paquete... 


```r
#percentua relative differences 
quantmod::Delt(80,90)*100
80+(80*0.125)
quantmod::Delt(90,80)*100
90+(-90*0.1111111) 
```

Otro ejemplo de la utilidad de estas funciones "user-defined" es la preparación de soluciones partiendo de un stock o fuente a diluir, usando la equivalencia:

$$c1 * v1 = c2 * v2$$

Obviamente tanto $c1;c2$, como $v1;v2$, están en las mismas unidades. Para nuestra comodidad $c=\%$ y $v=ml$. 

> Nos indican que preparemos 500 ml de una solución desinfectante de NaOCl al 5%, partiendo de una lavandina concentrada (55 g Cl/L). La pregunta que del millón es: ¿qué volumen de lavandina preciso? Por lo tanto debemos despejar *V1* de la equivalencia, o sea, sería nuestro output de nuestra función. 

Empecemos los cálculos: 

1. Si el NaOCl tiene un peso molecular de 74.5 g y el Cl pesa 35.5 g, este representa el *47.6%* de la molécula de NaOCl. Por lo tanto podemos decir que la lavandina comercial posee x NaOCl = Cl/0.476 en 1 L, o bien x NaOCl % = x NaoCl/10

2. Si deseamos preparar 500 ml de NaOCl al 5% para la desinfección (2.5% de Cl activo, aprox.) debemos obtener:
$$v1 = (c2*v2)/c1$$


```r
vol_lavandina  <- function(c1, c2, v2){
  c1 <- (c1/0.476)/10 # pasar g/L a %
  c2 <- c2            # concentración que me pide el protocolo (%)
  v2 <- v2            # volumen de la solución que deseo (ml)
  v1 <- (c2*v2)/c1    # aliquota que debo usar
  
  return(paste("Coloque", 
               round(v1,1), 
               "ml de lavandina y enrase con agua hasta completar", 
               v2, "ml"))
}
```


```r
vol_lavandina(55, # g cloro / L (Lavandina)
          5, # % ClONa deseada
          500) # ml de la solución deseada
```

```
#> [1] "Coloque 216.4 ml de lavandina y enrase con agua hasta completar 500 ml"
```

> Ej: Generar funciones que automaticen los cálculos de:</br>
i) Pasar un muestreo de espigas/m a kg/ha (inputs: metros muestreados, ancho de hileras, espigas obtenidas, peso seco medio de espiga)</br>
ii) Rendimiento de soja ajustado 13,5% humedad (inputs: tamaño de parcela; kg de soja; humedad)</br>
iii) Grados celsius a fahrenheit </br> 
iv) Cálculo de dosis de urea a fertilizar en un trigo al macollaje (inputs: N disponible, rinde objetivo, N/Ton de grano, % de N en fertilizante) </br>
v) cálculo de kg de semilla a sembrar (inputs: densidad objetivo; P1000; PG%) 


## Tablas resumen {#tablas_resumen}



<table class="table" style="font-size: 15px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:op-arit)Operadores aritméticos</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Operador </th>
   <th style="text-align:left;"> Detalle </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> `x + y` </td>
   <td style="text-align:left;"> Suma de x e y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x - y` </td>
   <td style="text-align:left;"> Resta de x menos y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x * y` </td>
   <td style="text-align:left;"> Multiplicación </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x / y` </td>
   <td style="text-align:left;"> División de x por y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x %/% y` </td>
   <td style="text-align:left;"> Parte entera de la división de x por y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x %% y` </td>
   <td style="text-align:left;"> Resto de la división de x por y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x ^ y` </td>
   <td style="text-align:left;"> x elevado a y-ésima potencia (equivalente a **) </td>
  </tr>
</tbody>
</table>

<br><br>




<table class="table" style="font-size: 15px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:op-logi)Operadores lógicos</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Operador </th>
   <th style="text-align:left;"> Prueba.lógica </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> x &lt; y </td>
   <td style="text-align:left;"> x menor que y? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x &lt;= y </td>
   <td style="text-align:left;"> x menor o igual que y? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x &gt; y </td>
   <td style="text-align:left;"> x mayor que y? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x &gt;= y </td>
   <td style="text-align:left;"> x mayor o igual que y? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x == y </td>
   <td style="text-align:left;"> x igual que y? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x != y </td>
   <td style="text-align:left;"> x diferente que y? </td>
  </tr>
</tbody>
</table>

<br>
<br>




<table class="table" style="font-size: 15px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:matem)Funciones matemáticas</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Operador </th>
   <th style="text-align:left;"> Detalle </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> `sqrt(x)` </td>
   <td style="text-align:left;"> raiz de x </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `exp(y)` </td>
   <td style="text-align:left;"> exponencial de y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `log(x)` </td>
   <td style="text-align:left;"> logaritmo natural de x = ln </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `log10(x)` </td>
   <td style="text-align:left;"> logaritmo base 10 de x </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `sum(x)` </td>
   <td style="text-align:left;"> suma todos los elementos de x </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `prod(x)` </td>
   <td style="text-align:left;"> producto de todos los elementos de x </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `round(x, n)` </td>
   <td style="text-align:left;"> redondea x a n-digitos </td>
  </tr>
</tbody>
</table>

<br>
<br>



* Más [hotkeys]("https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts")

<table class="table" style="font-size: 15px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:shortcuts)Algunos atajos comúnmente usados</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Teclas </th>
   <th style="text-align:left;"> Detalle </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Alt+Shift+K </td>
   <td style="text-align:left;"> panel de todos los atajos </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+Z / Ctrl+Shift+Z </td>
   <td style="text-align:left;"> undo/redo </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Alt+ - </td>
   <td style="text-align:left;"> &lt;- </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+r </td>
   <td style="text-align:left;"> corre la línea/bloque completa de código </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+l </td>
   <td style="text-align:left;"> limpia la consola </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+Shift+c </td>
   <td style="text-align:left;"> silencia la línea de código </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+Shift+d </td>
   <td style="text-align:left;"> duplica la línea de código </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+i </td>
   <td style="text-align:left;"> indexa el bloque de código </td>
  </tr>
</tbody>
</table>

