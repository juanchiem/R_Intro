--- 
title: "Exploración, manipulación y visualización de datos con tidyverse"
author: ""
output: bookdown::gitbook
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: juanchiem/R_Intro
---



# Motivación {-}

<img src="fig/top.jpg" width="400" height="320" align="right" alt="Cover image" />

*"Una de las cosas más importantes que puedes hacer es dedicar un tiempo para aprender un lenguaje de programación. Aprender a programar es como aprender otro idioma: requiere tiempo y entrenamiento, y no hay resultados prácticos inmediatos. Pero si superas esa primera subida empinada de la curva de aprendizaje, las ganancias como científico son enormes. Programar no sólo te liberará de la camisa de fuerza de los softwares estadísticos cerrados, sino que también agudizará tus habilidades analíticas y ampliará los horizontes de modelado ecológico y estadístico.”*


<div style="text-align: right">  ~ Adaptación de [@ellison2004primer] ~ </div>

---

Podríamos resumir nuestro trabajo como científicos, desde la recolección de datos en el campo, hasta su divulgación a través del siguiente esquema:

![](fig/workflow.jpg) 

<div style="text-align: right">  ~ Adaptación de "R for Data Science" [@wickham2016r] ~ </div>

</br>

---

### Objetivos {-}

El curso pretende proveer herramientas de programación básicas para llevar adelante el proceso de investigación tomando como base el esquema de trabajo anterior. Para ello, usaremos datos (reales o simulados) típicos del área de Ciencias Agrarias. Importante: i) no es un curso de estadística; ii) entendemos la programación como un simple medio para optimizar nuestra labor cotidiana (no como un fin mismo), al final del día seguiremos siendo fitopatólogos, fisiólogos,  bioquímicos, etc.; iii) maximizaremos la adopción de la filosofía [tidyverse](https://www.tidyverse.org/); y iv) obtendrán mayor provecho aquellas personas que se inician en R, ya que los contenidos pretenden ser de baja complejidad, posibilitando profundizar el conocimiento por los propios medios del alumno. 

<hr>

<div style="text-align: center">
<b>¿Por qué R?</b> [@R-base]
</div>


<table class="table table-striped table-hover table-condensed table-responsive" style="font-size: 15px; width: auto !important; margin-left: auto; margin-right: auto;">
 
<tbody>
  <tr>
   <td style="text-align:left;"> <span style="-webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); display: inline-block; "><span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #666666 !important;text-align: c;">1</span></span> </td>
   <td style="text-align:left;"> Software libre - multiplataforma </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="-webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); display: inline-block; "><span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #666666 !important;text-align: c;">2</span></span> </td>
   <td style="text-align:left;"> Aprender un lenguaje de programación: ejercicio mental/lógica (Aprender estadística resulta mucho mas ameno) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="-webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); display: inline-block; "><span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #666666 !important;text-align: c;">3</span></span> </td>
   <td style="text-align:left;"> Software actualizado y con una amplia gama de paquetes específicos (drc, agricolae, epiphy…) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="-webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); display: inline-block; "><span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #666666 !important;text-align: c;">4</span></span> </td>
   <td style="text-align:left;"> Gran flexibilidad y elegancia de los gráficos </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="-webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); display: inline-block; "><span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #666666 !important;text-align: c;">5</span></span> </td>
   <td style="text-align:left;"> Popularidad - Comunidad activa y creciente dispuesta a ayudar (aprendemos a usar terminos técnicos de ciencia de datos en inglés) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="-webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); display: inline-block; "><span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #666666 !important;text-align: c;">6</span></span> </td>
   <td style="text-align:left;"> Programar ya no es sólo computación (CV/relevant skills) </td>
  </tr>
</tbody>
</table>

</br>

<center>
![](fig/pregunta_respuesta.jpg){width=400px}
</center>

</br>

<b>Autor</b>

* Juan Pablo Edwards Molina: Investigador :: Fitopatología (INTA Balcarce).
    + Email: [edwardsmolina@gmail.com](mailto:edwardsmolina@gmail.com)
    + [Google scholar](https://scholar.google.com/citations?hl=en&view_op=list_works&gmla=AJsN-F5gLYB_brelSnzb1TTRxogsbxhyS6qVwhSaP-KHm-jeWxRpoHeH5iIj4ZTys10DUQLdH_3GLXxkLed9dzmZXLWtNu_gtg&user=RhjNQIsAAAAJ) 
    + Twitter: [juanchiem](https://twitter.com/juanchiem)
    + GitHub: <https://github.com/juanchiem>


    

</br>

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Licença Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/80x15.png" /></a><br />Este obra está licenciado com uma Licença <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Atribuição-NãoComercial-SemDerivações 4.0 Internacional</a>.

</br>
