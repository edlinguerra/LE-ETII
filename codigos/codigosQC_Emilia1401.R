# paquetes
library(tidyverse)

datos_crudos <- read_csv(file = "datos/original/datos.csv")
datos_crudos

#Aplicacion QC con tidyverse 

#Revisión de tipos de datos (numérico, fecha, texto/categorías)

glimpse(datos_crudos) #tipo de variable, no.filas, etc. 
summary(datos_crudos) #rangos (medias, min., max., NA)

#Valores de NA CUANTOS, DONDE Y QUE HACER



  






