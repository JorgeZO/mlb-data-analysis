-- Consultas trabajadas durante el proyecto, reunidas para reproducir el análisis.
USE mlb_analytics;

SELECT COUNT(*) AS total_bateadores FROM bateadores;

SELECT nombre, hits
FROM bateadores
WHERE hits > 10
ORDER BY hits DESC, jugador_id ASC
LIMIT 10;

-- LIMIT devuelve exactamente 10 filas; el identificador desempata.
-- El filtro Top N de Power BI incluye todos los empatados en el corte.
SELECT nombre, home_runs
FROM bateadores
ORDER BY home_runs DESC, jugador_id ASC
LIMIT 10;

-- Exportar este resultado a data/processed/resumen_bateadores_2025.csv.
-- La precisión decimal explícita evita pérdida de precisión antes de ROUND.
-- NULLIF evita dividir entre cero. No sumar los promedios en Power BI.
SELECT jugador_id, nombre, temporada, hits, turnos, home_runs,
       apariciones_plato, numero_equipos,
       ROUND(CAST(hits AS DECIMAL(20, 10)) / NULLIF(turnos, 0), 3) AS promedio_bateo,
       ROUND(100 * CAST(home_runs AS DECIMAL(20, 10)) / NULLIF(apariciones_plato, 0), 2)
           AS hr_por_100_apariciones
FROM bateadores
ORDER BY promedio_bateo DESC, turnos DESC;
