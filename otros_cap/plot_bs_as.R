library(tidyverse)
library(sf)
library(polAr)

BSAS <- get_geo(geo =  "BUENOS AIRES") 

fina2020 <- st_read("https://github.com/juanchiem/agro_data/raw/master/Sitios_experimentales_2020_Juan.kml")
nc_centers <- st_centroid(fina2020)
bbox <- expand_bbox(st_bbox(nc_centers), X = 0, Y = 150000)

library(basemapR)

BSAS %>%
  ggplot() +
  base_map(bbox, increase_zoom = 2, basemap = 'google-terrain') +
  geom_sf(alpha = 0.1, color=alpha("red",0.1) , show.legend = FALSE)+
  geom_sf(data = fina2020[1], show.legend = FALSE)+
  coord_sf(xlim= c(-61, -57),ylim= c(-39,-36.5))+
  theme_void()
  geom_sf_label(aes(label = coddepto), label.padding = unit(1, "mm"))


library(readxl)
retsave <- read_excel("data/retsave.xlsx") %>% janitor::clean_names()
glimpse(retsave)

BSAS %>%
  ggplot() +
  geom_sf(fill ="white")+
  geom_point(data = retsave %>% 
               filter(enfermedad ==  "Cancro del tallo", 
                      provincia  == "Buenos Aires"),
             aes(x = longitud,
                 y = latitud, col = nivel),
             size = 1)+
  facet_wrap(.~lubridate::year(fecha_de_toma_de_muestra))+
  theme_void()
  
# aes(fill = as.numeric(coddepto))) +
#   # ggplot2::geom_sf_label(aes(label = coddepto), size=1))+
#   ggplot2::scale_fill_gradient2(low = "#7fbf7b", 
#                                 mid = "white", 
#                                 high = "#af8dc3", 
#                                 limits = c(0,100), 
#                                 breaks = c(-20, -15, -10, -5, 0, 5, 10,15, 20))


