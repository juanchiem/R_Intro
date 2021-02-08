##  Mapas

Cargamos paquetes


```r
library(tidyverse)
library(sf)
```


```r
library(georefar)
```

Para obtener un listado de provincias:

```r
get_provincias(orden = "id", max = 5)
```

Para obtener un listado de departamentos:

```r
get_departamentos(provincia = "Buenos Aires", orden = "id", max = 5)
```

Para obtener un listado de municipios:


```r
muni <- get_municipios(provincia = "Buenos Aires")
```

Para obtener un listado de localidades:


```r
get_localidades(provincia = "Buenos Aires", max = 5)
```

Para obtener la ubicacion de un punto (reverse-geocoding):

```r
get_ubicacion(-31.6515236,-64.4358794)
```

Provincias de Argentina


```r
theme_set(theme_bw())

arg = rnaturalearth::ne_states(country = 'argentina', returnclass = "sf")
arg %>%
  ggplot() +
  geom_sf() +
  geom_text(aes(longitude, latitude, label = name_fr), colour = "black", size=2)
```


```r
ARG1 <- raster::getData(name = "GADM", country = "ARG", level = 1) %>% 
  st_as_sf() %>% 
  st_transform(crs = 4326)
glimpse(ARG1)

ARG1 %>% 
  ggplot()+
  geom_sf() 

sf_cent <- st_centroid(ARG1)

ARG1 %>%
  ggplot() +
  geom_sf() +
  geom_sf(data = sf_cent, color = 'red', size=1) +
  geom_sf_text(data = sf_cent, aes(label = NAME_1))

ARG2 <- raster::getData(name = "GADM", country = "ARG", level = 2) %>% st_as_sf()
ARG2 %>% 
  # filter(NAME_1 == "Misiones") %>% 
  ggplot()+
  geom_sf() 
```

Random points


```r
puntos <- st_sample(ARG1, 30) # arg[1:3, ], 6)
puntos_coords <- unlist(st_geometry(puntos)) %>% 
    matrix(ncol=2, byrow=TRUE) %>% 
    as_tibble() %>% 
    setNames(c("lon","lat"))

ARG1 %>% 
  ggplot()+
  geom_sf()+
  geom_point(data = puntos_coords,
             aes(x = lon,
                 y = lat),
             size = 1)
```

Leyendo archivos kml


```r
inta <- "https://github.com/juanchiem/agro_data/raw/master/sedes_inta.kml"
aer_inta <- st_read(inta, layer = "Unidades de extensión")
eea_inta <- st_read(inta, layer = "Estaciones Experimentales Agropecuarias")
ci_inta <- st_read(inta, layer="Centros de investigación")

ggplot(ARG1) +
  geom_sf()+
  geom_sf(data=eea_inta, size=0.5, col ="red", alpha = 0.5) +
  geom_sf(data=aer_inta, size=0.5, col ="blue", alpha = 0.5)+
  geom_sf(data=ci_inta, size=0.5, col ="green")
```


Tunneo fino 


```r
# library(googlesheets4)
# googlesheets4::gs4_auth() 
# dat <- gs4_find("localidades_map") %>% range_read()
dat <- tibble::tribble(
  ~state,                     ~name,         ~lat,         ~lon,
  "Buenos Aires",          "Junin", "-34.593922", "-60.946446",
  "Santiago del Estero",     "Santiago del Estero", "-27.784444", "-64.266944",
  "Córdoba",                 "Córdoba", "-31.416667", "-64.183333",
  "Córdoba", "San José de la Quintana", "-31.807335", "-64.416866",
  "Mendoza",              "San Rafael",   "-34.6175", "-68.335556",
  "Misiones",              "Cerro Azul", "-27.633535", "-55.497152"
)

sites <- dat %>% 
  mutate_at(vars(lat:lon), as.character) %>%
  mutate_at(vars(lat:lon), as.numeric) %>%
  st_as_sf(coords = c("lon","lat")) %>%
  st_set_crs(4326) 

ARG1 %>% 
  ggplot() +
  geom_sf(expand = F) +
  geom_sf(data=sites, size=1.5, expand = TRUE)+
  ggrepel::geom_label_repel(data=st_crop(sites, st_bbox(sites)), 
                            aes(label = name, 
                                geometry = geometry),
                            stat = "sf_coordinates",
                            min.segment.length = 0)+
  ggspatial::annotation_scale(location = "bl",
                              width_hint = 0.3,
                              pad_x = unit(4, "cm"),
                              pad_y = unit(0.2, "cm")) +
  ggspatial::annotation_north_arrow(pad_x = unit(5, "cm"),
                                    pad_y = unit(1, "cm"),
                                    style = ggspatial::north_arrow_fancy_orienteering) +
  # coord_sf(crs = st_crs(4326),
  #          #          xlim = c(-64, -56.5), 
  #          ylim = c(-40, -22),
  #          expand = TRUE)+
  labs(x="", y="")

box <- st_bbox(sites)
mini <- ARG1 %>% 
  ggplot() +
  geom_sf() +
  geom_rect(xmin= box$xmin, ymin= box$ymin, xmax= box$xmax, ymax= box$ymax, 
            fill = NA, colour = "black", size = 1) +
  theme_void()
mini
```


