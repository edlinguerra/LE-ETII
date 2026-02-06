#PRÁCTICA 

#Leer datos desde el archivo crudo.
datos_crudos <- read.csv(file.choose("datos.csv"))
datos_crudos

#Aplicar control de calidad usando tidyverse
install.packages("tidyverse")
library(tidyverse)

#Revisión de tipos de datos (numérico, fecha, texto/categorías)
install.packages("dplyr")
library(dplyr)
glimpse(datos_crudos)


#Valores faltantes (NA): cuántos hay y qué decisión tomar con ellos (documental)
#Total de NA por columna 
colSums(is.na(datos_crudos))
#Eliminar columna "comments"
datos_limpios <- datos_crudos %>% 
  select(-Comments)

#Homogeneizar nombres de especies y corregirlos desde R
#Datos por sitio de estudio 
datos_limpios |> 
  group_by(studyName) |> 
  summarise(conteo = n())

#Gráfica de datos por sitio de estudio
library(ggplot2)

ggplot(datos_limpios, aes(x = studyName)) +
  geom_bar(fill = "#cca9dd") +
  theme_minimal() +
  labs(title = "Datos por sitio de estudio",
       x = "Sitio de estudio",
       y = "Número de individuos") 

#Conocer nombres
datos_limpios |> 
  group_by(Species) |> 
  summarise(conteo = n())

#Homogenizar nombres de especies 
library(dplyr)
library(stringr)

datos_limpios2 <- datos_crudos %>%
  mutate(Species = str_trim(Species),        
         Species = str_to_sentence(Species))  

datos_limpios3 <- datos_limpios %>%
  mutate(Species = case_when(
    str_detect(Species, "Adeli ")   ~ "Adelie Penguin (Pygoscelis adeliae)",
    str_detect(Species, "Gento ")   ~ "Gentoo penguin (Pygoscelis papua)",
    str_detect(Species, "Gentoo ")  ~ "Gentoo penguin (Pygoscelis papua)",
    TRUE ~ Species # Mantener los demás igual 
  ))

#Mismo formato: Primera mayúscula, resto minúscula
datos_final <- datos_limpios3 %>%
  mutate(Species = if_else(str_detect(Species, "ADELIE PENGUIN"), 
                           "Adelie Penguin (Pygoscelis adeliae)", 
                           Species))
# Verificar 3 especies 
datos_final %>% count(Species)

#Gráfica de las 3 especies 
library(ggplot2)

ggplot(datos_final, aes(x = Species)) +
  geom_bar(fill = "#ADD8E6") +
  theme_minimal() +
  labs(title = "Individuos por especie",
       x = "Especie",
       y = "Número de individuos") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) 

#Subir archivo
library(readr)
write_csv(x=datos_final, file= "datos/curados/datos_rASM.csv")


