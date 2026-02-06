# paquetes
library(tidyverse)
library(stringr)
library(lubridate)

datos_crudos <- read_csv(file = "datos/original/datos.csv")

#revisión de datos
glimpse(datos_crudos)
Datos_revisados <- datos_crudos %>% 
  summarise(across(everything(), ~class(.x)[1])) %>%
  pivot_longer(everything(), names_to = "Columna", values_to = "Tipo_de_Variable")

# Mostrar tabla
print(Datos_revisados)

#revisión de valores faltantes
colSums(is.na(datos_crudos))
datos_limpios <- datos_crudos |>
  mutate(
    Sex_clean = if_else(is.na(Sex), "unknown", Sex)
  )

#agrupar por especie
datos_limpios|>
  group_by(Species)|>
  summarise(n = n())

#corregir los nombres mal escritos 
datos_limpios <- datos_limpios |>
  mutate(
    Species = tolower(Species),
    Species = str_squish(Species),
    Species = case_when(
      str_detect(Species, "adel")   ~ "adelie penguin (pygoscelis adeliae)",
      str_detect(Species, "chin")   ~ "chinstrap penguin (pygoscelis antarctica)",
      str_detect(Species, "gentoo|gento") ~ "gentoo penguin (pygoscelis papua)",
      TRUE ~ Species
    )
  )

#resultado de homogenizar nombres
datos_limpios|>
  group_by(Species)|>
  summarise(n = n())

#columna de año 
datos_limpios <- datos_limpios |>
  mutate(Year = year(`Date Egg`))
head(datos_limpios$Year)

#guardar datos
dir.create("datos/curados", showWarnings = FALSE, recursive = TRUE)
write_csv(x = datos_limpios, file = "datos/curados/datos_rYSSP.csv")

