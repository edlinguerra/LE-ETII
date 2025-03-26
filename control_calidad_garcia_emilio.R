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

levels(factor(datos$Sex))

#Se remplazaron los nombres mal escritos y en mayusculas

#variable 4 Region

levels(factor(datos$Region))

#variable 5 Island

levels(factor(datos$Island))

#variable 6 Stage

levels(factor(datos$Stage)) 

#variable 7 Individual . ID

levels(factor(datos$Individual.ID))

#variable 8 Clutch.Completion

levels(factor(datos$Clutch.Completion))

#variable 9 Date.Egg

levels(factor(datos$Date.Egg))

#variable 10 Culmen.Length..mm.

levels(factor(datos$Culmen.Length..mm.))

#variable 11 Culmen.Depth..mm.

levels(factor(datos$Culmen.Depth..mm.))

#variable 12 Flipper.Length..mm.

levels(factor(datos$Flipper.Length..mm.))

#variable 13 Body.Mass..g.

levels(factor(datos$Body.Mass..g.))

#variable 14 Sex

levels(factor(datos$Sex))

datos$Sex <- ifelse(datos$Sex == "MALE", "Male", datos$Sex)
datos$Sex <- ifelse(datos$Sex == "FEMALE", "Female", datos$Sex)

#Se remplazaron los nombres en mayusculas

#variable 15 Delta.15.N..o.oo.

levels(factor(datos$Delta.15.N..o.oo.))

#variable 16 Delta.13.C..o.oo.

levels(factor(datos$Delta.13.C..o.oo.))

#variable 17 Comments

levels(factor(datos$Comments))

#variable 18 years (Recien fabricada)

ano <- year(datos_filtrados$Date.Egg)

datos_filtrados$Date.Egg <- ymd(datos_filtrados$Date.Egg)

datos_filtrados <- datos_filtrados |> 
  mutate(ano = year (Date.Egg))

#Se añadio una columna al final donde estuviera el año de muestreo 
#de cada pingüino


#Cambios adicionales en los datos 

datos_filtrados1 <- datos %>%
  filter(is.na(Sex)) #Organisos muestreados sin información en "Sex"

datos_filtrados <- datos %>%
  filter(!is.na(Sex))

#Los datos que no contenian la información de sexo 
#no tenian dos o mas apartados extra, por los que se opto por eliminarlos. 


#variable Species 
CC <- table(datos_filtrados$Species)
conteo <- sort(CC, decreasing = TRUE)
print(conteo)

#Adelie Penguin (Pygoscelis adeliae) 
#146 
#Gentoo penguin (Pygoscelis papua) 
#119 
#Chinstrap penguin (Pygoscelis antarctica) 
#68 

grafico_Species <- ggplot(datos_filtrados, aes(x = "", fill = Species)) +
  geom_bar(width = 1) +
  coord_polar(theta = "y") +
  geom_text(stat = "count", aes(label = ..count..), position = position_stack(vjust = 0.5)) +
  labs(title = "Distribución por sexo", fill = "Sexo", x = NULL, y = NULL) +
  theme_light()
print(grafico_Species)

#Variable Culmen.Length..mm.

min(datos_filtrados$Culmen.Length..mm.)#32.1
max(datos_filtrados$Culmen.Length..mm.)#59.6
mean(datos_filtrados$Culmen.Length..mm.)#43.99
sd(datos_filtrados$Culmen.Length..mm.)#5.46


#Variable Culmen.Depth..mm.

min(datos_filtrados$Culmen.Depth..mm.)#13.1
max(datos_filtrados$Culmen.Depth..mm.)#21.5
mean(datos_filtrados$Culmen.Depth..mm.)#17.16
sd(datos_filtrados$Culmen.Depth..mm.)#1.96


#Variable Flipper.Length..mm.

min(datos_filtrados$Flipper.Length..mm.)#172
max(datos_filtrados$Flipper.Length..mm.)#231
mean(datos_filtrados$Flipper.Length..mm.)#200.967
sd(datos_filtrados$Flipper.Length..mm.)#14.01

#Variable Body.Mass..g.

min(datos_filtrados$Body.Mass..g.)#2700
max(datos_filtrados$Body.Mass..g.)#6300
mean(datos_filtrados$Body.Mass..g.)#4207.05
sd(datos_filtrados$Body.Mass..g.)#805.21

#Variable Sex
grafico_Sex <- ggplot(datos_filtrados, aes(x = "", fill = Sex)) +
  geom_bar(width = 1) +
  coord_polar(theta = "y") +
  geom_text(stat = "count", aes(label = ..count..), position = position_stack(vjust = 0.5)) +
  labs(title = "Distribución por sexo", fill = "Sexo", x = NULL, y = NULL) +
  theme_minimal()
print(grafico_Sex)

#Male=168 :: Female=165


#Grafico del peso en respuesta al tamaño del ala  
grafico_bodyMass <- ggplot(datos_filtrados, aes(x = Flipper.Length..mm., y = Body.Mass..g., color = Species))+
  geom_col()+
  labs(title = "Peso en respuesta al tamaño del ala",y = "Peso", x="Tamaño del ala")+
  theme_bw()

print(grafico_bodyMass)


#Grafico del tamaño del ala en respuesta a la profundidad de la cresta

grafico_flipper <- ggplot(datos_filtrados, aes(x = Culmen.Depth..mm., y =Flipper.Length..mm., color = Species))+
  geom_col()+
  labs(title = "Tamaño del ala en respuesta a la profundidad de la cresta",y = "Tamaño del ala", x="Profundidad de cresta")+
  theme_bw()

print(grafico_flipper)

