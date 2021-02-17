files2zip <- dir('data', full.names = TRUE)
zip(zipfile = 'data/archivos', files = files2zip)
