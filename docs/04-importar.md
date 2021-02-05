# Importación de datos {#import}

Luego del planteo de hipótesis y planificación experimental, la toma de datos es una etapa determinante para el resto del flujo de trabajo. Un buen diseño experimental, con correcta toma de datos de calidad, no garantizan, pero sí aumentan significativamente las probabilidades que nuestro trabajo goce de buen porvenir. 

Conocer las distintas etapas del workflow de investigación confiere la gran ventaja de poder pensar nuestras acciones como parte de un todo, y no como algo aislado. Por ejemplo, una planilla de campo de papel de formato apaisado ("wide") puede que aún no esté lista para ser analizada, pero este formato confiere ciertas ventajas prácticas (confección de planilla de papel, control interno de las evaluaciones, pasaje a planilla electrónica). Por lo tanto en una siguiente etapa luego de la importación al entorno de nuestra sesión, puede que necesitemos re-estructurarla y asi poder continuar hacia la exploración. 

Podemos tomar esta [planilla modelo](https://docs.google.com/spreadsheets/d/1cyn8WLKgaQWpOkc9YG_YpSEOgGTmKIg8W7GQwsLBnK8/edit?ouid=111258596380074362084&usp=sheets_home&ths=true), para entender cómo es una planilla para ser analizada en R.

Veamos **4 Principios básicos** de buenas prácticas en la elaboración de planillas de datos - Adaptado de [@broman2018data]

Como regla global, y siguiendo lo ya comentado en la sección de [data frames](#data_frames), columnas (verticales) son **variables** y filas (horizontales) son **observaciones** (generalmente de unidades experimentales/sujetos individuales).

**1 - Consistencia**

Sean creativos al nombrar las variables: usen 3-4 letras (minúsculas) por palabra y en caso de necesitar usar “_”. No usar acentos ni ñ. Nunca dejen espacios y maximicen el ahorro de letras, siempre y cuando se justifique:

  * severidad = sev
  * incidencia = inc
  * rendimiento = rto 
  * hoja = hj (bien podría ser “hoja” también)
  * planta = pl
  * bloque = bq
  * placa = placa 
  * temperatura = temp
  * máxima = max

En particular prefiero usar el inglés, ya que no tiene acentos ni caracteres especiales. 
Siempre, siempre, identifiquen hasta el más mínimo detalle de las unidades experimentales (placas, macetas, plantas dentro de las macetas, etc.), al final se recuperará en creces el tiempo extra inicialmente invertido en ello (stand-alone).

* Adopten siempre los mismos términos

* No escatimen en columnas: rep_pl -> rep | pl

* Crear diccionario de términos: Agreguen una planilla con el detalle por extenso de las variables y sus unidades. Piensen que esa planilla la debería entender cualquier persona sin auxilio de sus propios comentarios. 


**2 - Rectangular**

Todo set de datos tiene sus dimensiones específicas: n filas - n columnas. 
Si se perdió alguna parcela/planta por algún motivo extra-tratamiento simplemente es un NA, y así deben definir esa observación, no poner “muerta” o “perdida”. 

**3 - Cero es un dato!** 

Cero no significa ausencia de observación, en este caso podemos usar “NA”, “-”, “.”  o dejar en blanco (si se usa .xlsx)
En preferencia, llenen todas las celdas, pero siempre un solo dato por celda... 

**4 - Planilla plana -> DATOS CRUDOS**

* SIN FÓRMULAS 
* no combinar celdas
* no resaltar
* no hacer bordes 
* sin negritas
* caracteres puros

## Vías de importación 

Son múltiples las necesidades y vías de importación de datos a nuestro entorno de sesión de R.

Principalmente usaremos planillas Excel guardados en nuestra computadora. Estos pueden estar guardados en formato .xlsx (planillas tradicionales) o .csv (texto separado con comas, mucho más livianos). 

- Importamos los datos del curso:


```r
usethis::use_zip(
  "https://github.com/juanchiem/R_Intro/raw/master/data/data.zip")
```


La forma más rápida es vía clicks de mouse en el panel de entorno de la sesión: 

- Buscan el archivo a importar en el explorador de archivos del panel multipropósito de RStudio 
- Hacen click sobre el archivo  
- Seleccionan "import dataset"  
- Configuran las opciones de importación y copian el código generado y dan import

O bien desde código del script:
    
* Archivos Excel 

Importemos los datos "crudos" (planillas de campo). Via clicks y pegamos los códigos auto-generados en nuestro script 


```r
library(readxl)
soja <- read_excel("data/soja.xls")
canola <- read_excel("data/canola_maculas.xlsx")
olivo <- read_excel("data/olivo_xylella.xls")
```

Dataset **olivo_xylella**

Datos simulados de muestreos de severidad de xylella en localidades productoras de olivo en Córdoba y La Rioja.

Dataset **canola_phoma** 

Experimento de canola conducido en Balcarce, donde fueron testeados 10 fungicidas (mas un control sin protección con fungicida) con 3 bloques en que se registró el progreso de manchas foliares de *Phoma lingam* a través del tiempo (tiempo térmico desde la detección de la primera mancha), y la severidad del consiguiente cancro desarrollado en la base del tallo. 

* Archivos de texto .csv
    

```r
dat <- read.csv("nombre_del_archivo.csv", header = TRUE, sep = ",", dec = ".")# puede variar el símbolo de cómo se separan las columnas. Siempre chequear el banco de datos importados.

dat <- readr::read_csv("ruta/nombre_del_archivo.csv")
```

* Desde clipboard 

Muchas veces necesitamos replicar rápidamente un fragmento del dataset desde Excel, o bien un vector lo que es posible mediante: 

`{datapasta}` - Package + addin


```r
install.packages("datapasta")
```

* Desde google sheets:


```r
# install.packages("gsheet")
url <- "https://docs.google.com/spreadsheets/d/1NQ7nd2pOPQYaLzJs1D2-aOB6LDKzv9kjOcKaNeNFjpA/edit?usp=sharing"
# browseURL(url)
dat  <- gsheet::gsheet2tbl(url)
dat
```

* Crear dataframes tipo SAS (bueno para crear ejemplos reproducibles):


```r
dat <- read.table(header=T, text='
Crop      x1 x2 x3 x4
Corn      16 27 31 33
Corn      15 23 30 30
Corn      16 27 27 26
Corn      18 20 25 23
Corn      15 15 31 32
Corn      15 32 32 15
Corn      12 15 16 73
Soybean   20 23 23 25
Soybean   24 24 25 32
Soybean   21 25 23 24
Soybean   27 45 24 12
Soybean   12 13 15 42
Soybean   22 32 31 43
')
```


* Colección de datos en archivo .RData 

Muchas veces en una misma sesión se generan nuevos datasets a partir de uno importado. Al reiniciar una sesión deberían tenerse rápidamente disponibles todos los objetos creados en días previos, los que pueden recopilarse en un archivo de múltiples objetos ".RData" e importarse directamente desde éste.


```r
save(soja, canola, file="./data/soja_canola.RData")
```

Para traerlos nuevamente al entorno de la sesión:


```r
load("./data/soja_canola.RData")
```

## Importación múltiple


```r
# Adaptado de:
# browseURL("https://resources.rstudio.com/webinars/programacio-n-con-r-edgar-ruiz")
```

Muchas veces necesitamos compilar varias planillas en un solo set de datos, como por ejemplo una serie de datos meteorológicos:

Supongamos que tenemos varios archivos: 
balcarce_2018.xlsx ; balcarce_2019.xlsx



```r
library(tidyverse)
library(readxl)
library(fs)
```



```r
archivos <- dir_ls(glob = "balcarce_*") 
#(here::here("data", "balcarce"), glob = "*.xlsx")
```

Usaremos la función "map()" que es una función del paquete purrr, que aplica una misma acción recursivamente a una lista de objetos que le asignemos.

Ej 1 - crear un dataframe a partir de múltiples archivos (primeras hojas)


```r
archivos %>% 
  map(read_excel)

# "pegamos" una tabla arriba de la otra, 
archivos %>% 
  map(read_excel) %>%   
  bind_rows()

archivos %>% 
  map_dfr(read_excel) # podemos agregar: .id = "archivos"
```

Ej 2 - crear un dataframe a partir de múltiples hojas dentro de uno o varios archivos. (Usaremos algunas técnicas de programación un poco más avanzadas que anida un bucle dentro de otro).


```r
# https://stackoverflow.com/questions/51200887/how-to-import-multiple-sheets-from-multiple-excel-files-into-one-list-readxl-r

bce_serie <- archivos %>% 
  map_df(function(x){  
  sheet_names <- excel_sheets(x)
  map_df(sheet_names, ~read_excel(x, sheet = .x)) 
  })
```

