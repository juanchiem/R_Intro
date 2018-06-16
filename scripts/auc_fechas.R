df <- read.table(header=T, text='
          fecha        y    d
          2007-12-03 0.1    0
          2008-01-02 0.12  30
          2008-02-01 0.18  60
          2008-03-02 0.29  90
          ')
with(df, agricolae::audpc(df$y, as.Date(df$fecha)))

df$d <- max(as.Date(df$fecha)) - min(as.Date(df$fecha))

library(lubridate)
df$fecha = as_date(ymd(df$fecha)) 
# df$Date[2] - df$Date[1]
# df$Date[3] - df$Date[2]
# df$Date[4] - df$Date[3]
with(df, MESS::auc(d, y, type = "spline"))
with(df, MESS::auc(as.Date(fecha), y))


