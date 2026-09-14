# Informe de Power BI

## Preparación

Importar `data/processed/resumen_bateadores_2025.csv`.

- `nombre`: texto.
- `jugador_id`, `temporada`, `hits`, `turnos`, `home_runs`, `apariciones_plato` y `numero_equipos`: número entero.
- `promedio_bateo` y `hr_por_100_apariciones`: número decimal, usando configuración regional **Inglés (Estados Unidos)** para interpretar el punto del CSV.

Si la detección automática transforma `0.331` en `331`, eliminar ese paso de conversión y asignar los tipos desde los valores originales. Cambiar solamente el formato visual no recupera el decimal perdido.

## Visuales construidos

- Tabla por nombre con hits, turnos y home runs.
- Gráfico de barras: `nombre` en eje Y y suma de `home_runs` en eje X.
- Filtro visual sobre nombre: Top N, Superior 10, por suma de home_runs.
- Orden descendente por home_runs.
- Título: **Top 10 por home runs — incluye empates**.

En la extracción guardada aparecen 12 jugadores por un empate de tres jugadores con 36 HR en el puesto 10.

## Pendiente de presentación

La visualización de `promedio_bateo` necesita formato de tres decimales y no debe sumar promedios. Se decidió retirarla temporalmente de la tabla hasta completar el ajuste. También están pendientes tarjetas, filtros adicionales y un ranking de eficiencia con un mínimo de participación. No forman parte de los resultados terminados.

Para publicar una captura, usar una exportación limpia del informe guardado, sin la interfaz del navegador ni columnas con formato incorrecto.
