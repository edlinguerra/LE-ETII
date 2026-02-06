# paquetes
library(tidyverse)

datos_crudos <- read_csv(file = "datos/original/datos.csv")
datos_crudos

#Aplicacion QC con tidyverse 

#PARTE 1 _ Revisión de tipos de datos (numérico, fecha, texto/categorías)

glimpse(datos_crudos) #tipo de variable, no.filas, etc. 
Revision_datos <- datos_crudos %>% 
  summarise(across(everything(), ~class(.x)[1])) %>%
  pivot_longer(everything(), names_to = "Columna", values_to = "Tipo_de_Dato")

# Mostrar tabla
print(Revision_datos)

# PARTE 2 _ Valores de NA CUANTOS, DONDE Y QUE HACER

# 2. Contar valores faltantes por columna
Valores_na <- datos_crudos %>%
  summarise(across(everything(), ~sum(is.na(.))))

print(Valores_na)
summary(datos_crudos) #rangos (medias, min., max., NA)

# Conteo de NAs por columna
NA_por_columna <- datos_crudos %>%   
  summarise(across(everything(), ~sum(is.na(.x)))) %>%
  pivot_longer(everything(), names_to = "Columna", values_to = "Cantidad_NAs") %>%
  filter(Cantidad_NAs > 0) # Solo mostrar las que tienen faltantes

# Mostrar resultados
print(NA_por_columna)

# PARTE 3 _ Identificar nombres actuales
unique(datos_crudos$Species)

# PARTE 3 _ HOMOGENEIZAR ESPECIES
# Corrección y limpieza  

datos_limpios_Homogenizados <- datos_crudos %>%
  mutate(Species = case_when(
    str_detect(Species, regex("Adeli", ignore_case = TRUE)) ~ "Adelie penguin (Pygoscelis adeliae)",
    str_detect(Species, regex("Chinstrap", ignore_case = TRUE)) ~ "Chinstrap penguin (Pygoscelis antarctica)",
    str_detect(Species, regex("Gento", ignore_case = TRUE)) ~ "Gentoo penguin (Pygoscelis papua)",
    TRUE ~ Species
  ))

#VERIFICAR DATOS
unique(datos_limpios_Homogenizados$Species)
glimpse(datos_limpios_Homogenizados)

#PASO 5 _ Guardar tu dataset limpio en:
write_csv(x = datos_limpios_Homogenizados, file = "datos/curados/datos_rESCE.csv") 


# NO IDENTIFICO MI CORREO Y NOMBRE DE USUARIO, POR LO QUE TUVE QUE INSTALAR EL
#PAQUETE:
install.packages("usethis")

# Configurar mi identidad:
usethis::use_git_config(
  user.name = "Emilia-1401", 
  user.email = "424088905@github.com"
)
