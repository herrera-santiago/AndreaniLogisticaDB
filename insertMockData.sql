USE AndreaniLogisticaDB;
GO

/* =========================================================
   BLOQUE 0: TABLAS DE CATÁLOGO / ENUMS
   ========================================================= */
SET IDENTITY_INSERT TipoCliente ON;
INSERT INTO TipoCliente (id, nombre) VALUES
                                         (1,'Farmacia'),
                                         (2,'Hospital/Clínica'),
                                         (3,'Droguería');
SET IDENTITY_INSERT TipoCliente OFF;

SET IDENTITY_INSERT EstadoPedido ON;
INSERT INTO EstadoPedido (id, nombre) VALUES
                                          (1,'Pendiente'),
                                          (2,'Preparado'),
                                          (3,'En Ruta'),
                                          (4,'Entregado');
SET IDENTITY_INSERT EstadoPedido OFF;

SET IDENTITY_INSERT EstadoLote ON;
INSERT INTO EstadoLote (id, nombre) VALUES
                                        (1,'Habilitado'),
                                        (2,'Vencido');
SET IDENTITY_INSERT EstadoLote OFF;

SET IDENTITY_INSERT TipoVehiculo ON;
INSERT INTO TipoVehiculo (id, nombre, refrigeracion, capacidad) VALUES
                                                                    (1,'Kangoo Refrigerada', 1, 200),
                                                                    (2,'Sprinter Seco',      0, 300),
                                                                    (3,'Furgón Urbano',      0, 150),
                                                                    (4,'Camión Frigorífico', 1, 1200);
SET IDENTITY_INSERT TipoVehiculo OFF;

/* =========================================================
   BLOQUE 1: PERSONAS Y FLOTA (≥10 choferes y vehículos)
   ========================================================= */
SET IDENTITY_INSERT Chofer ON;
INSERT INTO Chofer (id, nombre, nroLicencia) VALUES
                                                 (1,'Carlos Gómez','LIC-AR-001'),
                                                 (2,'Marta Ruiz','LIC-AR-002'),
                                                 (3,'Diego López','LIC-AR-003'),
                                                 (4,'Ana Pereyra','LIC-AR-004'),
                                                 (5,'Julián Torres','LIC-AR-005'),
                                                 (6,'María Fernández','LIC-AR-006'),
                                                 (7,'Sergio Duarte','LIC-AR-007'),
                                                 (8,'Paula Medina','LIC-AR-008'),
                                                 (9,'Hernán Sosa','LIC-AR-009'),
                                                 (10,'Lorena Cabrera','LIC-AR-010');
SET IDENTITY_INSERT Chofer OFF;

SET IDENTITY_INSERT Vehiculo ON;
INSERT INTO Vehiculo (id, nombre, patente, idTipoVehiculo, idChofer, disponible) VALUES
                                                                                     (1,'Kangoo Frío 01','AB123CD',1,1,1),
                                                                                     (2,'Kangoo Frío 02','AB124CD',1,2,1),
                                                                                     (3,'Sprinter 01','EF456GH',2,3,1),
                                                                                     (4,'Sprinter 02','EF457GH',2,4,1),
                                                                                     (5,'Furgón 01','IJ789KL',3,5,1),
                                                                                     (6,'Furgón 02','IJ790KL',3,6,1),
                                                                                     (7,'Camión Frío 01','MN111OP',4,7,1),
                                                                                     (8,'Camión Frío 02','MN112OP',4,8,1),
                                                                                     (9,'Sprinter 03','EF458GH',2,9,1),
                                                                                     (10,'Furgón 03','IJ791KL',3,10,1);
SET IDENTITY_INSERT Vehiculo OFF;

/* =========================================================
   BLOQUE 2: RUTAS Y PARADAS (≥10 rutas y 20 paradas)
   ========================================================= */
SET IDENTITY_INSERT Ruta ON;
INSERT INTO Ruta (id, idVehiculo) VALUES
                                      (1,1),(2,2),(3,3),(4,4),(5,5),
                                      (6,6),(7,7),(8,8),(9,9),(10,10);
SET IDENTITY_INSERT Ruta OFF;

