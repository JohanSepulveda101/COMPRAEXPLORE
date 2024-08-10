-- -----------------------------------------------------
-- Estructura de Base de Datos DB_BIBLIOTECA
-- -----------------------------------------------------

CREATE DATABASE DB_BIBLIOTECA DEFAULT CHARACTER SET utf8 ;

-- -----------------------------------------------------
-- Tabla EDITORIALES
-- -----------------------------------------------------
CREATE TABLE EDITORIALES (
  editorial_clave INT(10) NOT NULL,
  editorial_nombre VARCHAR(45) NOT NULL,
  editorial_direccion VARCHAR(45) NOT NULL,
  editorial_telefono INT(10) NOT NULL,
  PRIMARY KEY (editorial_clave))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla LIBROS
-- ------------------------------s-----------------------
CREATE TABLE LIBROS ( 
  libro_clave INT NOT NULL AUTO_INCREMENT COMMENT Llave primaria, autoincremental para gestionar los registros nuevos,
  editorial_clave INT NOT NULL,
  libro_titulo VARCHAR(100) NOT NULL,
  libro_idioma VARCHAR(20) NOT NULL,
  libro_categori VARCHAR(50) NOT NULL,
  libro_formato VARCHAR(20) NOT NULL,
  PRIMARY KEY (libro_clave),
  INDEX ind_libro_editorial (editorial_clave ASC) VISIBLE,
  CONSTRAINT fk_libro_editorial
    FOREIGN KEY (editorial_clave)
    REFERENCES db_biblioteca.EDITORIALES (editorial_clave)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla TEMAS 
-- -----------------------------------------------------
CREATE TABLE TEMAS (
  tema_clave INT(10) NOT NULL,
  tema_nombre VARCHAR(60) NOT NULL,
  PRIMARY KEY (tema_clave))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla AUTORES
-- -----------------------------------------------------
CREATE TABLE AUTORES (
  autor_clave INT(10) NOT NULL,
  autor_nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (autor_clave))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla EJEMPLARES
-- -----------------------------------------------------
CREATE TABLE EJEMPLARES (
  libro_clave INT NOT NULL,
  ejemplar_orden INT(100) NOT NULL,
  ejemplar_ubicacion VARCHAR(30) NOT NULL,
  ejemplar_edicion INT(50) NOT NULL,
  INDEX ind_ejemplar_libro (libro_clave ASC) VISIBLE,
  CONSTRAINT fk_ejemplar_libro
    FOREIGN KEY (libro_clave)
    REFERENCES db_biblioteca.LIBROS (libro_clave)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla SOCIOS
-- -----------------------------------------------------
CREATE TABLE SOCIOS (
  socio_clave INT(10) NOT NULL,
  socio_nombre VARCHAR(45) NOT NULL,
  socio_direccion VARCHAR(45) NOT NULL,
  socio_categoria VARCHAR(45) NOT NULL,
  socio_telefono INT(10) NOT NULL,
  PRIMARY KEY (socio_clave))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla LIBROS_TEMAS
-- -----------------------------------------------------
CREATE TABLE LIBROS_TEMAS (
  libro_clave INT NOT NULL,
  tema_clave INT NOT NULL,
  INDEX ind_libro_tema_libro (libro_clave ASC) INVISIBLE,
  INDEX ind_libro_tema_tema (tema_clave ASC) VISIBLE,
  CONSTRAINT fk_libro_tema_libro
    FOREIGN KEY (libro_clave)
    REFERENCES db_biblioteca . LIBROS (libro_clave)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_libro_tema_tema
    FOREIGN KEY (tema_clave)
    REFERENCES db_biblioteca . TEMAS (tema_clave)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla LIBROS_AUTORES
-- -----------------------------------------------------
CREATE TABLE LIBROS_AUTORES (
  libro_clave INT NOT NULL,
  autor_clave INT NOT NULL,
  INDEX ind_libro_autor_libro (libro_clave ASC) INVISIBLE,
  INDEX ind_libro_autor_autor (autor_clave ASC) VISIBLE,
  CONSTRAINT fk_libro_autor_libro
    FOREIGN KEY (libro_clave)
    REFERENCES db_biblioteca.LIBROS (libro_clave)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_libro_autor_autor
    FOREIGN KEY (autor_clave)
    REFERENCES db_biblioteca . AUTORES (autor_clave)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla PRESTAMOS
-- -----------------------------------------------------
CREATE TABLE PRESTAMOS (  
  socio_clave INT NOT NULL,
  libro_clave INT NOT NULL,
  prestamo_fecha_prestamo DATE NOT NULL,
  prestamo_fecha_devolucion DATE NOT NULL,
  prestamo_notas VARCHAR(200) NULL,
  INDEX ind_prestamo_socio (socio_clave ASC) VISIBLE,
  INDEX ind_prestamo_ejempla (libro_clave ASC) VISIBLE,
  CONSTRAINT fk_prestamo_socio
    FOREIGN KEY (socio_clave)
    REFERENCES db_biblioteca .SOCIOS (socio_clave)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_prestamo_ejemplar
    FOREIGN KEY (libro_clave)
    REFERENCES db_biblioteca .EJEMPLARES (libro_clave)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

