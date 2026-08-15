CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS usuarios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    rol_id UUID NOT NULL,
    estado BOOLEAN NOT NULL DEFAULT TRUE,
	
    CONSTRAINT fk_usuario_rol
        FOREIGN KEY (rol_id)
        REFERENCES roles(id)
);

CREATE TABLE IF NOT EXISTS proveedores (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	nombre VARCHAR(100) NOT NULL UNIQUE,
	estado BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS categorias (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	nombre VARCHAR(100) NOT NULL UNIQUE,
	estado BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS productos (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	nombre VARCHAR(100) NOT NULL UNIQUE,
	proveedor_id UUID NOT NULL,
	categoria_id UUID NOT NULL,
	costo_actual NUMERIC(12, 2) NOT NULL,
	unidad_medida VARCHAR(30) NOT NULL,
	stock_actual INTEGER NOT NULL DEFAULT 0,
	tiempo_estimado_entrega INTEGER NOT NULL,
	estado BOOLEAN NOT NULL DEFAULT TRUE,
	
	CONSTRAINT fk_producto_proveedor
		FOREIGN KEY (proveedor_id)
		REFERENCES proveedores(id),

	CONSTRAINT fk_producto_categoria
		FOREIGN KEY (categoria_id)
		REFERENCES categorias(id),

	CONSTRAINT chk_producto_costo
		CHECK (costo_actual >= 0),
		
	CONSTRAINT chk_producto_stock
		CHECK (stock_actual >= 0),

	CONSTRAINT chk_producto_tiempo
		CHECK (tiempo_estimado_entrega >= 0)
);

CREATE TABLE IF NOT EXISTS compras (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	proveedor_id UUID NOT NULL,
	usuario_id UUID NOT NULL, 
	fecha_compra TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	estado VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
	total NUMERIC(12, 2) NOT NULL,

	CONSTRAINT fk_compra_proveedor
		FOREIGN KEY (proveedor_id)
		REFERENCES proveedores(id),

	CONSTRAINT fk_compra_usuario
		FOREIGN KEY (usuario_id)
		REFERENCES usuarios(id),

	CONSTRAINT chk_total
		CHECK (total >= 0),
		
    CONSTRAINT chk_compra_estado
        CHECK (
            estado IN (
                'PENDIENTE',
                'CONFIRMADA',
                'RECIBIDA',
                'CANCELADA'
            )
        )
);

CREATE TABLE IF NOT EXISTS detalle_compras (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	compra_id UUID NOT NULL,
	producto_id UUID NOT NULL,
	cantidad INTEGER NOT NULL,
	precio_unitario NUMERIC(12, 2) NOT NULL,
	subtotal NUMERIC(12, 2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,

	CONSTRAINT fk_detalle_compra
		FOREIGN KEY (compra_id)
		REFERENCES compras(id),

	CONSTRAINT fk_detalle_producto
		FOREIGN KEY (producto_id)
		REFERENCES productos(id),

	CONSTRAINT chk_cantidad
		CHECK (cantidad > 0),

	CONSTRAINT chk_detalle_compra_precio
        CHECK (precio_unitario >= 0),

    CONSTRAINT uq_detalle_compra_producto
        UNIQUE (compra_id, producto_id)
);

CREATE TABLE IF NOT EXISTS movimientos_inventario (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	producto_id UUID NOT NULL,
	usuario_id UUID NOT NULL,
	compra_id UUID,
	tipo_movimiento VARCHAR(20) NOT NULL,
	cantidad INTEGER NOT NULL,
	motivo VARCHAR(250),
	fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_movimiento_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(id),

    CONSTRAINT fk_movimiento_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id),

    CONSTRAINT fk_movimiento_compra
        FOREIGN KEY (compra_id)
        REFERENCES compras(id),

	CONSTRAINT chk_movimiento_cantidad
        CHECK (cantidad > 0),

	CONSTRAINT chk_movimiento_tipo
		CHECK (tipo_movimiento IN (
			'ENTRADA',
			'SALIDA',
			'AJUSTE'
		))
);