SET IDENTITY_INSERT Parada ON;
INSERT INTO Parada (id, ubicacion) VALUES
                                       (1,'Farmacia San Martín - Vicente López'),
                                       (2,'Clínica Los Álamos - CABA'),
                                       (3,'Droguería Central - Pacheco'),
                                       (4,'Hospital del Prado - Morón'),
                                       (5,'Farmacia Solís - San Isidro'),
                                       (6,'Sanatorio del Lago - Tigre'),
                                       (7,'Hospital Norte - San Fernando'),
                                       (8,'Clínica del Parque - San Justo'),
                                       (9,'Farmacia Centro - Martínez'),
                                       (10,'Droguería Buenos Aires - Barracas'),
                                       (11,'Hospital Santa Rosa - Vicente López'),
                                       (12,'Clínica Belgrano - CABA'),
                                       (13,'Farmacia Libertador - San Isidro'),
                                       (14,'Clínica Quilmes - Quilmes'),
                                       (15,'Droguería Sur - Avellaneda'),
                                       (16,'Hospital Oeste - Ituzaingó'),
                                       (17,'Farmacia Olivos - Olivos'),
                                       (18,'Clínica Florida - Florida'),
                                       (19,'Sanatorio Central - CABA'),
                                       (20,'Hospital Provincial - La Plata');
SET IDENTITY_INSERT Parada OFF;

SET IDENTITY_INSERT Ruta_Parada ON;
-- Para cada ruta: 4 paradas con orden 1..4
INSERT INTO Ruta_Parada (id, idRuta, idParada, orden) VALUES
                                                          (1,1,5,1),(2,1,1,2),(3,1,11,3),(4,1,17,4),
                                                          (5,2,2,1),(6,2,12,2),(7,2,19,3),(8,2,10,4),
                                                          (9,3,3,1),(10,3,15,2),(11,3,20,3),(12,3,8,4),
                                                          (13,4,4,1),(14,4,16,2),(15,4,6,3),(16,4,7,4),
                                                          (17,5,9,1),(18,5,13,2),(19,5,5,3),(20,5,18,4),
                                                          (21,6,14,1),(22,6,2,2),(23,6,12,3),(24,6,19,4),
                                                          (25,7,6,1),(26,7,7,2),(27,7,1,3),(28,7,5,4),
                                                          (29,8,10,1),(30,8,15,2),(31,8,3,3),(32,8,20,4),
                                                          (33,9,8,1),(34,9,4,2),(35,9,16,3),(36,9,14,4),
                                                          (37,10,11,1),(38,10,17,2),(39,10,9,3),(40,10,13,4);
SET IDENTITY_INSERT Ruta_Parada OFF;

/* =========================================================
   BLOQUE 3: CLIENTES (≥15)
   ========================================================= */
SET IDENTITY_INSERT Cliente ON;
INSERT INTO Cliente (id, nombre, idTipoCliente, cuit, direccion, activo) VALUES
                                                                             (1,'Farmacia San Martín',1,'30708840459','Av. San Martín 1200, Vicente López',1),
                                                                             (2,'Clínica Los Álamos',2,'30709990519','Av. Rivadavia 4500, CABA',1),
                                                                             (3,'Droguería Central SRL',3,'30704567891','Parque Industrial Pacheco',1),
                                                                             (4,'Sanatorio del Lago',2,'30705551234','Av. Del Lago 2200, Tigre',1),
                                                                             (5,'Farmacia Solís',1,'30702223334','Solís 350, San Isidro',1),
                                                                             (6,'Hospital Norte',2,'30706667777','Maipú 2000, San Fernando',1),
                                                                             (7,'Clínica del Parque',2,'30701234567','Av. Juan M. de Rosas 1500, San Justo',1),
                                                                             (8,'Farmacia Centro Martínez',1,'30707654321','Av. Santa Fe 1200, Martínez',1),
                                                                             (9,'Droguería Buenos Aires',3,'30703334445','Iriarte 2500, Barracas',1),
                                                                             (10,'Hospital Santa Rosa',2,'30709997777','Av. Maipú 800, Vicente López',1),
                                                                             (11,'Clínica Belgrano',2,'30705432109','Av. Cabildo 2300, CABA',1),
                                                                             (12,'Farmacia Libertador',1,'30701111222','Av. del Libertador 14800, San Isidro',1),
                                                                             (13,'Clínica Quilmes',2,'30708889990','Mitre 400, Quilmes',1),
                                                                             (14,'Droguería Sur',3,'30707776665','Av. Mitre 2000, Avellaneda',1),
                                                                             (15,'Hospital Provincial',2,'30704445556','Av. 1 100, La Plata',1);
