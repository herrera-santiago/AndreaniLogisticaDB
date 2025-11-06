-- Funcion para verificar los dias hasta el vencimiento de un lote de productos
-- Si devuelve un número negativo, el lote ya está vencido.
CREATE FUNCTION fn_DiasHastaVencimiento (@idLote INT)
RETURNS INT
AS
BEGIN
    DECLARE @fechaVto DATETIME; -- variable para fecha de vencimiento del lote

    SELECT @fechaVto = fechaCaducidad
    FROM Lote 
    WHERE id = @idLote; -- Obtenemos la fecha de vencimiento del lote

    -- Si el lote no existe, devolvemos NULL
    IF @fechaVto IS NULL
        RETURN NULL;

    -- Diferencia en días entre hoy y la fecha de vencimiento
    RETURN DATEDIFF(DAY, GETDATE(), @fechaVto);
END;
GO

--EJEMPLO DE USO:
SELECT *
FROM Lote
WHERE dbo.fn_DiasHastaVencimiento(id) < 0;
GO
 -----------------------------------------------------------------------------------------


-- Función que indica si un producto requiere refrigeración.
-- Devuelve 1 (TRUE) o 0 (FALSE).
-- Si el producto no existe, lanza un error.
CREATE FUNCTION fn_ProductoRequiereRefrigeracion (@idProducto INT)
RETURNS BIT
AS
BEGIN
    DECLARE @req BIT;

    -- Validamos que el producto exista
    IF NOT EXISTS (SELECT 1 FROM Producto WHERE id = @idProducto)
    BEGIN
        RAISERROR ('Error en fn_ProductoRequiereRefrigeracion: el producto especificado no existe.', 16, 1);
        RETURN NULL;
    END

    -- Obtenemos el valor de refrigeración
    SELECT @req = refrigeracion
    FROM Producto
    WHERE id = @idProducto;

    RETURN @req;
END;
GO

-- EJEMPLO DE USO:
SELECT nombre, dbo.fn_ProductoRequiereRefrigeracion(id) AS requiereFrio
FROM Producto;
GO

-----------------------------------------------------------------------------------------



-- Devuelve los lotes habilitados y no vencidos para un producto dado.
-- Se puede usar para FEFO en picking.
CREATE FUNCTION fn_LotesDisponiblesPorProducto (@idProducto INT)
RETURNS TABLE
AS
RETURN
(
    SELECT -- Seleccionamos los campos relevantes del lote
        l.id,
        l.codigoLote,
        l.fechaCaducidad,
        l.idEstadoLote,
        dbo.fn_DiasHastaVencimiento(l.id) AS diasHastaVencimiento --  usamos la función fn_DiasHastaVencimiento
    FROM Lote l
    WHERE l.idProducto = @idProducto -- Filtramos por el producto dado
      AND l.idEstadoLote = 1            -- Habilitado
      AND diasHastaVencimiento >= 0    -- No vencido
    ORDER BY l.fechaCaducidad ASC      -- Ordenamos por fecha de caducidad
);
GO

-- EJEMPLO DE USO:
SELECT * FROM fn_LotesDisponiblesPorProducto(1);
GO


-----------------------------------------------------------------------------------------

-- Función de trazabilidad completa para un pedido.
-- Devuelve información desde el lote hasta el destino de entrega.
CREATE FUNCTION fn_TrazabilidadPedido (@idPedido INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.id AS idPedido,
        p.fechaPedido,
        p.fechaEntrega,
        c.nombre AS cliente,
        c.direccion AS direccionCliente,
        pr.nombre AS producto,
        pk.cantidad AS cantidadPickeada,
        pk.fechaHora AS fechaPicking,
        l.codigoLote,
        l.fechaCaducidad,
        cx.codigo AS codigoCaja,
        r.id AS idRuta,
        v.nombre AS vehiculo,
        v.patente,
        v.idTipoVehiculo,
        ch.nombre AS chofer,
        pa.ubicacion AS paradaDestino,
        rp.orden AS ordenEntrega
    FROM Pedido p
    INNER JOIN Cliente c ON c.id = p.idCliente
    INNER JOIN Picking pk ON pk.idPedido = p.id
    INNER JOIN Producto pr ON pr.id = pk.idProducto
    INNER JOIN Lote l ON l.id = pk.idLote
    LEFT JOIN Caja_Pedido cp ON cp.idPedido = p.id
    LEFT JOIN Caja cx ON cx.id = cp.idCaja
    LEFT JOIN Ruta r ON r.id = p.idRuta
    LEFT JOIN Vehiculo v ON v.id = r.idVehiculo
    LEFT JOIN Chofer ch ON ch.id = v.idChofer
    LEFT JOIN Ruta_Parada rp ON rp.idRuta = r.id
    LEFT JOIN Parada pa ON pa.id = rp.idParada
    WHERE p.id = @idPedido
)
GO

-- EJEMPLO DE USO:
SELECT *
FROM fn_TrazabilidadPedido(2)
ORDER BY ordenEntrega;
GO

