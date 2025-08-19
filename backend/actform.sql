create database actform;
use actform;

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_empresa VARCHAR(255) NOT NULL,
    ruc VARCHAR(13) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100)
);

-- Inserción de datos de ejemplo
INSERT INTO Clientes (nombre_empresa, ruc, telefono, email) VALUES
('Corporación Nacional de Electricidad CNEL EP', '0968599020001', '042208180', 'info@cnel.gob.ec'),
('Empresa Ejemplo 1', '0991234567001', '045551234', 'contacto@empresa1.com'),
('Empresa Ejemplo 2', '0987654321001', '045555678', 'info@empresa2.ec');

CREATE TABLE Direcciones (
    id_direccion INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    provincia VARCHAR(100),
    ciudad VARCHAR(100),
    direccion_detalle VARCHAR(255),
    nombre_sucursal VARCHAR(150), -- Por ejemplo: Agencia, Oficina, Subestación
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Proyectos (
    id_proyecto INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    nombre_proyecto VARCHAR(255) NOT NULL,
    numero_contrato VARCHAR(50) UNIQUE,
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Inserción de datos de ejemplo
INSERT INTO Proyectos (nombre_proyecto, numero_contrato) VALUES
('SERVICIO DE SOPORTE MANTENIMIENTO Y GARANTÍA DE LOS EQUIPOS DE NETWORKING HUAWEI DE CNEL EP GTI', 'CNEL-OFC-GJ-006-2024');

CREATE TABLE Tipos_Equipo (
    id_tipo_equipo INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(100) NOT NULL
);

-- Inserción de categorías de ejemplo
INSERT INTO Tipos_Equipo (nombre_categoria) VALUES
('Networking'),
('Servidores'),
('Almacenamiento');

CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY AUTO_INCREMENT,
    id_tipo_equipo INT,
    modelo VARCHAR(100),
    numero_serie VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (id_tipo_equipo) REFERENCES Tipos_Equipo(id_tipo_equipo)
);

CREATE TABLE Tareas (
    id_tarea INT PRIMARY KEY AUTO_INCREMENT,
    descripcion TEXT NOT NULL
);

INSERT INTO Tareas (descripcion) VALUES
('Limpieza y organización de racks, equipos y ventiladores.'),
('Aplicación y ejecución del protocolo de mantenimiento.'),
('Solventar inconvenientes menores en caso de suscitarse o requerirlo.'),
('Colocar etiqueta del mantenimiento correspondiente.'),
('Peinado del cableado del equipo.'),
('Verificar conexiones de datos y energía.'),
('Verificar alarmas visuales externas.'),
('Obtencion de Backup de configuracion del equipo.');

CREATE TABLE Correctivos (
    id_correctivo INT PRIMARY KEY AUTO_INCREMENT,
    descripcion TEXT NOT NULL
);

INSERT INTO Correctivos (descripcion) VALUES
('Diagnóstico, verificación y solución problemas en forma remota.'),
('Diagnóstico, verificación y solución problemas en sitio.'),
('Traslado de los equipos para reparación correctiva.'),
('Reemplazo de tarjetas o módulos ópticos.'),
('Reemplazo de equipos.'),
('En caso de ser necesario, instalar parche o upgrade del equipo.'),
('Troubleshooting en el caso de configuraciones.'),
('Verificar que el problema fue resuelto, agregar al informe.');

CREATE TABLE Diagnosticos (
    id_diagnostico INT PRIMARY KEY AUTO_INCREMENT,
    descripcion TEXT NOT NULL
);

INSERT INTO Diagnosticos (descripcion) VALUES
('Revisión de estado por comandos sin alarmas en "display alarm active | include Major".'),
('Ejecución de comando "display health"/"display environment" ó "displaytemperatureall" y revisar que el campo STATUS sea NORMAL ó la temperatura esté entre 0 y 60.'),
('Ejecución de comando "display health"/"display power" y revisar que el campo STATE presente información de las fuentes de poder instaladas o presente NORMAL.'),
('Ejecución de comando "display health"/"display fan verbose" y revisar que el campo REGISTER presente YES para los ventiladores o tenga status NORMAL.'),
('Ejecución de comando "display health"/"display cpu-usage" y revisar que el CPU USAGE sea inferior a 80%.'),
('Ejecución de comando "display health"/"display memory-usage" y revisar que el USED PERCENTAGE de Memoria sea inferior a 60%.'),
('Ejecución de comando "display health"/"dir" y revisar que el USED PERCENTAGE de Disco sea inferior a 80% o que el espacio libre corresponda al 80%.'),
('Ejecución de comando "display device" y revisar que las tarjetas estén con estados: Online es PRESENT, Register es REGISTERED, Power es POWERON, Alarm es NORMAL.');

CREATE TABLE Actividades_Mantenimiento (
    id_actividad INT PRIMARY KEY AUTO_INCREMENT,
    id_equipo INT,
    id_proyecto INT,
    id_direccion INT,
    fecha_mantenimiento DATE,
    tipo_mantenimiento ENUM('Preventivo', 'Correctivo'),
    observacion_general TEXT,
    version_firmware_actual VARCHAR(100),
    version_firmware_actualizada VARCHAR(100),
    obs_actualizacion TEXT,
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id_equipo),
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto),
    FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion)
);

