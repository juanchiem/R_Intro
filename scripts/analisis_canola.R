# https://stats.stackexchange.com/questions/76226/interpreting-the-residuals-vs-fitted-values-plot-for-verifying-the-assumptions
library(gsheet)
url1="https://docs.google.com/spreadsheets/d/135CDYxoU9KF-Gl32461EWpX0LlXbsSGZ4t_i-0VPpko/edit?usp=sharing"
can_phoma = gsheet2tbl(url1)
# browseURL(url1)

can_long <- can_phoma %>%
  gather(`015`, `058`, `095`, `146`, `165`, `180`, `248`,
         key = "tt", value = "incp")

can_long$tt <- as.numeric(can_long$tt)

ggplot(can_long, aes(x=tt, y=incp)) +
  geom_point()+
  # geom_line(aes(group=par)) +
  geom_line() +
  # geom_smooth(se=F)+
  # geom_line(aes(group=par)) +
  facet_wrap(~par, ncol=11) +
  # facet_grid(bk~trt)+
  # scale_x_continuous(breaks = c(50,200))+
  theme_bw()

can_sum <- can_long %>%
  group_by(trt, bk, sev_cancro) %>%
  summarize(max_inc= max(incp*100),
            auc_inc = agricolae::audpc(incp*100, tt)) %>%
  mutate(sev_log = car::logit(sev_cancro, percents=TRUE))

ggplot(can_sum, aes(x=trt, y=auc_inc))+
  # geom_boxplot(aes(group=trt))+
  geom_point()

library(GGally)

ggpairs(can_sum, columns = 3:5,
        columnLabels = c("Severidad de cbt", "Incidencia máxima", "AUC"))

m1 = lm(auc_inc ~ factor(trt) + factor(bk), data=can_sum)
anova(m1)
plot(m1)
shapiro.test(residuals(m1)) # p <0.05 NO NORMALIDAD
# bartlett.test(AUC ~ trt, data = auc)

par(mfrow=c(1,2)) ; plot(m1, which=1:2)
# car::influencePlot(m1); MASS::boxcox(m1) ; layout(1)

library(emmeans)
em <- emmeans(m1, ~ trt)
result_m1 = cld(em, Letters = "abcdef", reverse = FALSE)
class(result_m1)
result_m1$.group
result_m1$let = c("a", "ab", "ab", "bc", "cd", "cd", "cd", "cd", "d","d",
                  "d")

result_m1 %>%
  ggplot(aes(x = factor(trt), y=emmean))+
  geom_point(shape = 18, size=3)+
  geom_errorbar(aes(ymin=lower.CL, ymax=upper.CL), width=.2, size=0.3)+
  geom_text(aes(label=let, x=factor(trt), y=emmean, hjust = -1), size=3)+
  labs(x="Fungicide treatment",
       y= "Area under disease incidence progress curve") +
  theme_bw(base_size = 14)

# ggsave("C:/Users/Juan/Dropbox/Curso R/plots/plot_final.tiff", #pdf png
       # w=8, h=8,units="cm", scale = 2,  dpi=300)

m2 = lm(sev_cancro ~ factor(trt) + factor(bk), data=can_sum)
par(mfrow=c(1,2)) ; plot(m2, which=1:2)
shapiro.test(residuals(m2)) # p <0.05 NO NORMALIDAD
bartlett.test(sev_cancro ~ trt, data = can_sum)
boxplot(sev_cancro ~ trt, data = can_sum)

m3 = lm(sev_log ~ factor(trt) + factor(bk), data=max_inc)
par(mfrow=c(1,2)) ; plot(m3, which=1:2)
shapiro.test(residuals(m3)) # p <0.05 NO NORMALIDAD
bartlett.test(sev_log ~ trt, data = can_sum)
boxplot(sev_log ~ trt, data = can_sum)

plot(sev_cancro ~ auc_inc, data = can_sum)
auc_cbt <- lm(sev_cancro ~ auc_inc, data = can_sum)
summary(auc_cbt) ; sum(resid(auc_cbt)^2)

plot(sev_cancro ~ max_inc, data = can_sum)
max_cbt <- lm(sev_cancro ~ max_inc, data = can_sum)
summary(max_cbt) ; sum(resid(max_cbt)^2)

# modelo exponencial
m.exp <- nls(sev_cancro ~ exp(a + b * max_inc), data = can_sum, start = list(a = 0, b = 0))
summary(m.exp) ; sum(resid(m.exp)^2)
plot(can_sum$max_inc, can_sum$sev_cancro,
     ylim=c(0,65), xlim=c(0,60), main = "Exponential model")
lines(sort(can_sum$max_inc), predict(m.exp, list(max_inc = sort(can_sum$max_inc))))
plot(resid(m.exp) ~ fitted(m.exp))#1 ;  plot(m.exp) #2

# Power model
m.power <- nls(sev_cancro ~ a * max_inc^b, data = can_sum, start = list(a=1, b=1))
sum(resid(m.power)^2)
plot(can_sum$max_inc, can_sum$sev_cancro,
     ylim=c(0,65), xlim=c(0,60), main = "Power model")
lines(sort(can_sum$max_inc), predict(m.power, list(max_inc = sort(can_sum$max_inc))), col="red")
plot(resid(m.power) ~ fitted(m.power))#1 ;  plot(m.exp) #2

AIC(auc_cbt,max_cbt, m.exp, m.power )

