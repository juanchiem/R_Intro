library(tidyverse)
library(sf)

theme_set(theme_bw())
ARG1 <- raster::getData(name = "GADM", country = "ARG", level = 1) %>% st_as_sf() %>%
  st_transform(32617)

ARG2 <- raster::getData(name = "GADM", country = "ARG", level = 2) %>% st_as_sf()

glimpse(ARG1)

ARG1 %>%
  ggplot()+
  geom_sf()

ARG2 %>%
  # filter(NAME_1 == "Misiones") %>%
  ggplot()+
  geom_sf()

# arg = rnaturalearth::ne_states(country = 'argentina', returnclass = "sf") %>%
#   # st_transform(crs = 4326) %>%
  select(provincia = name, geometry, longitude, latitude)
glimpse(arg)

sf_cent <- st_centroid(ARG1)

ARG1 %>%
  ggplot() +
  geom_sf() +
  # geom_text(data = sf_cent,
  #           aes(label = NAME_1), colour = "black", size=2)+
  # geom_sf(data = sf_cent, color = 'red') +
  geom_sf_text(data = sf_cent, aes(label = NAME_1))



# Vamos a agregar alguna info cuantitativa por provincia

url <- "http://datos.agroindustria.gob.ar/dataset/6cfc8839-8532-4f74-977e-78120d6c3473/resource/8a59e6d5-2f42-4719-8092-093e141a3b1a/download/huertas-familiares-por-provincia.csv"
huertas <- read.table(file = url, header = TRUE, sep = ',', stringsAsFactors = FALSE)  %>%
  mutate(provincia = recode(provincia,
                            "Entre Rios" = "Entre Ríos",
                            'Santa Fé'= 'Santa Fe',
                            'Tucuman'= 'Tucumán',
                            'Neuquen'= 'Neuquén',
                            "Cordoba" = "Córdoba",
                            "Neuquen" = "Neuquén",
                            "Rio Negro" = "Río Negro"
  ))

glimpse(huertas)

arg1 <- ARG1 %>% rename(provincia = "NAME_1")
  # filter(NAME_1 != "Ciudad de Buenos Aires") %>%
  # select(provincia = NAME_1, geometry) %>%
  left_join(huertas, by = c("provincia")) %>% select(-provincia_id) %>%
  pivot_longer(X2016:X2018, names_to = "year", names_prefix = "X",
               values_to= "n_huertas")
arg1 %>%
  ggplot() + geom_sf()+
  geom_sf(data = left_join(arg1, huertas, by = c("provincia")),
          aes(fill= X2016), alpha = 0.8)+
  scale_fill_viridis_c()

pacman::p_load(mapview)
# https://bookdown.org/nicohahn/making_maps_with_r5/docs/mapview.html
mapview::mapview(arg, zcol="X2016", reverse = F)

library(leaflet)
# https://bookdown.org/nicohahn/making_maps_with_r5/docs/leaflet.html
pal <- colorQuantile("YlGn", NULL, n = 5)
arg %>%
  leaflet() %>%
  addTiles() %>%
  addPolygons(fillColor = ~pal(arg$X2016),
              fillOpacity = 0.8,
              color = "#BDBDC3",
              weight = 1)

pacman::p_load(tmap)

tm_shape(bavaria) +
  tm_polygons(col = "type", pal = c("white", "skyblue")) +
  tm_logo("datasets/chapter_2/bavaria.png", height = 2) +
  tm_scale_bar(position = c("left", "bottom"), width = 0.15) +
  tm_compass(position = c("left", "top"), size = 2)


