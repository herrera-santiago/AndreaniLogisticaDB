-- Trigger que impide registrar picking con lotes vencidos o no habilitados.
-- Si el lote está vencido según fecha, se lo marca automáticamente como vencido.
-- Luego se bloquea el INSERT con RAISERROR para garantizar integridad logística.

CREATE TRIGGER trg_ValidarLoteEnPicking
ON Picking
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; -- Evita mensajes adicionales
    -- Detectamos lotes vencidos (por fecha)
    UPDATE Lote
    SET idEstadoLote = 2  -- 2 = Vencido
    FROM Lote l
    INNER JOIN inserted i ON i.idLote = l.id
    WHERE dbo.fn_DiasHastaVencimiento(l.id) < 0
      AND l.idEstadoLote <> 2; -- solo si no estaba marcado aún
    -- Si el picking usa un lote vencido o no habilitado, bloqueamos el insert
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Lote l ON l.id = i.idLote
        WHERE l.idEstadoLote <> 1  -- 1 = Habilitado
    )
    BEGIN
        RAISERROR ('No se permite realizar picking con un lote vencido o no habilitado.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO


------------------------------------------------------------------------------

-- Trigger que impide modificar un pedido que ya fue marcado como ENTREGADO.
CREATE TRIGGER trg_BloquearUpdatePedidoEntregado
ON Pedido
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    -- Si el pedido ya estaba ENTREGADO antes del UPDATE, se cancela la operación
    IF EXISTS (
        SELECT 1
        FROM deleted d
        WHERE d.idEstado = 4  -- 4 = ENTREGADO
    )
    BEGIN
        RAISERROR ('No se permite modificar un pedido que ya fue ENTREGADO.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO

------------------------------------------------------------------------------

-- Trigger que impide eliminar un pedido que ya fue ENTREGADO.
CREATE TRIGGER trg_BloquearDeletePedidoEntregado
ON Pedido
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    -- Si alguno de los pedidos a eliminar está ENTREGADO, se bloquea
    IF EXISTS (
        SELECT 1
        FROM deleted d
        WHERE d.idEstado = 4  -- ENTREGADO
    )
    BEGIN
        RAISERROR ('No se permite eliminar un pedido que ya fue ENTREGADO.', 16, 1);
        RETURN;
    END
    -- Si no está entregado, se permite la eliminación real
    DELETE FROM Pedido
    WHERE id IN (SELECT id FROM deleted);
END;
GO


------------------------------------------------------------------------------
-- Trigger que impide modificar un picking si el pedido asociado ya fue ENTREGADO.
CREATE TRIGGER trg_BloquearUpdatePickingDePedidoEntregado
ON Picking
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    -- Si el picking pertenece a un pedido entregado, se cancela la operación
    IF EXISTS (
        SELECT 1
        FROM deleted d
        INNER JOIN Pedido p ON p.id = d.idPedido
        WHERE p.idEstado = 4   -- 4 = ENTREGADO
    )
    BEGIN
        RAISERROR ('No se permite modificar un picking de un pedido ya ENTREGADO.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO

------------------------------------------------------------------------------

-- Trigger que impide eliminar un picking si el pedido asociado ya fue ENTREGADO.
CREATE TRIGGER trg_BloquearDeletePickingDePedidoEntregado
ON Picking
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    -- Si el picking pertenece a un pedido entregado, se bloquea la eliminación
    IF EXISTS (
        SELECT 1
        FROM deleted d
        INNER JOIN Pedido p ON p.id = d.idPedido
        WHERE p.idEstado = 4   -- ENTREGADO
    )
    BEGIN
        RAISERROR ('No se permite eliminar un picking de un pedido ya ENTREGADO.', 16, 1);
        RETURN;
    END
    -- Si el pedido NO estaba entregado, se permite el delete real
    DELETE FROM Picking
    WHERE id IN (SELECT id FROM deleted);
END;
GO