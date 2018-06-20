# 1.5(IQR) Rule
a = c(3,12,15,16,17,18,19,34)
# plot(density(a), ylim=c(0,1.2))
# boxplot(a, horizontal = T, add=TRUE)

boxplot(a, horizontal = TRUE)
rug(a, col="blue",lwd=1)
# text(a, 0.5, as.character(a), cex = 0.7)

 # summary(a)
 # quantile(a)
 # quantile(a, 0.75) - quantile(a, 0.25)
 # ?IQR
# IQR(a)

fivenum(a)

q1= 13.5
q3= 18

iqr = (q3-q1)

abline(v=fivenum(a), lty=2, col="green")
lim_inf = q1 - (1.5*(iqr))
lim_sup = q3 + (1.5*(iqr))

abline(v = c(lim_inf, lim_sup), lty =2, col= "blue")

b = c(6.749,12,15,16,16,17,19,34)
boxplot(b, horizontal = T)

# 68 95 and 99.7 rule
# mean = Ex / n
# S = sqrt( (Ex- mean)^2 / n-1)
