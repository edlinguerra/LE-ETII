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

#variable9: dateegg
datos$`Date Egg`

#Variable9.1: year
datos$year <- substr(datos$`Date Egg`, 1, 4)
datos
#la nueva columna con solo los años se agregó al final del data frame

#Variable10: culmenlength
datos$`Culmen Length (mm)`
#sin errores

#Variable11: culmendepth
datos$`Culmen Depth (mm)`
#sin errores

#Variable12: flipperlength
datos$`Flipper Length (mm)`
plot(datos$`Flipper Length (mm)`)
#sin errores

#Variable13: boddy mass
datos$`Body Mass (g)`
plot(datos$`Body Mass (g)`)
#sin errores

#Variable14: sex
levels(factor(datos$Sex))
#hay error, algunos datos vienen en mayúsculas y otras en minúsculas

datos$Sex <- ifelse(datos$Sex == "Female", "FEMALE", datos$Sex)
datos$Sex <- ifelse(datos$Sex == "Male", "MALE", datos$Sex)
#problema arreglado

#variable15: delta15
datos$`Delta 15 N (o/oo)`
#sin errores

#Variable16: delta13
datos$`Delta 13 C (o/oo)`
#sin errores

#variable comentarios
levels(factor(datos$Comments))
#sin errores


#GRÁFICOS DE ALGUNOS DE LOS DATOS

library(ggplot2)

colnames(datos)

#distribución de masa corporal por sexo
datos %>%
  ggplot( aes(x=Sex, y=`Body Mass (g)`, fill= Sex)) +
  geom_boxplot()

#distribución de longitud de ala por sexo
datos %>%
  ggplot( aes(x=Sex, y= `Flipper Length (mm)`, fill= Sex)) +
  geom_boxplot()


