url = "https://docs.google.com/spreadsheets/d/1Py0wvmApd2SAzdGf_iZdNebFDUgwAp_mNuvWDwnK_qk/edit?usp=sharing"
dat = gsheet::gsheet2tbl(url)

# Graficos rápidos vs elaborados

pie(table(dat$titulo))

d <- as_data_frame(table(dat$titulo))
d$perc <- round(100 * d$n / sum(d$n))

ggplot(data = d, aes(x = 0, y = n, fill = Var1)) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label = perc), position = position_stack(vjust = 0.5)) +
  scale_x_continuous(expand = c(0,0)) +
  labs(fill = NULL, x = NULL, y = NULL, title = 'Título académico', subtitle = '(%)') +
  coord_polar(theta = "y") +
  theme_minimal()

hist(dat[dat$sexo == "Mujer","altura"])
hist(dat[dat$sexo == "Hombre","altura"])

ggplot(dat,aes(x=altura,fill=sexo))+
  geom_histogram(position="identity", alpha=0.5)

