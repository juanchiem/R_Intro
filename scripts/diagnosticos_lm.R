assumptions <- function(model)
{
  par(mfrow=c(3,1), 
      oma = c(2, 2, 4, 2),
      mar = c(4, 10, 4, 10)) 
  plot(model, which=2, 
       main = paste("P=", round(shapiro.test(model$residuals)$"p.value",3)))
  plot(model, which=3, 
       main=paste("P=",main= round(olsrr::ols_test_score(model)$p,3)))
  MASS::boxcox(model)
  layout(1)
}
#https://www.calculatorsoup.com/calculators/algebra/percent-change-calculator.php
perc_change <- function(v1,v2)# v1 < v2 
{
  paste(round(digits = 1,
              (v2-v1)/v1 *100), "%")
}