USE mlb_analytics;

SELECT COUNT(*) AS total_equipos FROM equipos;

SELECT liga, COUNT(*) AS total_equipos
FROM equipos
GROUP BY liga;

SELECT division, COUNT(*) AS total_equipos
FROM equipos
GROUP BY division;

SELECT nombre
FROM equipos
WHERE division = 'American League West'
ORDER BY nombre ASC;
