<img src="./imagenes/ENES_Merida.jpg" width="25%">

# Ecología Teórica II — Ecoinformática  
## Ejercicio: Git + GitHub + RStudio para control de calidad de datos ecológicos

Este es un ejercicio práctico sobre **control de versiones** aplicado al **control de calidad (QC)** y exploración de datos ecológicos usando **GitHub** y **RStudio**.

---

## Objetivo

- Practicar el flujo colaborativo real: **clonar → crear rama → trabajar en archivos propios → commit → push → pull request**.
- Evitar conflictos: **cada estudiante trabajará en archivos propios** y **no se modificará la base de datos original**.

---

## Reglas del ejercicio (muy importantes)

1. **NO modificar** el archivo de datos original (`datos/original/datos.csv`).
2. Tu contribución debe quedar en `datos/curado/datos_r<ABC>.csv` siedno `r` indicador de revisado y `ABC` las iniciales de tu nombre, para que sea independiente y no genere conflictos en este ejercicio (p.ej. el mio es datos_rEGC.csv).
3. Tu entrega debe incluir **estos 3 archivos** (con tu usuario):

   - `codigos/qc_<tu_usuario>.R` → tu script de control de calidad  
   - `reportes/qc_<tu_usuario>.qmd` → tu reporte breve  
   - `datos/curados/datos_r<ABC>.csv` → tu versión limpia del dataset

---

## Instrucciones paso a paso

### 1) Clonar el repositorio principal

1. Ve al repositorio principal en GitHub (el que les compartí).
2. Copia la URL del repositorio (HTTPS).
3. En RStudio:
   - **File > New Project > Version Control > Git**
   - Pega la URL del repositorio
   - Elige una carpeta local
   - Clic en **Create Project**

---

### 2) Verificar que Git esté funcionando en RStudio

- Abre el proyecto y revisa que exista la pestaña **Git**.
- Si no aparece, **detente y avísame** antes de seguir.

---

### 3) Crear tu rama personal de trabajo

En RStudio, ubica el panel con la pestaña `Git`, y en la esquina derecha selecciona New Branch. Nómbralo con tu nombre y apellido sin espacios.

---

### 4) Crear tus archivos personales desde tu rama

1. **Verifica las carpetas necesarias**:
   - `codigos/`
   - `reportes/`
   - `datos/original/`
   - `datos/curados/`

2. **Crea tu script de control de calidad (QC)**:
   - Archivo: `codigos/QC_<tu_usuario>.R`

3. **Crea tu reporte breve** (Markdown o Quarto):
   - Archivo `reports/QC_<tu_usuario>.qmd`

4. **Tu dataset limpio (output)** se generará al correr tu script y debe guardarse:
   - Archivo: `datos/curados/datos_r<ABC>.csv`

---

### 5) Qué debe incluir tu QC (mínimos esperados)

En tu script `codigos/QC_<tu_usuario>.R` debes:

- Leer datos **desde el archivo crudo** (sin editarlo).
- Aplicar control de calidad usando `tidyverse`:
  - Revisión de tipos de datos (numérico, fecha, texto/categorías)
  - Valores faltantes (NA): cuántos hay y qué decisión tomar con ellos (documentar)
  - Homogenizar nombres de especies y corregirlos desde R
  - Crar una columna para año a partir de la columna de fechas
- Guardar tu dataset limpio en:
  - `datos/curados/datos_r<ABC>.csv`

En tu reporte `reportes/exploracion_<tu_usuario>.qmd` incluye:

- **5–10 viñetas** con:
  - Principales problemas detectados
  - Cambios aplicados (y por qué)
  - Qué NO corregiste (y por qué)
  - Cómo reproducir tu resultado

---

### 6) Commit de tus cambios

En RStudio, pestaña **Git**:

1. Marca (stage) los archivos que creaste/modificaste y luego presiona `commit`:

2. Escribe un mensaje de commit descriptivo de los que representa el cambio

3. Haz clic en **Commit**.

---

### 7) Push de tu rama a GitHub

En RStudio (pestaña **Git**) haz clic en **Push**.

> Si es el primer push de tu rama y te pide configurar upstream, acepta la opción sugerida para subir `qc/<tu_usuario>`.

---

### 8) Crear el Pull Request (PR)

En GitHub:

1. Entra al repositorio principal.
2. Si aparece el aviso, haz clic en **Compare & pull request**. Si no aparece, ve a **Pull requests > New pull request**.
3. Configura:
   - **Base:** `main` 
   - **Compare:** `qc/<tu_usuario>`

4. En la descripción del PR pega y completa:

**Descripción del PR**
- Usuario: `<tu_usuario>`
- Archivos entregados
- Problemas encontrados
- Cambios aplicados
- Pendientes / decisiones
- Reproducibilidad

5. Haz clic en **Create pull request**.

---

### 9) Revisión y aprobación

Yo revisaré tu Pull Request (PR) con una lista de cotejo. Se aprobará si:

- No modificaste el dataset crudo.
- Incluiste los **3 archivos requeridos** con tu usuario.
- Tu script corre y genera el output limpio.
- Tu reporte explica claramente tus decisiones.

---

### Nota final

Si aparece algún error (no aparece la pestaña Git, no deja hacer push, credenciales, etc.), **detente y levanta la mano**. Lo resolvemos en el momento.




**Prof. Edlin José Guerra Castro**
