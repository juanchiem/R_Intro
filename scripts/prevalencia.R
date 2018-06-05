survey = readr::read_csv("data/survey.csv")
ftable(xtabs(~  year + loc + farm, survey))

dat_inc = dat %>%
  group_by(year, loc, farm) %>%
  summarise(inc = mean(sev>0, na.rm=TRUE)) #dis>0

ggplot(dat_inc, aes(x=factor(year), y=inc, color=factor(farm))) +
  geom_point() +
  geom_line(aes(group=farm)) +
  facet_grid(. ~ loc)

dat_prev = dat_inc %>%
  group_by(year, loc) %>%
  summarise(prev = trunc(mean(inc>0, na.rm=TRUE) *100)) #dis>0

ggplot(dat_prev, aes(x=factor(year), y=prev, color=factor(loc))) +
  geom_point() +
  geom_line(aes(group=loc))