SET IDENTITY_INSERT Cliente OFF;

/* =========================================================
   BLOQUE 4: PRODUCTOS (≥12) Y LOTES (≥20, todos habilitados y futuros)
   ========================================================= */
SET IDENTITY_INSERT Producto ON;
INSERT INTO Producto (id, nombre, precioVentaUnitario, refrigeracion, fragil) VALUES
                                                                                  (1,'Ibuprofeno 400mg x10',2500.00,0,0),
                                                                                  (2,'Amoxicilina 500mg x12',5200.00,0,0),
                                                                                  (3,'Vacuna Antigripal',15000.00,1,1),
                                                                                  (4,'Paracetamol 500mg x16',3100.00,0,0),
                                                                                  (5,'Insulina Rápida 10ml',22000.00,1,1),
                                                                                  (6,'Suero Fisiológico 500ml',1800.00,0,0),
                                                                                  (7,'Omeprazol 20mg x14',4200.00,0,0),
                                                                                  (8,'Vitamina C 1g x20',3500.00,0,0),
                                                                                  (9,'Antialérgico Loratadina x10',3300.00,0,0),
                                                                                  (10,'Antibiótico Azitromicina x6',6800.00,0,0),
                                                                                  (11,'Vacuna Hepatitis B',28000.00,1,1),
                                                                                  (12,'Insulina Lenta 10ml',24000.00,1,1);
SET IDENTITY_INSERT Producto OFF;

-- Fechas de caducidad futuras (>= 2026-01-01)
SET IDENTITY_INSERT Lote ON;
INSERT INTO Lote (id, idProducto, fechaCaducidad, codigoLote, idEstadoLote) VALUES
                                                                                (1,1,'2026-10-15T00:00:00',101,1),
                                                                                (2,1,'2026-06-20T00:00:00',102,1),
                                                                                (3,2,'2026-05-30T00:00:00',201,1),
                                                                                (4,2,'2026-03-31T00:00:00',202,1),
                                                                                (5,3,'2026-09-30T00:00:00',301,1),
                                                                                (6,3,'2027-02-28T00:00:00',302,1),
                                                                                (7,4,'2027-02-15T00:00:00',401,1),
                                                                                (8,4,'2026-12-15T00:00:00',402,1),
                                                                                (9,5,'2026-08-31T00:00:00',501,1),
                                                                                (10,5,'2027-01-31T00:00:00',502,1),
                                                                                (11,6,'2026-11-30T00:00:00',601,1),
                                                                                (12,6,'2027-03-31T00:00:00',602,1),
                                                                                (13,7,'2026-07-31T00:00:00',701,1),
                                                                                (14,8,'2026-04-30T00:00:00',801,1),
                                                                                (15,9,'2026-09-30T00:00:00',901,1),
                                                                                (16,10,'2026-12-31T00:00:00',1001,1),
                                                                                (17,11,'2027-06-30T00:00:00',1101,1),
                                                                                (18,11,'2026-10-31T00:00:00',1102,1),
                                                                                (19,12,'2027-05-31T00:00:00',1201,1),
                                                                                (20,12,'2026-11-30T00:00:00',1202,1);
SET IDENTITY_INSERT Lote OFF;

/* =========================================================
   BLOQUE 5: PEDIDOS (12 pedidos; estados iniciales no “Entregado”)
   ========================================================= */
