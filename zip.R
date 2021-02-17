files2zip <- dir('data', full.names = TRUE)
zip(zipfile = 'data/archivos', files = files2zip)

temp <- tempfile()
download.file("https://github.com/juanchiem/R_Intro/raw/master/data/archivos.zip",
              temp)
unzip(zipfile = temp, exdir = "data")

