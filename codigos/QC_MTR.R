#### CORRECCIÓN DE BASE DE DATOS####
#paquete para esta tarea es principalmente tidyverse
install.packages("tidyverse")
library(tidyverse)

####REVISIÓN/LECTURA DE DATOS####
#Leer los datos desde el archivo crudo SIN editarlo (se hace una revisión
#de los tipos de datos):
datos_og<-read_csv("datos/original/datos.csv")

view(datos_og)

glimpse(datos_og)
#en este caso, los datos se dividen en:
#db1/int (números)
#chr (texto)
#date (fechas)

#Revisión de nombres para cada especie
datos_og |> 
  group_by(Species) |> 
  summarise(conteo = n())

#Revisión de "NA" dentro de la base de datos
colSums(is.na(datos_og))

####CONTROL DE CALIDAD A LA BASE DE DATOS####
#Homogeneización de nombres científicos
datos_og <- datos_og |> 
  mutate(Species = case_match(Species,
        "Adeli penguin (pygoscelis adeliae)" ~ "Adelie penguin (Pygoscelis adeliae)",
        "Adelie penguin (pygoscelis adeliae)" ~ "Adelie penguin (Pygoscelis adeliae)",
        "Gento penguin (pygoscelis papua)"  ~ "Gentoo penguin (Pygoscelis papua)",
        "Gentoo penguin (pygoscelis papua)"  ~ "Gentoo penguin (Pygoscelis papua)",
        "Chinstrap penguin (pygoscelis antarctica)"   ~ "Chinstrap penguin (Pygoscelis antarctica)",
        .default = Species                    
  ))


#Descartar valores faltantes (NA)
#Descartar columna de comentarios (Comments)
datos_og <- datos_og |> 
  select(-Comments)

#Descartar filas (individuos) con valores faltantes UNICAMENTE en columnas 
#con mediciones morfológicas
datos_og <- datos_og |> 
  drop_na(`Culmen Length (mm)`, `Culmen Depth (mm)`, 
          `Flipper Length (mm)`, `Body Mass (g)`)

####GUARDAR LA BASE DE DATOS LIMPIA####
write_csv(x=datos_og, file= "datos/curados/datos_rMTR.csv")