SET IDENTITY_INSERT Pedido ON;
INSERT INTO Pedido (id, idCliente, fechaPedido, fechaEntrega, idEstado, idRuta) VALUES
                                                                                    (1,1,'2025-11-05','2025-11-06',1,1),
                                                                                    (2,2,'2025-11-05','2025-11-06',1,7),
                                                                                    (3,3,'2025-11-05','2025-11-07',2,8),
                                                                                    (4,4,'2025-11-06','2025-11-07',1,2),
                                                                                    (5,5,'2025-11-06','2025-11-08',1,5),
                                                                                    (6,6,'2025-11-06','2025-11-08',2,6),
                                                                                    (7,7,'2025-11-07','2025-11-09',1,3),
                                                                                    (8,8,'2025-11-07','2025-11-09',1,9),
                                                                                    (9,9,'2025-11-07','2025-11-10',1,10),
                                                                                    (10,10,'2025-11-07','2025-11-10',1,4),
                                                                                    (11,11,'2025-11-07','2025-11-10',1,2),
                                                                                    (12,12,'2025-11-07','2025-11-10',2,1);
SET IDENTITY_INSERT Pedido OFF;

/* =========================================================
   BLOQUE 6: DETALLE DE PEDIDOS (≈30 filas)
   ========================================================= */
SET IDENTITY_INSERT Pedido_Producto ON;
INSERT INTO Pedido_Producto (id, idPedido, idProducto, cantidad) VALUES
                                                                     (1,1,1,20),(2,1,2,10),
                                                                     (3,2,3,15),(4,2,5,6),
                                                                     (5,3,4,12),(6,3,1,8),
                                                                     (7,4,2,20),(8,4,6,10),
                                                                     (9,5,1,10),(10,5,7,15),
                                                                     (11,6,5,8),(12,6,3,12),
                                                                     (13,7,8,20),(14,7,9,10),
                                                                     (15,8,10,12),(16,8,2,8),
                                                                     (17,9,11,10),(18,9,12,5),
                                                                     (19,10,4,16),(20,10,8,20),
                                                                     (21,11,7,14),(22,11,9,12),
                                                                     (23,12,3,10),(24,12,5,10),
                                                                     (25,3,6,10),(26,4,1,12),
                                                                     (27,7,2,10),(28,8,1,10),
                                                                     (29,9,3,8),(30,10,5,6);
SET IDENTITY_INSERT Pedido_Producto OFF;

/* =========================================================
   BLOQUE 7: CAJAS y ASIGNACIÓN (≥15 y 20)
   ========================================================= */
SET IDENTITY_INSERT Caja ON;
INSERT INTO Caja (id, codigo, qr, peso, idVehiculo) VALUES
                                                        (1,'CX-0001','QR-CX-0001', 8,1),
                                                        (2,'CX-0002','QR-CX-0002',12,2),
                                                        (3,'CX-0003','QR-CX-0003',10,3),
                                                        (4,'CX-0004','QR-CX-0004',14,4),
                                                        (5,'CX-0005','QR-CX-0005', 9,5),
                                                        (6,'CX-0006','QR-CX-0006',11,6),
                                                        (7,'CX-0007','QR-CX-0007',13,7),
                                                        (8,'CX-0008','QR-CX-0008', 7,8),
                                                        (9,'CX-0009','QR-CX-0009',15,9),
                                                        (10,'CX-0010','QR-CX-0010', 6,10),
                                                        (11,'CX-0011','QR-CX-0011', 9,1),
                                                        (12,'CX-0012','QR-CX-0012',10,2),
                                                        (13,'CX-0013','QR-CX-0013', 8,3),
                                                        (14,'CX-0014','QR-CX-0014',12,4),
                                                        (15,'CX-0015','QR-CX-0015',11,5);
SET IDENTITY_INSERT Caja OFF;

SET IDENTITY_INSERT Caja_Pedido ON;
INSERT INTO Caja_Pedido (id, idPedido, idCaja) VALUES
                                                   (1,1,1),(2,1,11),
                                                   (3,2,7),(4,2,8),
                                                   (5,3,3),(6,3,13),
                                                   (7,4,4),(8,4,14),
                                                   (9,5,5),(10,5,15),
                                                   (11,6,6),(12,6,12),
                                                   (13,7,9),(14,7,10),
                                                   (15,8,2),(16,8,1),
                                                   (17,9,11),(18,10,12),
                                                   (19,11,13),(20,12,14);
SET IDENTITY_INSERT Caja_Pedido OFF;

