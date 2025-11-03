USE AndreaniLogisticaDB;
GO

SET IDENTITY_INSERT TipoCliente ON;
INSERT INTO TipoCliente (id, nombre) VALUES
(1, 'Farmacia'),
(2, 'Hospital/Clínica'),
(3, 'Droguería');
SET IDENTITY_INSERT TipoCliente OFF;

SET IDENTITY_INSERT EstadoPedido ON;
INSERT INTO EstadoPedido (id, nombre) VALUES
(1, 'Pendiente'),
(2, 'Preparado'),
(3, 'En Ruta'),
(4, 'Entregado');
SET IDENTITY_INSERT EstadoPedido OFF;

SET IDENTITY_INSERT EstadoLote ON;
INSERT INTO EstadoLote (id, nombre) VALUES
(1, 'Habilitado'),
(2, 'Vencido');
SET IDENTITY_INSERT EstadoLote OFF;

SET IDENTITY_INSERT TipoVehiculo ON;
INSERT INTO TipoVehiculo (id, nombre, refrigeracion, capacidad) VALUES
(1, 'Kangoo Refrigerada', 1, 1),
(2, 'Sprinter Seco',       0, 1),
(3, 'Furgón Urbano',       0, 1);
SET IDENTITY_INSERT TipoVehiculo OFF;

/* ===========================
   BLOQUE 2: FLOTA, RUTAS Y PARADAS
=========================== */
SET IDENTITY_INSERT Chofer ON;
INSERT INTO Chofer (id, nombre, nroLicencia) VALUES
(1, 'Carlos Gómez', 'LIC-AR-001'),
(2, 'Marta Ruiz',   'LIC-AR-002'),
(3, 'Diego López',  'LIC-AR-003');
SET IDENTITY_INSERT Chofer OFF;

SET IDENTITY_INSERT Vehiculo ON;
INSERT INTO Vehiculo (id, nombre, patente, idTipoVehiculo, idChofer, disponible) VALUES
(1, 'Kangoo Frío 01', 'AB123CD', 1, 1, 1),
(2, 'Sprinter 02',    'EF456GH', 2, 2, 1),
(3, 'Furgón 03',      'IJ789KL', 3, 3, 1);
SET IDENTITY_INSERT Vehiculo OFF;

SET IDENTITY_INSERT Ruta ON;
INSERT INTO Ruta (id, idVehiculo) VALUES
(1, 1), -- Ruta Zona Norte con Kangoo Frío (refrigerada)
(2, 2); -- Ruta Zona Oeste con Sprinter
SET IDENTITY_INSERT Ruta OFF;

SET IDENTITY_INSERT Parada ON;
INSERT INTO Parada (id, ubicacion) VALUES
(1, 'Farmacia San Martín - Av. San Martín 1200, Vicente López'),
(2, 'Clínica Los Álamos - Av. Rivadavia 4500, CABA'),
(3, 'Droguería Central SRL - Parque Industrial Pacheco'),
(4, 'Hospital del Prado - Calle 9 N° 2300, Morón'),
(5, 'Farmacia Solís - Solís 350, San Isidro'),
(6, 'Sanatorio del Lago - Av. Del Lago 2200, Tigre');
SET IDENTITY_INSERT Parada OFF;

SET IDENTITY_INSERT Ruta_Parada ON;
-- Ruta 1 (Norte): paradas 5 -> 1 -> 6 (orden 1..3)
INSERT INTO Ruta_Parada (id, idRuta, idParada, orden) VALUES
(1, 1, 5, 1),
(2, 1, 1, 2),
(3, 1, 6, 3);
-- Ruta 2 (Oeste): paradas 2 -> 4 -> 3
INSERT INTO Ruta_Parada (id, idRuta, idParada, orden) VALUES
(4, 2, 2, 1),
(5, 2, 4, 2),
(6, 2, 3, 3);
SET IDENTITY_INSERT Ruta_Parada OFF;