```r
# cowplot::ggdraw(big) +
#   cowplot::draw_plot(mini, 
#                      width = 0.2, height = 0.5,
#                      x = 0.85, y = 0.5) 
# ggsave(w=85, h=70, units="mm", scale=2, dpi=150, "map2.tiff")
```

### Mapa de prevalencia de enfermedades


```r
ARG2 <- raster::getData(name = "GADM", country = "ARG", level = 2) %>% st_as_sf()

# https://datascience.blog.wzb.eu/2019/04/30/zooming-in-on-maps-with-sf-and-ggplot2/
BSAS <- ARG2 %>% filter(NAME_1 == "Buenos Aires") 
SEBA <- st_crop(BSAS, 
                xmin = -60, xmax = -57, 
                ymin = -39, ymax = -37)
SEBA %>%
  ggplot() +
  geom_sf()

cancro <- SEBA %>% 
  as_tibble %>% 
  mutate(preval_2015 = rnorm(18, 30, 10),
         preval_2016 = preval_2015*1.05 + rnorm(1, 3, 2) ,
         preval_2017 = preval_2016*1.05 + rnorm(1, 3, 2),
         preval_2018 = preval_2017*1.05 + rnorm(1, 3, 2)) %>% 
  pivot_longer(preval_2015:preval_2018, 
         names_to = "anio", values_to = "prevalencia", 
         names_prefix = "preval_") 
cancro

SEBA_cancro <- SEBA %>% 
  left_join(cancro, by= "NAME_2") #%>% 

SEBA_cancro %>% 
  ggplot() +
  geom_sf(data=SEBA)+
  geom_sf(aes(fill=prevalencia))+
  scale_fill_gradient2(midpoint = 35,
                       low = 'green2',
                       mid = 'yellow',
                       high = 'red3',
                       na.value = 'gray95')+
  facet_wrap("anio")+
  labs(title = "Evolución de la prevalencia del cancro del tallo de girasol",
       x = NULL, y = NULL, fill = "Prevalencia")+
  theme_bw()
```

Puntos de muestreo


```r
library(basemapR)
fina2020 <- st_read("https://github.com/juanchiem/agro_data/raw/master/Sitios_experimentales_2020_Juan.kml")
bbox <- expand_bbox(st_bbox(st_centroid(fina2020)), X = 0, Y = 150000)

BSAS %>%
  ggplot() +
  base_map(bbox, increase_zoom = 2, basemap = 'google-terrain') +
  geom_sf(alpha = 0.1, color=alpha("red",0.1) , show.legend = FALSE)+
  geom_sf(data = fina2020[1], show.legend = FALSE)+
  coord_sf(xlim= c(-61, -57),ylim= c(-39,-36.5))+
  theme_void()  # geom_sf_label(aes(label = coddepto), label.padding = unit(1, "mm"))
```

Mapas Interactivos 


```r
arg1 <- ARG1 %>% rename(provincia = "NAME_1") %>% 
  left_join(huertas, by = c("provincia"))

arg1 %>% ggplot() + geom_sf()+
  geom_sf(aes(fill= X2016), alpha = 0.8)+
  scale_fill_viridis_c() 

pacman::p_load(mapview)
# https://bookdown.org/nicohahn/making_maps_with_r5/docs/mapview.html
mapview::mapview(arg1, zcol="X2016", reverse = F)

library(leaflet)
# https://bookdown.org/nicohahn/making_maps_with_r5/docs/leaflet.html
pal <- colorQuantile("YlGn", NULL, n = 5)

arg1 %>%
  leaflet() %>%
  addTiles() %>%
  addPolygons(fillColor = ~pal(arg1$X2016),
              fillOpacity = 0.8, 
              color = "#BDBDC3", 
              weight = 1)
```

