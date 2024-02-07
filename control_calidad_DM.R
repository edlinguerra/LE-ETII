library(readr)


datos <- read_csv("datos.csv")
View(datos)


#control de calidad
#Variable1 studyName

levels(factor(datos$studyName))
#verificado sin errores

#variable2 Sample Number

datos$`Sample Number`
#secuencias que se reinician

#Variables3 Species

levels(factor(datos$Species))
