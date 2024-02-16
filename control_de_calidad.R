#Paquetes
library(readr)
library(stringr)
library(dplyr)
library(forcats)
library(ggplot2)

#Importar datos
datos <- read_csv("datos.csv")
datos <- as.data.frame(datos)
View(datos)

###Control de calidad

#Variable 1 studyname
 levels(factor(datos$studyName))
  #Verificado sin errores
 
#Variable 2
 datos$`Sample Number`
  #Se aprecian secuencias que se reinician
 
#Variable 3 Species
 levels(factor(datos$Species))
  #Se aprecian más especies de las correctas debido a errores ortográficos, se sugiere usar el siguiente código para eliminarlas

 datos <- datos %>%
   mutate(Species = fct_recode(Species,
                               "Adelie Penguin (Pygoscelis adeliae)" = "Adeli Penguin (Pygoscelis adeliae)",
                               "Adelie Penguin (Pygoscelis adeliae)" = "ADELIE PENGUIN (PYGOSCELIS ADELIAE)",
                               "Gentoo penguin (Pygoscelis papua)" = "Gento penguin (Pygoscelis papua)"
   ))

#Variable 4 Region
 levels(factor(datos$Region))
  #Verificado sin errores
 
#Variable 5 Island
 levels(factor(datos$Island))
 #Verificado sin errores

#Variable 6 Stage
 levels(factor(datos$Stage))
 #Verificado sin errores
 
#Variable 7 Individual ID
 datos$'Individual ID'
 #Se aprecian identificadores de individuos
 
#Variable 8 Clutch Completion
 levels(factor(datos$`Clutch Completion`))
 #Verificado sin errores
 
#Variable 9 Date Egg
 datos$`Date Egg`
 #Sin errores, se creará una nueva columna que posea únicamente el año
 datos$year <- substr(datos$`Date Egg`, 1, 4)
 
#Variable 10 Culmen Length
 datos$`Culmen Length (mm)`
 plot( datos$`Culmen Length (mm)`)
 #Verificado sin errores
 
#Variable 11 Culmen Depth
 datos$`Culmen Depth (mm)`
 plot(datos$`Culmen Depth (mm)`)
 #Verificado sin errores
 
#Variable 12 Flipper Length
 datos$`Flipper Length (mm)`
 plot(datos$`Flipper Length (mm)`)
 #Verificado sin errores
 
#Variable 13 Body Mass
 datos$`Body Mass (g)`
 plot(datos$`Body Mass (g)`)
 #Verificado sin errores
 
#Variable 14 Sex
 levels(factor(datos$Sex))
 #Se aprecia que algunas etiquetas se escriben con mayúsculas y minúsculas, 
 #se sugiere usar el siguiente código para estandarizar a mayúsculas
 
 datos$Sex <- ifelse(datos$Sex == "Female", "FEMALE", datos$Sex)
 datos$Sex <- ifelse(datos$Sex == "Male", "MALE", datos$Sex)

#Variable 15  Delta 15 N (o/oo)
 datos$`Delta 15 N (o/oo)`
 #Verificado sin errores

#Variable 16 Delta 13 C (o/oo)
 datos$`Delta 13 C (o/oo)`
 #Verificado sin errores
 
#Variable 17 Comentarios
 levels(factor(datos$Comments))
 #Se aprecian diferentes comentarios 
 
#Gráficos
 
 #Relación del tamaño del culmen y masa corporal por especie
 ggplot(datos, aes(x=`Culmen Length (mm)`, y= `Body Mass (g)`, colour = Species)) +
   geom_point(size = 1.5) +
   scale_color_manual(values = c("darkorange1","darkorchid2","dodgerblue1"))
 
 #Relación del tamaño de la aleta pectoral y masa corporal por especie
 ggplot(datos, aes(x=`Flipper Length (mm)`, y= `Body Mass (g)`, colour = Species)) +
   geom_point(size = 1.5) +
    scale_color_manual(values = c("darkorange1","darkorchid2","dodgerblue1"))
 
 