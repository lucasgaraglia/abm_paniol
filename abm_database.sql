CREATE DATABASE panol;

USE panol;

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE subcategorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE consumibles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    unidad INT NOT NULL,
    cantidad INT NOT NULL,
    imagen VARCHAR(500),
    subcategoria_id INT,
    FOREIGN KEY (subcategoria_id) REFERENCES subcategorias(id)
);

CREATE TABLE tipos_herramienta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    cantidad INT,
    disponibles INT,
    subcategoria_id INT,
    FOREIGN KEY (subcategoria_id) REFERENCES subcategorias(id)
);

CREATE TABLE herramientas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    observaciones VARCHAR(500),
    imagen VARCHAR(500),
    tipo_id INT,
    FOREIGN KEY (tipo_id) REFERENCES tipos_herramienta(id)
);

CREATE TABLE baja_herramientas (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    observaciones VARCHAR(500),
    tipo_id INT,
    FOREIGN KEY (tipo_id) REFERENCES tipos_herramienta(id)
);

-- CREATE TABLE registro_abm (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     movimiento VARCHAR(255),
--     fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP
-- );

-- CREATE TABLE herramienta_registro (
--     herramienta_id INT,
--     registro_id INT,
--     FOREIGN KEY (herramienta_id) REFERENCES herramientas(id)
--     FOREIGN KEY (registro_id) REFERENCES registro_abm(id)
-- );

-- CREATE TABLE consumible_registro (
--     consumible_id INT,
--     registro_id INT,
--     FOREIGN KEY (herramienta_id) REFERENCES herramientas(id)
--     FOREIGN KEY (registro_id) REFERENCES registro_abm(id)
-- );

-- CREATE TABLE herramienta_registro (
--     herramienta_id INT,
--     registro_id INT,
--     FOREIGN KEY (herramienta_id) REFERENCES herramientas(id)
--     FOREIGN KEY (registro_id) REFERENCES registro_abm(id)
-- );
