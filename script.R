###Paquetes 
library(readr)


###importar datos 
datos<- read_csv("datos.csv")
#### compuesto por variables cuentitativas y cualitativas 
###Paso de control de calidad con la variable 1: studyName
levels(factor(datos$studyName))
###Verificado sin errores 


###Variable 2 
