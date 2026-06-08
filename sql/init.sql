-- Script de inicialización de la base de datos
-- Se ejecuta automáticamente al levantar el contenedor MySQL

CREATE DATABASE IF NOT EXISTS Sucursal
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE Sucursal;

CREATE TABLE IF NOT EXISTS vehiculos (
  id               BIGINT        NOT NULL AUTO_INCREMENT,
  marca            VARCHAR(255)  DEFAULT NULL,
  modelo           VARCHAR(255)  DEFAULT NULL,
  ano              INT           DEFAULT NULL,
  color            VARCHAR(255)  DEFAULT NULL,
  tipo_combustible VARCHAR(255)  DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Datos de prueba
INSERT INTO vehiculos (marca, modelo, ano, color, tipo_combustible) VALUES
  ('Toyota',    'Corolla', 2022, 'Blanco',   'Bencina'),
  ('Honda',     'Civic',   2021, 'Negro',    'Bencina'),
  ('Chevrolet', 'Spark',   2023, 'Rojo',     'Bencina'),
  ('Nissan',    'Leaf',    2023, 'Azul',     'Eléctrico'),
  ('Toyota',    'Hilux',   2022, 'Gris',     'Diesel');
