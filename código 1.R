#paquetes
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)




#importar datos
datos <- read_csv("datos.csv")

#CONTROL DE CALIDAD

#variable1: studyname
levels(factor(datos$studyName))
#sin errores

#variable2: samplenumber
datos$`Sample Number`
#se aprecian secuencias q se reinician

#variable3: species
levels(factor(datos$Species))

#variable4: 