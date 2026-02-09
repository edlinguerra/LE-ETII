# paquetes
library(tidyverse)

datos_crudos <- read_csv(file = "datos/original/datos.csv")
view(datos_crudos)

# 1. Revisión de tipos de datos 
glimpse(datos) # Muestra estructura: tipo de cada columna

# 2. Valores faltantes (NA) # Conteo de NAs por columna 
datos %>% summarise(across(everything(), 
                           ~sum(is.na(.)))) %>% pivot_longer(cols = everything(), 
                                                             names_to = "columna", 
                                                             values_to = "NAs")

# Eliminar filas con NA en columnas críticas 
datos_limpios <- datos_crudos %>% drop_na(`Culmen Length (mm)`, `Culmen Depth (mm)`, 
                                          `Flipper Length (mm)`, `Body Mass (g)`,
                                          Sex, `Delta 15 N (o/oo)`, `Delta 13 C (o/oo)`,
                                          Comments)

view(datos_limpios)

# 4. Crear columna de año a partir de la fecha
datos_limpios <- datos_limpios %>% mutate(anio = year(`Date Egg`))

# 5. Exploración rápida con ggplot2 # Ejemplo: conteo de registros por año 

datos_limpios %>% ggplot(aes(x = anio)) + 
  geom_bar(fill = "forestgreen") + 
  theme_minimal() + 
  labs(title = "Número de registros por año", x = "Año", y = "Conteo")

write_csv( x = datos_limpios, file = "datos/curados/datos_rJMM.csv")

