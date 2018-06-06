url2 <- "https://raw.githubusercontent.com/juanchiem/R_Intro/master/data/beet.csv"
beet <- read.csv(textConnection(RCurl::getURL(url2)), sep= ";", skip=10, na.strings = ".", header = T, dec=",")
beet[1:5] <- lapply(beet[1:5], as.factor)

ggplot(subset(beet, exp==2), aes(x=trt, y=root)) +
  geom_boxplot() +
  facet_wrap(~geno)

fit1 = lm(sqrt(root) ~ geno * trt + pot/pl, data = subset(beet, exp==2))
fit2 = lm(sqrt(root) ~ geno * trt, data = subset(beet, exp==2))
anova(fit1, fit2)

anova(fit2) #96-1-4-1-1-1
plot(fit2, which=1)

library(emmeans)
emmeans(fit1, ~ trt | geno, type = "response")


# str(beet[beet$exp==2, "root"])
# summary(beet[beet$exp==2, "root"])


### Dataset: Remolacha

```{r}
url2 <- "https://raw.githubusercontent.com/juanchiem/R_Intro/master/data/beet.csv"
beet <- read.csv(textConnection(RCurl::getURL(url2)), sep= ";", skip=10, na.strings = ".", header = T, dec=",")
str(beet)
```


Generaremos las variables descriptivas por extenso para hacer los gráficos

```{r}
beet <- beet %>%
  mutate(trt1 = ifelse(trt == '1',"Check","Inoculated"),
         Cultivar = ifelse(geno == '1',"Boro","Bohan"),
         exp1 = ifelse(exp == '1',"Autumn experiment","Spring experiment")
  ) %>%
  mutate_if(is.character, as.factor)
str(beet)
summary(beet)
```

Inspección numérica del dataset (desglosamos las unidades experimentales)

```{r}
ftable(xtabs(~ exp + geno + trt + pot, beet))
```

```{r}
GGally::ggpairs(beet[,6:8])
```

* Biomasa de raiz (ejecute el siguiente código seleccionando primero la 1° fila, luego las 1°+2°, y luego todas)

```{r}
ggplot(beet, aes(x=trt1, y=root)) +
  geom_boxplot() +
  geom_jitter(width = 0.1)+
  facet_grid(Cultivar ~ exp, labeller = label_both)
# facet_grid(exp ~ Cultivar, labeller = label_both)
```

```{r}
summary(beet$root)
```

> Explore visualmente la biomasa aerea

```{r}
library(emmeans)
beet[1:5] <- lapply(beet[1:5], as.factor)
str(beet)
root1 = lm(root ~ Cultivar * trt1, data = subset(beet, beet$exp==1))
anova(root1)
plot(root1, which=1)
emmeans(root1, ~ trt1 | Cultivar)
```

Sin efecto ni de trat ni de geno

```{r}
root3  <- lm(sqrt(root) ~ Cultivar * trt1 + pot/pl, data = subset(beet, beet$exp==2)) #+
anova(root3)
summary(root3)
plot(root3, which=3)
shapiro.test(residuals(root3)) # p <0.05 NO NORMALIDAD

emmeans(root3, ~ trt1 | Cultivar, type = "response")

ftable(xtabs(~ exp + geno + trt + pot, dat))

unid_exp = 2 *2 * 8 * 3 # 96
unid_exp -4
92-16-1-7-1-1
#https://ms.mcmaster.ca/peter/s2ma3/s2ma3_0001/factorialdf.html

#(IJK - 1) = (I - 1) + (J - 1) + (I -1)(J - 1) + IJ(K - 1)


```

Sin interaccion trt x geno pero efecto simple de ambos factores: trt afecto el peso de las raizes de ambos genotipos en igual magnitud (P<0.001) y el geno 2 tuvo mayor peso de raices (P=0.02).

# https://cran.r-project.org/web/packages/emmeans/vignettes/messy-data.html
