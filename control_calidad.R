#Paquete 1 
library(readr)

#importar datos 
datos <- read.csv("datos.csv")


#Control de calidad

#Variable 1 studyname

levels(factor(datos$studyName))
#Verificación sin errores 

#variable 
datos$Sample.Number

#Se aprecia secuencias que se reinician 

#variable 3 Species 

levels(factor(datos$Species))


