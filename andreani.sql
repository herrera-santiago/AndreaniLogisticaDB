-- CREACIÓN DE BASE DE DATOS
CREATE DATABASE AndreaniLogisticaDB;
GO

USE AndreaniLogisticaDB;
GO

-- CREACION DE TABLAS

CREATE TABLE TipoCliente (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE EstadoPedido (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE EstadoLote (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE TipoVehiculo (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    refrigeracion BIT NOT NULL CHECK (refrigeracion IN (0,1)),
    capacidad BOOL NOT NULL CHECK (capacidad IN (0,1))
);

CREATE TABLE Cliente (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    idTipoCliente INT NOT NULL,
    cuit CHAR(11) NOT NULL,
    direccion VARCHAR(255),
    activo BIT NOT NULL CHECK (activo IN (0,1)),
    FOREIGN KEY (idTipoCliente) REFERENCES TipoCliente(id)
);

CREATE TABLE Pedido (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idCliente INT NOT NULL,
    fechaPedido DATE NOT NULL,
    fechaEntrega DATE NOT NULL,
    idEstado INT NOT NULL,
    idRuta INT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(id),
    FOREIGN KEY (idEstado) REFERENCES EstadoPedido(id)
);

CREATE TABLE Producto (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precioVentaUnitario DECIMAL(10,2) NOT NULL,
    refrigeracion BIT NOT NULL CHECK (refrigeracion IN (0,1)),
    fragil BIT NOT NULL CHECK (fragil IN (0,1))
);

CREATE TABLE Lote (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idProducto INT NOT NULL,
    fechaCaducidad DATETIME NOT NULL,
    codigoLote INT NOT NULL,
    idEstadoLote INT NOT NULL,
    FOREIGN KEY (idProducto) REFERENCES Producto(id),
    FOREIGN KEY (idEstadoLote) REFERENCES EstadoLote(id)
);

CREATE TABLE Pedido_Producto (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idPedido INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedido(id),
    FOREIGN KEY (idProducto) REFERENCES Producto(id)
);

CREATE TABLE Picking (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idPedido INT NOT NULL,
    idProducto INT NOT NULL,
    idLote INT NOT NULL,
    cantidad INT NOT NULL,
    fechaHora DATETIME NOT NULL,
    validado BIT NOT NULL CHECK (validado IN (0,1)),
    FOREIGN KEY (idPedido) REFERENCES Pedido(id),
    FOREIGN KEY (idProducto) REFERENCES Producto(id),
    FOREIGN KEY (idLote) REFERENCES Lote(id)
);

CREATE TABLE Caja (
    id INT IDENTITY(1,1) PRIMARY KEY,
    codigo VARCHAR(100) NOT NULL,
    qr VARCHAR(255),
    peso INT NOT NULL,
    idVehiculo INT NULL
);

CREATE TABLE Caja_Pedido (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idPedido INT NOT NULL,
    idCaja INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedido(id),
    FOREIGN KEY (idCaja) REFERENCES Caja(id)
);

CREATE TABLE Chofer (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nroLicencia VARCHAR(100) NOT NULL
);

CREATE TABLE Vehiculo (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    patente VARCHAR(20) NOT NULL,
    idTipoVehiculo INT NOT NULL,
    idChofer INT NOT NULL,
    disponible BIT NOT NULL CHECK (disponible IN (0,1)),
    FOREIGN KEY (idTipoVehiculo) REFERENCES TipoVehiculo(id),
    FOREIGN KEY (idChofer) REFERENCES Chofer(id)
);

CREATE TABLE Ruta (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idVehiculo INT NOT NULL,
    FOREIGN KEY (idVehiculo) REFERENCES Vehiculo(id)
);

CREATE TABLE Parada (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ubicacion VARCHAR(255) NOT NULL
);

CREATE TABLE Ruta_Parada (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idRuta INT NOT NULL,
    idParada INT NOT NULL,
    orden INT NOT NULL,
    FOREIGN KEY (idRuta) REFERENCES Ruta(id),
    FOREIGN KEY (idParada) REFERENCES Parada(id)
);

-- ROLES Y SEGURIDAD

CREATE ROLE administrador;
GO

CREATE ROLE chofer;
GO

CREATE ROLE operador_logistica;
GO

-- Administrador (Permisos completos)
GRANT CONTROL ON DATABASE::AndreaniLogisticaDB TO administrador;
GO

-- Chofer (Ver rutas, paradas, pedidos asignados. Actualizar estados de entrega)
GRANT SELECT ON dbo.Ruta TO chofer;
GRANT SELECT ON dbo.Ruta_Parada TO chofer;
GRANT SELECT ON dbo.Parada TO chofer;
GRANT SELECT ON dbo.Vehiculo TO chofer;
GRANT SELECT ON dbo.Chofer TO chofer;
GRANT SELECT ON dbo.Pedido TO chofer;
GRANT SELECT ON dbo.Cliente TO chofer;
GRANT SELECT ON dbo.Caja TO chofer;
GRANT SELECT ON dbo.Caja_Pedido TO chofer;
GRANT SELECT ON dbo.EstadoPedido TO chofer;
GO

GRANT UPDATE ON dbo.Pedido (idEstado) TO chofer;
GO

-- Operador Logistica (Permisos CRUD para el proceso logistico excepto vehiculos y choferes)
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Cliente TO operador_logistica;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Pedido TO operador_logistica;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Producto TO operador_logistica;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Lote TO operador_logistica;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Pedido_Producto TO operador_logistica;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Picking TO operador_logistica;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Caja TO operador_logistica;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Caja_Pedido TO operador_logistica;
GO

GRANT SELECT ON dbo.TipoCliente TO operador_logistica;
GRANT SELECT ON dbo.EstadoPedido TO operador_logistica;
GRANT SELECT ON dbo.EstadoLote TO operador_logistica;
GRANT SELECT ON dbo.TipoVehiculo TO operador_logistica;
GO

GRANT SELECT ON dbo.Vehiculo TO operador_logistica;
GRANT SELECT ON dbo.Ruta TO operador_logistica;
GRANT SELECT ON dbo.Chofer TO operador_logistica;
GRANT SELECT ON dbo.Parada TO operador_logistica;
GRANT SELECT ON dbo.Ruta_Parada TO operador_logistica;
GO
