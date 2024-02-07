#Paquetes
library(readr)

#Importar datos
datos <- read_csv("datos.csv")
View(datos)

###Control de calidad

#Variable 1 studyname
 levels(factor(datos$studyName))
  # Verificado sin errores
 
#Variable 2
 datos$`Sample Number`
  # Se aprecian secuencias que se reinician
 
#Variable 3 Species
 levels(factor(datos$Species))
 