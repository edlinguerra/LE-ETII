#Paquetes
library(readr)
library(lubridate)
library(dplyr)



#importar datos
datos <- read_csv("datos.csv")


#Control de calidad

#variable1 studyname

levels(factor(datos$studyName))
# verificado sin errores

#Variable 2
datos$`Sample Number`

# Se aprecien secuencias que se reinician

#Variable 3 Species

levels(factor(datos$Species))

datosm <- datos|>
  mutate(Year = year(`Date Egg`)) 

write.csv(datosm, file = "datos.csv")
  