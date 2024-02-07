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

datos$Species <- ifelse(datos$Species == "Gento penguin (Pygoscelis papua)", "Gentoo penguin (Pygoscelis papua)", datos$Species)
datos$Species <- ifelse(datos$Species == "Adeli Penguin (Pygoscelis adeliae)", "Adelie Penguin (Pygoscelis adeliae)", datos$Species)
datos$Species <- ifelse(datos$Species == "ADELIE PENGUIN (PYGOSCELIS ADELIAE)", "Adelie Penguin (Pygoscelis adeliae)", datos$Species)


#variable4: región
levels(factor(datos$Region))
#una única región "Anvers"

#variable5: island
levels(factor(datos$Island))
#3 islas: Biscoe, Dream y Torgersen

#variable6: stage
levels(factor(datos$Stage))
#sin errores


#variable7: IndividualID
datos$`Individual ID`


#variable8: clutch completion
levels(factor(datos$`Clutch Completion`))
#sin errores