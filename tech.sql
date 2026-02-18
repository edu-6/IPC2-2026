CREATE DATABASE techsupply;
USE techsupply;

CREATE TABLE producto (
 codigo_producto INTEGER AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(50) NOT NULL,
 descripcion VARCHAR(100) NOT NULL,
 cantidad_stock INTEGER NOT NULL,
 precio_unitario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE proveedor (
 codigo_proveedor INTEGER AUTO_INCREMENT PRIMARY KEY,
 nombre_proveedor VARCHAR(50) NOT NULL,
 direccion_proveedor VARCHAR(100) NOT NULL,
 contacto_proveedor VARCHAR(50) NOT NULL
);

CREATE TABLE producto_proveedor (
 codigo_proveedor INTEGER NOT NULL,
 precio_unitario DECIMAL(10, 2) NOT NULL,
 codigo_producto INTEGER NOT NULL,
 CONSTRAINT pk_prod_prov PRIMARY KEY (codigo_proveedor,codigo_producto),
 CONSTRAINT fk_proveedor_prod_prov FOREIGN KEY (codigo_proveedor) REFERENCES proveedor(codigo_proveedor) ON DELETE CASCADE,
 CONSTRAINT fk_producto_prod_prov FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto) ON DELETE CASCADE
);

CREATE TABLE cliente (
 id_cliente VARCHAR(15) PRIMARY KEY NOT NULL,
 nombre_cliente VARCHAR(70) NOT NULL,
 tipo_cliente VARCHAR(10) NOT NULL,
 direccion_cliente VARCHAR(30) NOT NULL
);

CREATE TABLE sucursal (
 id_sucursal INTEGER AUTO_INCREMENT PRIMARY KEY,
 nombre_sucrusal VARCHAR(50) NOT NULL UNIQUE,
 ubicacion_sucursal VARCHAR(30) NOT NULL
);

CREATE TABLE empleado (
 id_empleado VARCHAR(15) NOT NULL PRIMARY KEY,
 codigo_sucursal INTEGER NOT NULL,
 cargo VARCHAR(50) NOT NULL,
 nombre_empleado VARCHAR(30) NOT NULL,
 CONSTRAINT fk_sucursal_empleado FOREIGN KEY (codigo_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE CASCADE
);

CREATE TABLE pedido (
 codigo_pedido INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
 id_cliente VARCHAR(15) NOT NULL,
 id_empleado VARCHAR(15) NOT NULL,
 fecha_compra DATE NOT NULL,
 CONSTRAINT fk_cliente_pedido FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
 CONSTRAINT fk_empleado_pedido FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE
);

CREATE TABLE producto_pedido (
 id_pedido INTEGER NOT NULL,
 id_producto INTEGER NOT NULL,
 cantidad INTEGER NOT NULL,
 CONSTRAINT pk_prod_ped PRIMARY KEY (id_pedido,id_producto),
 CONSTRAINT fk_pedido_prod_ped FOREIGN KEY (id_pedido) REFERENCES pedido(codigo_pedido) ON DELETE CASCADE,
 CONSTRAINT fk_prod_prod_ped FOREIGN KEY (id_producto) REFERENCES producto(codigo_producto) ON DELETE CASCADE
);

CREATE TABLE factura (
 numero_factura INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
 codigo_pedido INTEGER NOT NULL,
 id_empleado VARCHAR(15) NOT NULL,
 fecha_emision DATE NOT NULL,
 total DECIMAL(10, 2) NOT NULL,
 pagado BOOLEAN,
 CONSTRAINT fk_pedido_factura FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo_pedido) ON DELETE CASCADE,
 CONSTRAINT fk_empleado_factura FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE
);
