#PAQUETE 
install.packages("tidyverse")

library(tidyverse)
library(lubridate)  # Para manejo de fechas
library(naniar)

datos_crudos <- read_csv(file = "datos/original/datos.csv")

#ver la cantidad de NA por un mapa de calor
resumen_na <- datos_crudos %>%
  miss_var_summary()
print(resumen_na)
vis_miss(datos_crudos)

# Primero asignamos el resultado a 'datos_limpios'
datos_limpios <- datos_crudos %>%
  filter(!is.na(`Culmen Length (mm)`)) %>%
  mutate(Sex = replace_na(Sex, "DESCONOCIDO"))

# Luego verificamos que funcionó
view(datos_limpios)

#Checar cuales son sus nombres
unique(datos_limpios$Species)

#Homogenizan los datos 
datos_limpios <- datos_limpios %>%
  mutate(Species = case_when(
    str_detect(Species, regex("Adeli", ignore_case = TRUE)) ~ "Adelie",
    str_detect(Species, regex("Gento", ignore_case = TRUE)) ~ "Gentoo",
    str_detect(Species, regex("Chinstrap", ignore_case = TRUE)) ~ "Chinstrap",
    TRUE ~ Species 
  ))
unique(datos_limpios$Species)

#Creacion del año
datos_limpios <- datos_limpios %>%
  mutate(Year = year(`Date Egg`))

datos_limpios %>%
  select(`Date Egg`, Year) %>% 
  head()
datos/curados/datos_rLEGG.scv <- datos_limpios 

write_csv(x = datos_limpios, file = "datos/curados/datosrLEGG")
