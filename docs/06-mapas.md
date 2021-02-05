##  Mapas

Cargamos paquetes


```r
library(tidyverse)
library(sf)
# library(rnaturalearth)
# library("rnaturalearthdata")
library(georefar)
```

Para obtener un listado de provincias:

```r
get_provincias(orden = "id", max = 5)
```

Para obtener un listado de departamentos:

```r
get_departamentos(provincia = "Corrientes", orden = "id", max = 5)
```

Para obtener un listado de municipios:


```r
muni <- get_municipios(provincia = "Buenos Aires")
```

Para obtener un listado de localidades:


```r
get_localidades(provincia = "Chubut", max = 5)
```

Para obtener la ubicacion de un punto (reverse-geocoding):

```r
get_ubicacion(-31.6515236,-64.4358794)
```

Provincias de Argentina


```r
theme_set(theme_bw())
arg = rnaturalearth::ne_states(country = 'argentina', returnclass = "sf")

map_arg <- arg %>%
  ggplot() +
  geom_sf() +
  geom_text(aes(longitude, latitude, label = name_fr), colour = "black", size=2)
```

Random points


```r
puntos <- st_sample(arg, 30) # arg[1:3, ], 6)
puntos_coords <- unlist(st_geometry(puntos)) %>% 
    matrix(ncol=2, byrow=TRUE) %>% 
    as_tibble() %>% 
    setNames(c("lon","lat"))

map_arg+
    geom_point(data = puntos_coords,
             aes(x = lon,
                 y = lat),
             size = 1)
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
  st_set_crs(4326) %>%
  st_transform(3857)

p1 <- arg %>% 
  ggplot() +
  geom_sf() +
  geom_rect(xmin= -64, ymin= -40, xmax= -56, ymax= -30, 
            fill = NA, colour = "black", size = 1) +
  theme_void()
p1

p2 <- arg %>% 
  ggplot() +
  geom_sf() +
  ggrepel::geom_label_repel(data = sites,
                            aes(label = name, 
                                geometry = geometry),
                            stat = "sf_coordinates",
                            min.segment.length = 0)+
  geom_sf(data=sites, size=1.5)+
  ggspatial::annotation_scale(location = "bl",
                              width_hint = 0.3,
                              pad_x = unit(1.5, "in"),
                              pad_y = unit(0.1, "in")) +
  ggspatial::annotation_north_arrow(location = "bl",
                                    which_north = "true",
                                    pad_x = unit(4.4, "in"),
                                    pad_y = unit(0.1, "in"),
                                    style = ggspatial::north_arrow_fancy_orienteering) +
  coord_sf(crs = st_crs(4326),
           #          xlim = c(-64, -56.5), 
           ylim = c(-40, -22),
           expand = TRUE)+
  labs(x="", y="")+
  theme_bw()+
  theme(plot.margin=margin(r=3, unit="cm"))
p2
```


```r
ggdraw(p2) +
  draw_plot(p1, width = 0.2, height = 0.5, x = 0.8, y = 0.48) 

ggsave(w=85, h=100, units="mm", scale=2, dpi=150, "map2.tiff")
```

Mapa de prevalencia de enfermedades


```r
library(polAr)
BSAS <- get_geo(geo =  "BUENOS AIRES") 
```


```r
BSAS%>% st_bbox()
SEBA <- st_crop(BSAS, 
                xmin = -60, xmax = -57, 
                ymin = -39, ymax = -37)
# SEBA %>%
#   ggplot() +
#   geom_sf()

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
  left_join(cancro, by= "coddepto") #%>% 

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


```r
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
  theme_void()  # geom_sf_label(aes(label = coddepto), label.padding = unit(1, "mm"))
```


