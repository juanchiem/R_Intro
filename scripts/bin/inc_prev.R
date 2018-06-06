#http://clayford.github.io/dwir/dwr_12_generating_data.html
plot(pbinom(0:10,15,0.5))
barplot(table(rbinom(1000,4,0.6)))

dat = expand.grid(year = 2015:2017,
                  loc = c("Cruz del eje", "Chilecito", "La Rioja"),
                  farm = 1:5,
                  plant = 1:30)

dat = dat[with(dat, order(year, loc, farm)), ]
head(dat, 20)
dim(dat)
ftable(xtabs(~  year + loc + farm, dat))

dat$dis = rbinom(n = 1350, size = 1,
                 prob = 0.05 + (dat$year-2015)/8)

dat_inc = dat %>%
  group_by(year, loc, farm) %>%
  summarise(inc = zapsmall(mean(dis, na.rm=TRUE))) #dis>0

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






























