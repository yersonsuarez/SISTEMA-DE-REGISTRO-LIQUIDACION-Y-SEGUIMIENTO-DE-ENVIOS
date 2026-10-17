-- CREAR BASE SQLITE DEL PROYECTO DE ENVÍOS

-- Sistema de Registro, Liquidación y Seguimiento de Envíos

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS clientes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    documento TEXT NOT NULL UNIQUE CHECK (length(trim(documento)) BETWEEN 3 AND 20),
    nombre TEXT NOT NULL CHECK (length(trim(nombre)) BETWEEN 3 AND 100),
    telefono TEXT NOT NULL CHECK (length(trim(telefono)) BETWEEN 7 AND 20),
    direccion TEXT NOT NULL CHECK (length(trim(direccion)) BETWEEN 5 AND 160)
);

CREATE TABLE IF NOT EXISTS destinos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ciudad TEXT NOT NULL UNIQUE,
    tarifa_base_centavos INTEGER NOT NULL CHECK (tarifa_base_centavos >= 0),
    tarifa_kg_centavos INTEGER NOT NULL CHECK (tarifa_kg_centavos >= 0)
);

CREATE TABLE IF NOT EXISTS tipos_mercancia (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    recargo_porcentaje INTEGER NOT NULL CHECK (recargo_porcentaje BETWEEN 0 AND 100)
);

CREATE TABLE IF NOT EXISTS envios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    guia TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL,
    remitente_id INTEGER NOT NULL REFERENCES clientes(id) ON DELETE RESTRICT,
    destinatario_id INTEGER NOT NULL REFERENCES clientes(id) ON DELETE RESTRICT,
    destino_id INTEGER NOT NULL REFERENCES destinos(id) ON DELETE RESTRICT,
    tipo_mercancia_id INTEGER NOT NULL REFERENCES tipos_mercancia(id) ON DELETE RESTRICT,
    peso_gramos INTEGER NOT NULL CHECK (typeof(peso_gramos) = 'integer' AND peso_gramos BETWEEN 1 AND 100000000),
    valor_declarado_centavos INTEGER NOT NULL CHECK (typeof(valor_declarado_centavos) = 'integer' AND valor_declarado_centavos BETWEEN 0 AND 1000000000000),
    direccion_entrega TEXT NOT NULL CHECK (length(trim(direccion_entrega)) BETWEEN 5 AND 160),
    estado TEXT NOT NULL CHECK (estado IN ('REGISTRADO','EN_TRANSITO','EN_REPARTO','ENTREGADO')),
    flete_centavos INTEGER NOT NULL CHECK (typeof(flete_centavos) = 'integer' AND flete_centavos >= 0),
    seguro_centavos INTEGER NOT NULL CHECK (typeof(seguro_centavos) = 'integer' AND seguro_centavos >= 0),
    total_centavos INTEGER NOT NULL CHECK (typeof(total_centavos) = 'integer' AND total_centavos = flete_centavos + seguro_centavos),
    observaciones TEXT NOT NULL DEFAULT '' CHECK (length(observaciones) <= 255),
    CHECK (remitente_id <> destinatario_id)
);

