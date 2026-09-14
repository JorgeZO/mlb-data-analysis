-- Ejecutar antes de importar los CSV. No elimina datos existentes.
CREATE DATABASE IF NOT EXISTS mlb_analytics CHARACTER SET utf8mb4;
USE mlb_analytics;

CREATE TABLE IF NOT EXISTS equipos (
    equipo_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    liga VARCHAR(100) NOT NULL,
    division VARCHAR(100) NOT NULL,
    temporada INT NOT NULL,
    PRIMARY KEY (equipo_id, temporada)
);

CREATE TABLE IF NOT EXISTS bateadores (
    jugador_id INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    temporada INT NOT NULL,
    hits INT NOT NULL,
    turnos INT NOT NULL,
    home_runs INT NOT NULL,
    apariciones_plato INT NOT NULL,
    numero_equipos INT NOT NULL,
    PRIMARY KEY (jugador_id, temporada)
);