/* =========================================================
   BLOQUE 8: PICKING (≈40 filas) – solo lotes habilitados, FEFO
   ========================================================= */
SET IDENTITY_INSERT Picking ON;
-- P1: Ibu (2 lotes) + Amoxi
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                                                                                    (1,1,1,2,12,'2025-11-05T10:10:00',1),
                                                                                    (2,1,1,1, 8,'2025-11-05T10:12:00',1),
                                                                                    (3,1,2,4,10,'2025-11-05T10:20:00',1);

-- P2: Vacuna + Insulina (vehículos con frío → rutas 7/1)
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                                                                                    (4,2,3,5, 8,'2025-11-05T09:00:00',1),
                                                                                    (5,2,3,6, 7,'2025-11-05T09:10:00',1),
                                                                                    (6,2,5,9, 6,'2025-11-05T09:20:00',1);

-- P3: Paracetamol + Ibu + Suero
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (7,3,4,8,12,'2025-11-05T14:00:00',1),
                        (8,3,1,2, 8,'2025-11-05T14:05:00',1),
                        (9,3,6,11,10,'2025-11-05T14:10:00',1);

-- P4: Amoxi + Suero
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (10,4,2,4,12,'2025-11-06T09:00:00',1),
                        (11,4,6,11,10,'2025-11-06T09:05:00',1);

-- P5: Ibu + Omeprazol
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (12,5,1,2,10,'2025-11-06T10:00:00',1),
                        (13,5,7,13,15,'2025-11-06T10:05:00',1);

-- P6: Insulina + Vacuna
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (14,6,5,9, 8,'2025-11-06T11:00:00',1),
                        (15,6,3,5,12,'2025-11-06T11:10:00',1);

-- P7: Vitamina C + Antialérgico + Amoxi
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (16,7,8,14,20,'2025-11-07T08:40:00',1),
                        (17,7,9,15,10,'2025-11-07T08:45:00',1),
                        (18,7,2,3,10,'2025-11-07T08:50:00',1);

-- P8: Azitromicina + Amoxi + Ibu
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (19,8,10,16,12,'2025-11-07T09:00:00',1),
                        (20,8,2,3, 8,'2025-11-07T09:05:00',1),
                        (21,8,1,1,10,'2025-11-07T09:10:00',1);

-- P9: Vacuna Hep B + Insulina Lenta
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (22,9,11,17,10,'2025-11-07T10:00:00',1),
                        (23,9,12,19, 5,'2025-11-07T10:05:00',1);

-- P10: Paracetamol + Vitamina C + Insulina Rápida
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (24,10,4,7,16,'2025-11-07T10:30:00',1),
                        (25,10,8,14,20,'2025-11-07T10:35:00',1),
                        (26,10,5,10, 6,'2025-11-07T10:40:00',1);

-- P11: Omeprazol + Antialérgico
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (27,11,7,13,14,'2025-11-07T11:10:00',1),
                        (28,11,9,15,12,'2025-11-07T11:15:00',1);

-- P12: Vacuna + Insulina (refrigerados)
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (29,12,3,6,10,'2025-11-07T12:00:00',1),
                        (30,12,5,10,10,'2025-11-07T12:05:00',1);

-- Extras para llegar a ~40 registros
INSERT INTO Picking (id,idPedido,idProducto,idLote,cantidad,fechaHora,validado) VALUES
                        (31,2,5,10,2,'2025-11-05T09:25:00',1),
                        (32,3,1,1, 2,'2025-11-05T14:12:00',1),
                        (33,7,8,14, 5,'2025-11-07T08:52:00',1),
                        (34,8,10,16, 3,'2025-11-07T09:12:00',1),
                        (35,9,11,18, 4,'2025-11-07T10:07:00',1),
                        (36,10,4,8,  2,'2025-11-07T10:42:00',1),
                        (37,11,7,13, 3,'2025-11-07T11:17:00',1),
                        (38,12,3,5,  2,'2025-11-07T12:08:00',1),
                        (39,5,7,13,  2,'2025-11-06T10:07:00',1),
                        (40,6,3,6,   1,'2025-11-06T11:12:00',1);
SET IDENTITY_INSERT Picking OFF;