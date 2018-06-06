source_https("https://raw.githubusercontent.com/juanchiem/R-sources/master/back_transf_sev.R")

dat <- data.frame(sev=c(0, 46.4, 69.5, 82.7, 61.7, 76.4, 84.8, 69.1,100))
hist(dat$sev)

dat$sev_logit <- car::logit(dat$sev, percents=TRUE)
dat$sev_logit_back = zapsmall(inv.logit(dat$sev_logit,a=0.025)*100)
plot(dat$sev, pch=3) ; points(dat$sev_logit_back, col="red")

dat$sev_as <- asin(sqrt(dat$sev/100))
dat$sev_as_back = zapsmall(inv.arcsin(dat$sev_as))*100
plot(dat$sev, pch=3) ; points(dat$sev_as_back, col="red")

par(mfrow=c(3,1))
hist(dat$sev)
hist(dat$sev_logit)
hist(dat$sev_as)