/* ===========================
   BLOQUE 3: CLIENTES
=========================== */
SET IDENTITY_INSERT Cliente ON;
INSERT INTO Cliente (id, nombre, idTipoCliente, cuit, direccion, activo) VALUES
(1, 'Farmacia San Martín',        1, '30708840459', 'Av. San Martín 1200, Vicente López', 1),
(2, 'Clínica Los Álamos',         2, '30709990519', 'Av. Rivadavia 4500, CABA',            1),
(3, 'Droguería Central SRL',      3, '30704567891', 'Parque Industrial Pacheco',           1),
(4, 'Sanatorio del Lago',         2, '30705551234', 'Av. Del Lago 2200, Tigre',             1),
(5, 'Farmacia Solís',             1, '30702223334', 'Solís 350, San Isidro',                1);
SET IDENTITY_INSERT Cliente OFF;

/* ===========================
   BLOQUE 4: PRODUCTOS Y LOTES
=========================== */
SET IDENTITY_INSERT Producto ON;
INSERT INTO Producto (id, nombre, precioVentaUnitario, refrigeracion, fragil) VALUES
(1, 'Ibuprofeno 400mg x10',     2500.00, 0, 0),
(2, 'Amoxicilina 500mg x12',    5200.00, 0, 0),
(3, 'Vacuna Antigripal 2025',  15000.00, 1, 1),
(4, 'Paracetamol 500mg x16',    3100.00, 0, 0),
(5, 'Insulina Rápida 10ml',    22000.00, 1, 1);
SET IDENTITY_INSERT Producto OFF;

SET IDENTITY_INSERT Lote ON;
-- Habilitados y uno vencido como caso de error
INSERT INTO Lote (id, idProducto, fechaCaducidad, codigoLote, idEstadoLote) VALUES
(1, 1, '2026-10-15T00:00:00', 101, 1), -- Ibu habilitado
(2, 1, '2025-12-20T00:00:00',  90, 1), -- Ibu habilitado (vence antes) -> FEFO
(3, 2, '2026-05-30T00:00:00', 201, 1), -- Amoxi habilitado
(4, 2, '2025-11-30T00:00:00',  95, 1), -- Amoxi habilitado (vence antes) -> FEFO
(5, 3, '2025-03-31T00:00:00', 301, 1), -- Vacuna habilitado (corto)
(6, 3, '2024-12-15T00:00:00', 299, 2), -- Vacuna VENCIDO (caso error)
(7, 4, '2027-02-15T00:00:00', 401, 1), -- Paracetamol habilitado
(8, 5, '2025-04-30T00:00:00', 501, 1); -- Insulina habilitado
SET IDENTITY_INSERT Lote OFF;

/* ===========================
   BLOQUE 5: PEDIDOS
=========================== */
SET IDENTITY_INSERT Pedido ON;
-- Incluye un pedido con ruta 1 (refrigerada) y otro con ruta 2
INSERT INTO Pedido (id, idCliente, fechaPedido, fechaEntrega, idEstado, idRuta) VALUES
(1, 1, '2025-02-10', '2025-02-12', 1, NULL), -- Pendiente, sin ruta asignada aún
(2, 2, '2025-02-12', '2025-02-13', 2, 1),    -- Preparado, en Ruta 1 (refrigerada)
(3, 5, '2025-02-14', '2025-02-15', 3, 2),    -- En Ruta, Ruta 2
(4, 4, '2025-02-01', '2025-02-05', 4, 1);    -- Entregado (usaremos caso atrasado respecto a ventana estimada)
SET IDENTITY_INSERT Pedido OFF;

/* ===========================
   BLOQUE 6: DETALLE DE PEDIDOS
=========================== */
SET IDENTITY_INSERT Pedido_Producto ON;
-- Pedido 1 (Farmacia San Martín): Ibu + Amoxi
INSERT INTO Pedido_Producto (id, idPedido, idProducto, cantidad) VALUES
(1, 1, 1, 20), -- Ibu x20
(2, 1, 2, 10); -- Amoxi x10

-- Pedido 2 (Clínica Los Álamos): Vacuna + Insulina (refrigerados)
INSERT INTO Pedido_Producto (id, idPedido, idProducto, cantidad) VALUES
(3, 2, 3, 15), -- Vacuna x15
(4, 2, 5,  5); -- Insulina x5

-- Pedido 3 (Farmacia Solís): Ibu + Paracetamol
INSERT INTO Pedido_Producto (id, idPedido, idProducto, cantidad) VALUES
(5, 3, 1, 12), -- Ibu x12
(6, 3, 4, 18); -- Paracetamol x18

