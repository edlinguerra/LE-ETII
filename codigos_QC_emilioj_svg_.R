codigos/
reportes/
datos/original/
datos/curados/

  # paquetes
  install.packages("tidyverse")

library(tidyverse)

datos_crudos <- read_csv(file = "datos/original/datos.csv")

#Exploración de estructura básica
cat("=== INFORMACIÓN BÁSICA ===\n")
glimpse(datos_crudos)

#Identificación de datos faltantes 
map_dbl(datos_crudos, ~sum(is.na(.)))
    
resumen_variables <- datos_crudos %>%
  summarise(across(everything(),
                   list(
                     Tipo = ~class(.)[1],
                     N_Observaciones = ~n(),
                     No_NA = ~sum(!is.na(.)),
                     NA_count = ~sum(is.na(.)),
                     Porcentaje_NA = ~round(mean(is.na(.)) * 100, 2),
                     Valores_Unicos = ~n_distinct(., na.rm = TRUE)
                   ))) %>%
  pivot_longer(everything(),
               names_to = c("Variable", ".value"),
               names_sep = "_")
print(resumen_variables, n = Inf)  # n = Inf muestra todas las filas


# Se identificaron múltiples NA en las siguientes variables:
#Culmen Length (2), Culmen depth (2), Flipper length (2), 
#Body  Mass (2), Sex (11), Delta 15 N (14), Delta 13 C (14), 
#Comments (290)

#Otras observaciones:
#Se identificaron 6 valores para la variable especie, dado que
# solo se estudiaron 3 especies de pinguino, se asume que esto 
# es un error
#Asimismo también se identificó el mismo error en la variable Sex 
#4 valores registrados para la una variable con solo 3 posibles 
#valores



# Variables a analizar
variables_analizar <- c(
  "...1",
  "Culmen Length (mm)", 
  "Culmen Depth (mm)", 
  "Flipper Length (mm)", 
  "Body Mass (g)", 
  "Sex", 
  "Delta 15 N (o/oo)", 
  "Delta 13 C (o/oo)"
)

# Función modificada para múltiples variables
filas_na <- datos_crudos %>%
  # Filtrar filas que tengan NA en AL MENOS UNA de las variables especificadas
  filter(if_any(all_of(variables_analizar), is.na)) %>%
  # Agregar número de fila original
  mutate(fila_numero = row_number()) %>%
  # Seleccionar columnas en el orden deseado
  select(
    fila_numero,
    all_of(variables_analizar),  # Variables de interés primero
    everything()                  # El resto de variables después
  ) %>%
  # Agregar columna que indique en cuáles variables tiene NA
  mutate(
    variables_con_na = apply(
      select(., all_of(variables_analizar)), 
      1, 
      function(x) {
        vars_na <- variables_analizar[is.na(x)]
        if(length(vars_na) > 0) {
          paste(vars_na, collapse = ", ")
        } else {
          "Ninguna"
        }
      }
    ),
    numero_variables_na = apply(
      select(., all_of(variables_analizar)), 
      1, 
      function(x) sum(is.na(x))
    )
  ) %>%
  # Reordenar columnas para mejor visualización
  select(
    fila_numero,
    numero_variables_na,
    variables_con_na,
    all_of(variables_analizar),
    everything()
  ) %>%
  # Ordenar por número de NA (de mayor a menor)
  arrange(desc(numero_variables_na), fila_numero)



#Eliminar todas las observaciones con más de 2 NA sin contar la variable Comments
# Observaiones: 4, 272, 9, 12 y 48 

datos_sin_na<- datos_crudos[-c(4,9,12,48,272),]



#Corregir las observaciones mal escritas 

# Lista de valores correctos que deberían aparecer
valores_correctos <- c("MALE", "FEMALE", "Chinstrap penguin (Pygoscelis antarctica)", 
                       "Adelie Penguin (Pygoscelis adeliae)", 
                       "Gentoo penguin (Pygoscelis papua)")

# 
datos_limpios <- datos_sin_na %>%
  # Limpiar espacios y convertir a formato estándar
  mutate(
    # Sex: todo a MAYÚSCULAS y estandarizar
    Sex = str_to_upper(str_trim(Sex)),
    Sex = case_when(
      Sex %in% c("MALE", "M", "M.", "MALE.", "Male") ~ "MALE",
      Sex %in% c("FEMALE", "F", "F.", "FEMALE.", "FEM.", "Female") ~ "FEMALE",
      TRUE ~ Sex
    ),
    
    # Species: estandarizar nombres científicos
    Species = case_when(
      str_detect(Species, "(?i)chinstrap|antarctica") ~ 
        "Chinstrap penguin (Pygoscelis antarctica)",
      str_detect(Species, "(?i)adeli") ~ 
        "Adelie Penguin (Pygoscelis adeliae)",
      str_detect(Species, "(?i)gentoo|papua") ~ 
        "Gentoo penguin (Pygoscelis papua)",
      TRUE ~ Species
    )
  )

# Ver resultado
cat("Valores únicos en Sex:\n")
print(unique(datos_limpios$Sex))

cat("\nValores únicos en Species:\n")
print(unique(datos_limpios$Species))

#ANÁLISIS POSTERIOR
resumen_var2 <- datos_limpios %>%
  summarise(across(everything(),
                   list(
                     Tipo = ~class(.)[1],
                     N_Observaciones = ~n(),
                     No_NA = ~sum(!is.na(.)),
                     NA_count = ~sum(is.na(.)),
                     Porcentaje_NA = ~round(mean(is.na(.)) * 100, 2),
                     Valores_Unicos = ~n_distinct(., na.rm = TRUE)
                   ))) %>%
  pivot_longer(everything(),
               names_to = c("Variable", ".value"),
               names_sep = "_")

# NA en 
# Sex = 6
# Delta 15 N (o/oo) = 9
# Delta 15 N (o/oo) = 8
# Comments = 290
write_csv(x= datos_limpios, file= "datos/curados/datos_r_EAJI_.csv")