CREATE TABLE Actividad_Tareas (
    id_actividad INT,
    id_tarea INT,
    PRIMARY KEY (id_actividad, id_tarea),
    FOREIGN KEY (id_actividad) REFERENCES Actividades_Mantenimiento(id_actividad),
    FOREIGN KEY (id_tarea) REFERENCES Tareas(id_tarea)
);

CREATE TABLE Actividad_Correctivos (
    id_actividad INT,
    id_correctivo INT,
    PRIMARY KEY (id_actividad, id_correctivo),
    FOREIGN KEY (id_actividad) REFERENCES Actividades_Mantenimiento(id_actividad),
    FOREIGN KEY (id_correctivo) REFERENCES Correctivos(id_correctivo)
);

CREATE TABLE Actividad_Diagnosticos (
    id_actividad INT,
    id_diagnostico INT,
    PRIMARY KEY (id_actividad, id_diagnostico),
    FOREIGN KEY (id_actividad) REFERENCES Actividades_Mantenimiento(id_actividad),
    FOREIGN KEY (id_diagnostico) REFERENCES Diagnosticos(id_diagnostico)
);

CREATE TABLE Delegados (
    id_delegado VARCHAR(10) PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cargo VARCHAR(100),
    empresa_pertenece VARCHAR(150) -- Ejemplo: 'CNEL EP' o 'CREATIC S.A.'
);

-- Inserción de delegados de ejemplo
INSERT INTO Delegados (id_delegado, nombres, apellidos, cargo, empresa_pertenece) VALUES
('0912345678', 'Juan', 'Pérez', 'Técnico de Campo', 'CREATIC S.A.'),
('0987654321', 'Ana', 'Gómez', 'Supervisora TI', 'CNEL EP'),
('0998765432', 'Carlos', 'Martínez', 'Gerente de Proyecto', 'CREATIC S.A.');

CREATE TABLE Imagenes_Evidencia (
    id_img INT PRIMARY KEY AUTO_INCREMENT,
    id_actividad INT,
    ruta_imagen VARCHAR(255) NOT NULL,
    descripcion TEXT,
    FOREIGN KEY (id_actividad) REFERENCES Actividades_Mantenimiento(id_actividad)
);

CREATE TABLE Capturas_Comandos (
    id_captura INT PRIMARY KEY AUTO_INCREMENT,
    id_actividad INT,
    ruta_captura VARCHAR(255) NOT NULL,
    descripcion TEXT,
    FOREIGN KEY (id_actividad) REFERENCES Actividades_Mantenimiento(id_actividad)
);

