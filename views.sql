-- VISTA PARA OBTENER RUTAS CON SUS RESPECTIVAS PARADAS, VEHICULO Y CHOFER ASOCIADOS
CREATE VIEW vw_RutaConParadas AS
SELECT 
    r.id AS idRuta,
    v.nombre AS vehiculo,
    v.patente,
    c.nombre AS chofer,
    p.id AS idParada,
    p.ubicacion AS ubicacionParada,
    rp.orden
FROM Ruta r
INNER JOIN Vehiculo v ON v.id = r.idVehiculo
INNER JOIN Chofer c ON c.id = v.idChofer
INNER JOIN Ruta_Parada rp ON rp.idRuta = r.id
INNER JOIN Parada p ON p.id = rp.idParada
ORDER BY r.id, rp.orden;
GO

-- VISTA PARA OBTENER PEDIDOS CON DETALLES DE PRODUCTOS Y CAJAS ASOCIADAS
CREATE VIEW vw_PedidoDetalleCompleto AS
SELECT 
    p.id AS idPedido,
    c.nombre AS cliente,
    c.cuit,
    pr.nombre AS producto,
    pp.cantidad AS cantidadPedido,
    cx.codigo AS codigoCaja,
    cx.qr AS qrCaja
FROM Pedido p
INNER JOIN Cliente c ON c.id = p.idCliente
INNER JOIN Pedido_Producto pp ON pp.idPedido = p.id
INNER JOIN Producto pr ON pr.id = pp.idProducto
LEFT JOIN Caja_Pedido cp ON cp.idPedido = p.id
LEFT JOIN Caja cx ON cx.id = cp.idCaja;
GO

-- VISTA PARA OBTENER TRAZABILIDAD DE LOTES CON PRODUCTOS, PICKING Y PEDIDOS ASOCIADOS
CREATE VIEW vw_TrazabilidadLote AS
SELECT 
    l.id AS idLote,
    l.codigoLote,
    l.fechaCaducidad,
    pr.nombre AS producto,
    pk.cantidad,
    pk.fechaHora AS fechaPicking,
    cli.nombre AS cliente,
    ped.id AS idPedido
FROM Lote l
INNER JOIN Producto pr ON pr.id = l.idProducto
INNER JOIN Picking pk ON pk.idLote = l.id
INNER JOIN Pedido ped ON ped.id = pk.idPedido
INNER JOIN Cliente cli ON cli.id = ped.idCliente;
GO