CREATE TABLE IF NOT EXISTS historial_estados (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    envio_id INTEGER NOT NULL REFERENCES envios(id) ON DELETE CASCADE,
    estado TEXT NOT NULL CHECK (estado IN ('REGISTRADO','EN_TRANSITO','EN_REPARTO','ENTREGADO')),
    fecha TEXT NOT NULL,
    observacion TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_envios_destino ON envios(destino_id);
CREATE INDEX IF NOT EXISTS idx_envios_estado ON envios(estado);
CREATE INDEX IF NOT EXISTS idx_historial_envio ON historial_estados(envio_id, id);
PRAGMA user_version = 1;

-- DATOS DEL PROYECTO ACADÉMICO.

PRAGMA foreign_keys = ON;

INSERT INTO clientes (id,documento,nombre,telefono,direccion) VALUES
 (1,'900000001','Comercial Andina','3000000001','Calle 36 # 15-22, Bucaramanga'),
 (2,'900000002','Papelería Horizonte','3000000002','Carrera 7 # 22-16, Bogotá'),
 (3,'900000003','Distribuciones Norte','3000000003','Calle 10 # 5-42, Cúcuta'),
 (4,'1099000004','Laura Pérez','3000000004','Carrera 80 # 45-20, Medellín'),
 (5,'900000005','Repuestos El Parque','3000000005','Calle 45 # 27-30, Bucaramanga'),
 (6,'900000006','Librería Capital','3000000006','Carrera 13 # 54-28, Bogotá'),
 (7,'1099000007','Carlos Ramírez','3000000007','Avenida 6 # 13-18, Cúcuta'),
 (8,'1099000008','Camila Torres','3000000008','Calle 30 # 76-15, Medellín'),
 (9,'1099000009','Diana Rojas','3000000009','Carrera 27 # 42-10, Bucaramanga'),
 (10,'900000010','Tecnología Andes','3000000010','Calle 72 # 10-34, Bogotá');

-- Base y valor por kilogramo, en centavos de COP.
INSERT INTO destinos (id,ciudad,tarifa_base_centavos,tarifa_kg_centavos) VALUES
 (1,'Bucaramanga',1000000,120000),
 (2,'Cúcuta',1200000,150000),
 (3,'Bogotá',1500000,180000),
 (4,'Medellín',1600000,200000);

INSERT INTO tipos_mercancia (id,nombre,recargo_porcentaje) VALUES
 (1,'General',0),
 (2,'Frágil',20),
 (3,'Documentos',0);

-- Guías 1 a 12: tres envíos en cada uno de los cuatro estados.
INSERT INTO envios (id,guia,fecha_registro,remitente_id,destinatario_id,destino_id,tipo_mercancia_id,peso_gramos,valor_declarado_centavos,direccion_entrega,estado,flete_centavos,seguro_centavos,total_centavos,observaciones) VALUES
 (1,'ENV-000001','2026-10-07T08:00:00',1,2,3,1,10000,45000000,'Carrera 7 # 22-16, Bogotá','ENTREGADO',3300000,450000,3750000,'Dos cajas de papelería'),
 (2,'ENV-000002','2026-10-08T09:00:00',2,3,2,1,7500,30000000,'Calle 10 # 5-42, Cúcuta','ENTREGADO',2325000,300000,2625000,'Caja con útiles de oficina'),
 (3,'ENV-000003','2026-10-09T10:00:00',3,4,4,2,4000,50000000,'Carrera 80 # 45-20, Medellín','ENTREGADO',2880000,500000,3380000,'Vajilla protegida en una caja'),
 (4,'ENV-000004','2026-10-12T08:00:00',4,5,1,1,12000,60000000,'Calle 45 # 27-30, Bucaramanga','EN_REPARTO',2440000,600000,3040000,'Dos cajas de repuestos'),
 (5,'ENV-000005','2026-10-13T09:00:00',5,6,3,3,500,0,'Carrera 13 # 54-28, Bogotá','EN_REPARTO',1590000,0,1590000,'Sobre con documentos comerciales'),
 (6,'ENV-000006','2026-10-13T10:00:00',6,7,2,1,6800,25000000,'Avenida 6 # 13-18, Cúcuta','EN_REPARTO',2220000,250000,2470000,'Caja con libros'),
 (7,'ENV-000007','2026-10-14T11:00:00',7,8,4,2,8000,70000000,'Calle 30 # 76-15, Medellín','EN_TRANSITO',3840000,700000,4540000,'Lámpara embalada con protección'),
 (8,'ENV-000008','2026-10-15T08:00:00',8,9,1,1,15000,90000000,'Carrera 27 # 42-10, Bucaramanga','EN_TRANSITO',2800000,900000,3700000,'Tres cajas con artículos de hogar'),
 (9,'ENV-000009','2026-10-15T09:00:00',9,10,3,2,2500,20000000,'Calle 72 # 10-34, Bogotá','EN_TRANSITO',2340000,200000,2540000,'Accesorios electrónicos protegidos'),
 (10,'ENV-000010','2026-10-16T08:00:00',10,1,1,3,250,0,'Calle 36 # 15-22, Bucaramanga','REGISTRADO',1030000,0,1030000,'Sobre con documentos administrativos'),
 (11,'ENV-000011','2026-10-16T09:00:00',1,7,2,1,20000,120000000,'Avenida 6 # 13-18, Cúcuta','REGISTRADO',4200000,1200000,5400000,'Cuatro cajas de mercancía general'),
 (12,'ENV-000012','2026-10-16T10:30:00',3,4,4,2,3750,45000000,'Carrera 80 # 45-20, Medellín','REGISTRADO',2820000,450000,3270000,'Artículos de vidrio con protección');

-- Cada historial empieza en Registrado y termina en el estado actual del envío.
INSERT INTO historial_estados (id,envio_id,estado,fecha,observacion) VALUES
 (1,1,'REGISTRADO','2026-10-07T08:00:00','Registro inicial del envío'),
 (2,1,'EN_TRANSITO','2026-10-07T17:00:00','Salida hacia la ciudad de destino'),
 (3,1,'EN_REPARTO','2026-10-08T08:00:00','Asignado a ruta de reparto'),
 (4,1,'ENTREGADO','2026-10-08T11:00:00','Entrega confirmada por el destinatario'),
 (5,2,'REGISTRADO','2026-10-08T09:00:00','Registro inicial del envío'),
 (6,2,'EN_TRANSITO','2026-10-08T18:00:00','Salida hacia la ciudad de destino'),
 (7,2,'EN_REPARTO','2026-10-09T08:30:00','Asignado a ruta de reparto'),
 (8,2,'ENTREGADO','2026-10-09T14:00:00','Entrega confirmada por el destinatario'),
 (9,3,'REGISTRADO','2026-10-09T10:00:00','Registro inicial del envío'),
 (10,3,'EN_TRANSITO','2026-10-09T19:00:00','Salida hacia la ciudad de destino'),
 (11,3,'EN_REPARTO','2026-10-10T09:00:00','Asignado a ruta de reparto'),
 (12,3,'ENTREGADO','2026-10-10T12:00:00','Entrega confirmada por el destinatario'),
 (13,4,'REGISTRADO','2026-10-12T08:00:00','Registro inicial del envío'),
 (14,4,'EN_TRANSITO','2026-10-13T07:00:00','Salida hacia la ciudad de destino'),
 (15,4,'EN_REPARTO','2026-10-16T08:00:00','Asignado a ruta de reparto'),
 (16,5,'REGISTRADO','2026-10-13T09:00:00','Registro inicial del envío'),
 (17,5,'EN_TRANSITO','2026-10-14T06:00:00','Salida hacia la ciudad de destino'),
 (18,5,'EN_REPARTO','2026-10-16T08:30:00','Asignado a ruta de reparto'),
 (19,6,'REGISTRADO','2026-10-13T10:00:00','Registro inicial del envío'),
 (20,6,'EN_TRANSITO','2026-10-14T07:00:00','Salida hacia la ciudad de destino'),
 (21,6,'EN_REPARTO','2026-10-16T09:00:00','Asignado a ruta de reparto'),
 (22,7,'REGISTRADO','2026-10-14T11:00:00','Registro inicial del envío'),
 (23,7,'EN_TRANSITO','2026-10-15T06:00:00','Salida hacia la ciudad de destino'),
 (24,8,'REGISTRADO','2026-10-15T08:00:00','Registro inicial del envío'),
 (25,8,'EN_TRANSITO','2026-10-16T06:00:00','Salida hacia la ciudad de destino'),
 (26,9,'REGISTRADO','2026-10-15T09:00:00','Registro inicial del envío'),
 (27,9,'EN_TRANSITO','2026-10-16T07:00:00','Salida hacia la ciudad de destino'),
 (28,10,'REGISTRADO','2026-10-16T08:00:00','Registro inicial del envío'),
 (29,11,'REGISTRADO','2026-10-16T09:00:00','Registro inicial del envío'),
 (30,12,'REGISTRADO','2026-10-16T10:30:00','Registro inicial del envío');
