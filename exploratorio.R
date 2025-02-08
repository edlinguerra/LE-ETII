#Paquetes de datos
library(stringr)
library(dplyr)
library(tidyr)
library(lubridate)


#Exploracion de datos Palmerpenguis 

#exploracionstudyname
datos$studyName
table(datos$studyName)

#Exp Sample Number
datos$`Sample Number`

#Exp Species 
datos$Species
table(datos$Species)

temp1 <- datos |>
  mutate(Species = str_to_lower(Species)) |>
  mutate(Species = str_replace(Species, 
                              pattern = "gento ",
                              replacement = "gentoo ")) |>
  mutate(Species = str_replace(Species,
                              pattern = "adeli ",
                              replacement = "adelie "))

table(temp1$Species) 
#se corigieron lso nombre cientificos 

#ecploracion region
table(datos$Region)

#exploracion island
table(datos$Island)

#exploracion stage
table(datos$Stage)

#exploracion clutch completion
table(datos$`Clutch Completion`)

#exploracion de sex
table(datos$Sex)

temp1 <- temp1 |>
  mutate(Sex = str_to_lower(Sex))

table(temp1$Sex)

temp1 |>
  drop_na(Sex)|>
  group_by(Species, Sex) |>
  summarise(Promedio = mean(`Body Mass (g)`, na.rm = T),
            Desviacion = sd(`Body Mass (g)`, na.rm = T))


#explorar date egg
table(datos$`Date Egg`)

temp1 <- temp1 |>
  mutate(anho = year(`Date Egg`))

table(temp1$anho)

temp1 |>
  #filter(anho == 2007) |>
  drop_na(Sex)|>
  group_by(Species, Sex, anho) |>
  summarise(Promedio = mean(`Body Mass (g)`, na.rm = T),
            Desviacion = sd(`Body Mass (g)`, na.rm = T))


write.csv(temp1, file = "datos.csv")



