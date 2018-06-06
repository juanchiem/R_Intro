library(tidyverse)

load("C:/Users/Juan/Dropbox/Curso R/data/datos_sesion1.RData")

can_long <- can_phoma %>%
  gather(`015`, `058`, `095`, `146`, `165`, `180`, `248`,
         key = "tt", value = "incp")

str(can_long)

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

can_long<- edit(can_long)

auc <- can_long %>%
  group_by(trt, bk) %>%
  summarize(AUC = agricolae::audpc(incp, tt))

str(auc)

ggplot(auc, aes(x=trt, y=AUC))+
  geom_boxplot(aes(group=trt))+
  geom_point()

m1 = lm(AUC ~ factor(trt) + factor(bk), data=auc)
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

?ggsave("C:/Users/Juan/Dropbox/Curso R/plots/plot_final.tiff", #pdf png
       w=8, h=8,units="cm", scale = 2,  dpi=300)

