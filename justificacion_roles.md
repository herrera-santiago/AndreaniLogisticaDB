## Administrador
GRANTS: CONTROL sobre toda la base de datos.

Encargado de la configuración, mantenimiento y respaldo del sistema. Necesita acceso completo para tareas administrativas.

## Operador de Logistica
GRANTS: SELECT, INSERT, UPDATE, DELETE sobre entidades operativas (Cliente, Pedido, Lote, etc.)

Responsable de registrar y modificar la información operativa del día a día, sin acceso a la configuración de choferes o vehículos.

## Chofer
GRANTS: SELECT sobre rutas, pedidos, clientes, vehículos, etc. y UPDATE sobre Pedido.idEstado

Solo debe visualizar información relevante a sus entregas y actualizar el estado de un pedido.