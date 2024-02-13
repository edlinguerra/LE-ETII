library(readr)
library(stringr)
library(dplyr)
library(lubridate)
library(tidyr)
library(forcats)


#importar set de datos
datos <- read_csv("datos.csv")
View(datos)


#control de calidad

#Variable1 studyName

levels(factor(datos$studyName))#verificado sin errores

#variable2 Sample Number

datos$`Sample Number`
levels(factor(datos$`Sample Number`))
#secuencias que se reinician

#Variables3 Species

levels(factor(datos$Species))#Cambiar nombres incorrectos

datos <- datos %>%
  mutate(Species = fct_recode(Species,
                              "Adelie Penguin (Pygoscelis adeliae)" = "Adeli Penguin (Pygoscelis adeliae)",
                              "Adelie Penguin (Pygoscelis adeliae)" = "ADELIE PENGUIN (PYGOSCELIS ADELIAE)",
                              "Gentoo penguin (Pygoscelis papua)" = "Gento penguin (Pygoscelis papua)"
  ))

levels(factor(datos$Species))#verificado sin errores

#variable4 region
levels(factor(datos$Region)) #verificado sin errores

#variable5 isla
levels(factor(datos$Island)) #verificado sin errores

#variable6 Estado
levels(factor(datos$Stage))

#cambios en sexo y en isla probablemente

#variable7 Individual ID
levels(factor(datos$'Individual ID'))

length(unique(datos$'Individual ID'))

#variable8 clutch completion
levels(factor(datos$ClutchCompletion)) #verificado sin errores

#variable9 Date Egg / agregar columna con año (lubridate_year / dplyr 'mutate')

levels(factor(datos$'Date Egg'))#verificado sin errores
datosd <- datos %>%
  mutate(Year = year(`Date Egg`)) #agregado

print(datosd)

#variable10 Culmen length

levels(factor(datosd$`Culmen Length (mm)`)) #verificado sin errores

#variable11 Sex

levels(factor(datosd$Sex))

datos <- datosd %>%
  mutate(Sex = fct_recode(Sex,
                              "Female" = "FEMALE",
                              "Male" = "MALE"
  ))

levels(factor(datos$Sex))#Cambios realizados

write.csv(datos, file = "datos.csv")