-- Pedido 4 (Sanatorio del Lago): Amoxi + Vacuna
INSERT INTO Pedido_Producto (id, idPedido, idProducto, cantidad) VALUES
(7, 4, 2, 25), -- Amoxi x25
(8, 4, 3, 10); -- Vacuna x10
SET IDENTITY_INSERT Pedido_Producto OFF;

/* ===========================
   BLOQUE 7: CAJAS Y ASIGNACIÓN
=========================== */
SET IDENTITY_INSERT Caja ON;
INSERT INTO Caja (id, codigo, qr, peso, idVehiculo) VALUES
(1, 'CX-0001', 'QR-CX-0001',  8, 1), -- En Kangoo Frío
(2, 'CX-0002', 'QR-CX-0002', 12, 2), -- En Sprinter
(3, 'CX-0003', 'QR-CX-0003', 10, 1),
(4, 'CX-0004', 'QR-CX-0004',  6, NULL), -- aún sin asignar vehículo
(5, 'CX-0005', 'QR-CX-0005', 15, 2);
SET IDENTITY_INSERT Caja OFF;

SET IDENTITY_INSERT Caja_Pedido ON;
-- Repartimos cajas por pedidos (múltiples cajas por pedido para consolidación)
INSERT INTO Caja_Pedido (id, idPedido, idCaja) VALUES
(1, 1, 1), -- Pedido 1 usa Caja 1
(2, 1, 4), -- Pedido 1 también Caja 4
(3, 2, 3), -- Pedido 2 usa Caja 3 (refrigerada)
(4, 2, 5), -- Pedido 2 Caja 5
(5, 3, 2), -- Pedido 3 Caja 2
(6, 4, 1); -- Pedido 4 comparte Caja 1 (hipótesis de consolidación hacia misma ruta)
SET IDENTITY_INSERT Caja_Pedido OFF;

/* ===========================
   BLOQUE 8: PICKING (con FEFO y un caso no validado)
=========================== */
SET IDENTITY_INSERT Picking ON;
-- Pedido 1: Ibu 20 uds → tomar del Ibu lote 90 (vence antes) y completar con 101
INSERT INTO Picking (id, idPedido, idProducto, idLote, cantidad, fechaHora, validado) VALUES
(1,  1, 1, 2, 15, '2025-02-11T10:10:00', 1), -- Ibu Lote 90 (FEFO)
(2,  1, 1, 1,  5, '2025-02-11T10:12:00', 1), -- Ibu Lote 101 (complemento)
(3,  1, 2, 4, 10, '2025-02-11T10:20:00', 1); -- Amoxi Lote 95 (vence antes)

-- Pedido 2 (refrigerados): Vacuna 15 y Insulina 5
-- Caso de error: se intenta usar Lote 299 (vacuna vencida) → validado = 0
INSERT INTO Picking (id, idPedido, idProducto, idLote, cantidad, fechaHora, validado) VALUES
(4,  2, 3, 6,  3, '2025-02-12T08:30:00', 0), -- Vacuna VENCIDA (rechazado)
(5,  2, 3, 5, 12, '2025-02-12T08:45:00', 1), -- Vacuna habilitada
(6,  2, 5, 8,  5, '2025-02-12T09:00:00', 1); -- Insulina habilitada

-- Pedido 3: Ibu 12 y Paracetamol 18
INSERT INTO Picking (id, idPedido, idProducto, idLote, cantidad, fechaHora, validado) VALUES
(7,  3, 1, 2, 10, '2025-02-14T11:05:00', 1), -- Ibu Lote 90
(8,  3, 1, 1,  2, '2025-02-14T11:07:00', 1), -- Ibu Lote 101
(9,  3, 4, 7, 18, '2025-02-14T11:15:00', 1); -- Paracetamol Lote 401

-- Pedido 4 (entregado): Amoxi 25 + Vacuna 10
-- Simulamos que parte del picking se hizo un día antes y se completó el día de salida
INSERT INTO Picking (id, idPedido, idProducto, idLote, cantidad, fechaHora, validado) VALUES
(10, 4, 2, 4, 15, '2025-02-03T16:40:00', 1), -- Amoxi Lote 95
(11, 4, 2, 3, 10, '2025-02-04T09:10:00', 1), -- Amoxi Lote 201
(12, 4, 3, 5, 10, '2025-02-04T09:30:00', 1); -- Vacuna Lote 301
SET IDENTITY_INSERT Picking OFF;
