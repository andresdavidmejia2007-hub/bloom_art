CREATE TABLE roles (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  descripcion TEXT NULL,
  imagen VARCHAR(255) NULL,
  PRIMARY KEY (id_categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cuponesdescuento (
  id_cupon INT NOT NULL AUTO_INCREMENT,
  codigo VARCHAR(50) NOT NULL,
  porcentajeDescuento DECIMAL(5,2) NOT NULL,
  estatus VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_cupon)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  telefono VARCHAR(20) NULL,
  correo VARCHAR(100) NOT NULL,
  contrasena VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE vendedor (
  id_vendedor INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  celular VARCHAR(20) NULL,
  correo VARCHAR(100) NOT NULL,
  contrasena VARCHAR(255) NOT NULL,
  registro_de_ventas INT NULL,
  PRIMARY KEY (id_vendedor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE administrador (
  id_admin INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  clave VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_admin),
  CONSTRAINT fk_admin_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE producto (
  id_Producto INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT NULL,
  precioUnitario DECIMAL(10,2) NOT NULL,
  cantidad INT NOT NULL,
  id_Categoria INT NOT NULL,
  imagenURL VARCHAR(255) NULL,
  PRIMARY KEY (id_Producto),
  CONSTRAINT fk_producto_categoria FOREIGN KEY (id_Categoria) REFERENCES categoria (id_categoria) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE inventario (
  id_Inventario INT NOT NULL AUTO_INCREMENT,
  cantidad INT NOT NULL,
  ventas INT NOT NULL,
  id_prod_producto INT NOT NULL,
  id_vendedor INT NOT NULL,
  PRIMARY KEY (id_Inventario),
  CONSTRAINT fk_inventario_producto FOREIGN KEY (id_prod_producto) REFERENCES producto (id_Producto) ON DELETE CASCADE,
  CONSTRAINT fk_inventario_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pedido (
  id_Pedido INT NOT NULL AUTO_INCREMENT,
  fecha DATE NOT NULL,
  estado VARCHAR(50) NOT NULL,
  metodo_Envio VARCHAR(50) NOT NULL,
  direccion VARCHAR(255) NOT NULL,
  idCliente INT NOT NULL,
  PRIMARY KEY (id_Pedido),
  CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES usuario (id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE carrito (
  id_carrito INT NOT NULL AUTO_INCREMENT,
  fecha_Creacion DATETIME NOT NULL,
  id_producto INT NOT NULL,
  PRIMARY KEY (id_carrito),
  CONSTRAINT fk_carrito_producto FOREIGN KEY (id_producto) REFERENCES producto (id_Producto) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE personalizacion (
  id_Personalizacion INT NOT NULL AUTO_INCREMENT,
  paletaColores VARCHAR(50) NULL,
  textoPersonalizado TEXT NULL,
  PRIMARY KEY (id_Personalizacion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE detalle_Carrito (
  id_detalle INT NOT NULL AUTO_INCREMENT,
  cantidad INT NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  idCarrito INT NOT NULL,
  idProducto INT NOT NULL,
  idPersonalizacion INT NOT NULL,
  PRIMARY KEY (id_detalle),
  CONSTRAINT fk_detalle_carrito FOREIGN KEY (idCarrito) REFERENCES carrito (id_carrito) ON DELETE CASCADE,
  CONSTRAINT fk_detalle_producto FOREIGN KEY (idProducto) REFERENCES producto (id_Producto) ON DELETE CASCADE,
  CONSTRAINT fk_detalle_personalizacion FOREIGN KEY (idPersonalizacion) REFERENCES personalizacion (id_Personalizacion) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE compras (
  id_compra INT NOT NULL AUTO_INCREMENT,
  direccion VARCHAR(255) NOT NULL,
  metodoEnvio VARCHAR(50) NOT NULL,
  costo DECIMAL(10,2) NOT NULL,
  idPedido INT NOT NULL,
  PRIMARY KEY (id_compra),
  CONSTRAINT fk_compras_pedido FOREIGN KEY (idPedido) REFERENCES pedido (id_Pedido) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE metodo_pago (
  id_pago INT NOT NULL AUTO_INCREMENT,
  tipo_pago VARCHAR(50) NOT NULL,
  id_compra INT NOT NULL,
  PRIMARY KEY (id_pago),
  CONSTRAINT fk_metodopago_compras FOREIGN KEY (id_compra) REFERENCES compras (id_compra) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pago (
  idpago INT NOT NULL AUTO_INCREMENT,
  monto DECIMAL(10,2) NOT NULL,
  metodoPago VARCHAR(50) NOT NULL,
  estado VARCHAR(50) NOT NULL,
  idPedido INT NOT NULL,
  PRIMARY KEY (idpago),
  CONSTRAINT fk_pago_pedido FOREIGN KEY (idPedido) REFERENCES pedido (id_Pedido) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE envio (
  id_Envio INT NOT NULL AUTO_INCREMENT,
  direccion VARCHAR(255) NOT NULL,
  metodoEnvio VARCHAR(50) NOT NULL,
  costo DECIMAL(10,2) NOT NULL,
  id_Pedido INT NOT NULL,
  PRIMARY KEY (id_Envio),
  CONSTRAINT fk_envio_pedido FOREIGN KEY (id_Pedido) REFERENCES pedido (id_Pedido) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE resena (
  id_resena INT NOT NULL AUTO_INCREMENT,
  calificacion INT NOT NULL,
  comentario TEXT NULL,
  idUsuario INT NOT NULL,
  idProducto INT NOT NULL,
  idEnvio INT NOT NULL,
  PRIMARY KEY (id_resena),
  CONSTRAINT fk_resena_usuario FOREIGN KEY (idUsuario) REFERENCES usuario (id_usuario) ON DELETE CASCADE,
  CONSTRAINT fk_resena_producto FOREIGN KEY (idProducto) REFERENCES producto (id_Producto) ON DELETE CASCADE,
  CONSTRAINT fk_resena_envio FOREIGN KEY (idEnvio) REFERENCES envio (id_Envio) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE registra_caja (
  id_caja INT NOT NULL AUTO_INCREMENT,
  metodoEnvio VARCHAR(50) NOT NULL,
  costo DECIMAL(10,2) NOT NULL,
  idPedido INT NOT NULL,
  PRIMARY KEY (id_caja),
  CONSTRAINT fk_registracaja_pedido FOREIGN KEY (idPedido) REFERENCES pedido (id_Pedido) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE factura (
  id_factura INT NOT NULL AUTO_INCREMENT,
  fecha DATE NOT NULL,
  descripcion TEXT NULL,
  sub_total DECIMAL(10,2) NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  id_vendedor INT NOT NULL,
  id_producto INT NOT NULL,
  id_caja INT NOT NULL,
  PRIMARY KEY (id_factura),
  CONSTRAINT fk_factura_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor) ON DELETE CASCADE,
  CONSTRAINT fk_factura_producto FOREIGN KEY (id_producto) REFERENCES producto (id_Producto) ON DELETE CASCADE,
  CONSTRAINT fk_factura_registracaja FOREIGN KEY (id_caja) REFERENCES registra_caja (id_caja) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE registro_cuenta (
  id_registro INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  correo VARCHAR(100) NOT NULL,
  contrasena VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_registro),
  CONSTRAINT fk_registrocuenta_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;