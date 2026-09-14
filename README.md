# Análisis de bateadores de MLB 2025

Proyecto personal de aprendizaje de análisis de datos con **Python, Pandas, MySQL y Power BI**. Explora estadísticas ofensivas de la temporada regular 2025: volumen de hits y home runs, y métricas relativas a las oportunidades al bate.

## Resultados en los datos guardados

- 30 equipos y 765 registros únicos de jugador y temporada.
- Cal Raleigh lidera los home runs con **60**; Bobby Witt Jr. lidera los hits con **184**.
- Nick Kurtz, Riley Greene y Taylor Ward tienen **36 home runs**. El filtro Top N de Power BI muestra 12 jugadores al incluir el empate en el puesto 10.
- Se comprobaron datos faltantes, claves duplicadas y coherencia entre hits, turnos y apariciones al plato.

Estos resultados corresponden a la **extracción guardada**, no se presentan como estadísticas definitivas al cierre de 2025. No se registró la fecha exacta de extracción. La API puede devolver valores actualizados al ejecutar otra vez el notebook.

## Flujo del proyecto

**API de MLB → Python/Pandas → CSV → MySQL → CSV de indicadores → Power BI**

1. Explorar la respuesta JSON y extraer campos anidados.
2. Construir y validar las tablas de equipos y bateadores.
3. Importar los datos a MySQL y consultar rankings e indicadores.
4. Crear una tabla y un gráfico de barras con filtro Top N en Power BI.

## Archivos

| Ruta | Contenido |
| --- | --- |
| `notebooks/01_exploracion_api.ipynb` | Exploración guiada de la API, transformación, validaciones y exportación |
| `sql/00_crear_tablas.sql` | Base de datos y estructura de tablas |
| `sql/01_exploracion_equipos.sql` | Conteos por liga y división |
| `sql/02_analisis_bateadores.sql` | Rankings y cálculo de indicadores |
| `data/processed/` | Extracción CSV y resumen utilizado en Power BI |
| `scripts/generar_resumen.py` | Regenera indicadores con precisión decimal explícita |
| `docs/powerbi.md` | Configuración del informe y limitaciones pendientes |

## Reproducir el análisis

### Python

Desde la raíz del repositorio, con Python 3.10 o superior:

```bash
python -m venv .venv
# macOS/Linux:
source .venv/bin/activate
# Windows PowerShell: .venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
python -m jupyterlab
```

Abrir `notebooks/01_exploracion_api.ipynb` y ejecutar las celdas en orden, con el directorio de trabajo del kernel en `notebooks/`. El notebook usa rutas relativas y vuelve a escribir los CSV de equipos y bateadores; conservar una copia si se desea mantener esta extracción. No requiere credenciales de MySQL ni una clave de API. La celda de exportación JSON es una alternativa para problemas de importación UTF-8 en Workbench.

### MySQL

1. Ejecutar `sql/00_crear_tablas.sql` en MySQL Workbench.
2. Usar **Table Data Import Wizard** para importar `equipos_2025.csv` y `bateadores_2025.csv` a sus tablas respectivas. Importar cada archivo una sola vez en tablas vacías.
3. Ejecutar los archivos SQL de exploración y análisis.
4. Exportar la última consulta a `resumen_bateadores_2025.csv` si se desea actualizar el informe.

Para regenerar el mismo resumen desde los CSV sin MySQL:

```bash
python scripts/generar_resumen.py
```

Al preparar el repositorio se verificaron los cocientes con aritmética decimal y se corrigieron 37 promedios que diferían en 0.001. La consulta SQL ahora especifica precisión decimal antes de redondear. El informe web anterior necesita recargar el CSV corregido; el ranking de home runs no cambia.

### Power BI

Importar `data/processed/resumen_bateadores_2025.csv` y seguir [la configuración del informe](docs/powerbi.md). El informe se construyó en Power BI web; todavía no se incluye un archivo PBIX ni una versión pública del informe.

## Criterios del análisis

- `turnos` representa **at-bats**, no apariciones al plato.
- Promedio de bateo = `hits / turnos`.
- Home runs por 100 apariciones = `100 × home_runs / apariciones_plato`.
- Una división entre cero produce un valor nulo, no cero.
- Las estadísticas son por jugador y temporada. Un jugador puede haber estado en varios equipos; no se atribuyen todos sus resultados a un solo equipo.
- El ranking por home runs compara volumen. Un ranking por promedio necesita un umbral de participación, pendiente de definir.

## Estado y próximos pasos

La extracción, las consultas SQL y el ranking de home runs están realizados. Queda mejorar el formato del promedio en Power BI, añadir tarjetas de indicadores y comparar eficiencia con un mínimo de participación. Los promedios individuales no deben sumarse; un promedio agregado debe calcularse con hits totales divididos entre turnos totales.

## Fuente y proceso de aprendizaje

Datos consultados en [MLB Stats API](https://statsapi.mlb.com/api/v1/stats?stats=season&group=hitting&season=2025&sportIds=1&gameType=R&playerPool=ALL&limit=765) y [equipos](https://statsapi.mlb.com/api/v1/teams?sportId=1&season=2025). Los datos y las marcas pertenecen a sus respectivos titulares; este proyecto no está afiliado a MLB.

Proyecto desarrollado como práctica de aprendizaje con apoyo de IA para explicación de código, resolución de errores y documentación. El notebook conserva los pasos de exploración para mostrar cómo se construyó el análisis.
