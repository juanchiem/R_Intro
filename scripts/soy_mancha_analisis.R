levels(soy$cultivar)

levels(soy1$cultivar)

soy1 <- soy %>%
  filter(cultivar %in% c("BMX_Potencia_RR", "M9144_RR")) %>%
  droplevels()

p0 = ggplot(soy1, aes(x=sev, y=yield))
p0

p0  + geom_point()

p0 + geom_point(aes(color = cultivar)) +
  geom_smooth(method="lm", aes(color = cultivar))

p0 + geom_point(alpha=0.2)+
  geom_smooth(method="lm", aes(group = study))+
  facet_wrap(~cultivar)+
  labs(x="Disease severity (%)", y = "Yield (kg/ha)") +
  theme_bw()

library(broom)

models = soy1 %>%
  group_by(study, cultivar) %>%
  do(fits = lm(yield ~ sev, data = .),
     corr = cor(.$yield, .$sev))

tidy(models, fits)
tidy(models, corr)
