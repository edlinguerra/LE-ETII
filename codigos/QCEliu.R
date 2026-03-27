# paquetes
library(tidyverse)

datos_crudos <- read_csv(file = "datos/original/datos.csv")

datos_crudos|>
  group_by(studyName)|>
  summarise(total=n())


datos_crudos|>
  group_by(Species)|>
  summarise(total=n())

temp1 <- datos_crudos


library(tidyverse)

glimpse(datos_crudos)       
sum(is.na(datos_crudos))

datos_qc <- datos_crudos %>%
  mutate(

    `Date Egg` = as.Date(`Date Egg`),
    Year_New = as.numeric(format(`Date Egg`, "%Y")),
  
    Species = str_to_title(Species), 
    
    Species = case_when(
      str_detect(Species, "Adeli") ~ "Adelie Penguin (Pygoscelis adeliae)",
      str_detect(Species, "Gento") ~ "Gentoo penguin (Pygoscelis papua)",
      str_detect(Species, "Chinstrap") ~ "Chinstrap penguin (Pygoscelis antarctica)",
      TRUE ~ Species
    )
  ) %>%
  
  drop_na(`Body Mass (g)`, `Flipper Length (mm)`)

count(datos_qc, Species)

dir.create("datos/curados", recursive = TRUE, showWarnings = FALSE)

ruta_salida <- "datos/curados/datos_rEliu.csv"

write_csv(datos_qc, ruta_salida)



  