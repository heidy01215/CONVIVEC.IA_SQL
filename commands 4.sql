CREATE TABLE Rol (
  id_rol integer not null primary key,
  nombre_rol text not null,
  descripcion text not null
);
CREATE TABLE Usuario (
  id_usuario integer not null primary key,
  id_rol integer not null,
  nombre text not null,
  apellidos text not null,
  documento varchar (10) not null,
  correo varchar (30) null,
  telefono varchar (10) not null,
  contraseña varchar (15) not null,
  torre varchar (10) not null,
  apartamento varchar (15) not null,
  estado varchar (10) not null,
  foreign key (id_rol) references Rol(id_rol)
);
CREATE TABLE Solicitud(
  id_solicitud integer not null primary key,
  id_usuario integer not null,
  tipo_solicitud varchar(50) not null,
  descripcion text not null,
  fecha_registro timestamp not null,
  estado varchar (20) not null,
  prioridad varchar (10) not null,
foreign key (id_usuario) references Usuario(id_usuario)
);
CREATE TABLE Historial_solicitud (
  id_historial integer not null primary key,
  id_solicitud integer not null,
  id_usuario integer not null,
  estado_anterior varchar (20) not null,
  estado_nuevo varchar (20) not null,
  fecha_cambio timestamp not null,
  observacion text not null,
  foreign key (id_solicitud) references Solicitud ( id_solicitud),
  foreign key (id_usuario) references Usuario (id_usuario)
);
CREATE TABLE Pregunta_frecuente (
  id_pregunta integer not null primary key,
  pregunta varchar(100) not null, 
  respuesta varchar(100) not null,
  categoria varchar (50) not null,
  estado varchar(20) not null
);
CREATE TABLE Zona_comun (
  id_zona integer not null primary key,
  nombre_zona varchar(50) not null,
  descripcion text  not null,
  capacidad varchar (100) not null,
  horario_disponible varchar (100) not null,
  estado varchar (20) not null
);
CREATE TABLE Reserva (
  id_reserva integer not null primary key,
  id_usuario integer not null,
  id_zona integer not null,
  fecha_reserva timestamp not null,
  hora_inicio timestamp not null,
  hora_fin timestamp not null,
  estado varchar (50) not null,
  observacion text not null,
  foreign key (id_usuario) references Usuario (id_usuario),
  foreign key (id_zona) references Zona_comun (id_zona)
);
CREATE TABLE Comunicado (
  id_comunicado integer not null primary key,
  id_usuario integer not null,
  titulo text not null,
  contenido text not null,
  fecha_publicacion timestamp not null,
  tipo varchar (50) not null,
  estado text not null,
  foreign key (id_usuario) references Usuario (id_usuario)
);

INSERT INTO Rol  VALUES
(1, 'Administrador', 'Gestiona el conjunto, usuarios y comunicados'),
(2, 'Residente', 'Persona que vive en el conjunto'),
(3, 'Propietario', 'Dueño de un apartamento o casa'),
(4, 'Arrendatario', 'Persona que vive en arriendo'),
(5, 'Vigilante', 'Controla la entrada y salida de personas'),
(6, 'Conserje', 'Apoya en tareas generales del conjunto'),
(7, 'Contador', 'Maneja las cuentas y pagos de administración'),
(8, 'Consejo', 'Miembro del consejo de administración'),
(9, 'Mantenimiento', 'Repara daños en zonas comunes'),
(10, 'Visitante', 'Persona que ingresa de forma temporal');
INSERT INTO Usuario (id_usuario, id_rol, nombre, apellidos, documento, correo, telefono, contraseña, torre, apartamento, estado) VALUES
(1, 1, 'Carlos', 'Gómez Pérez', '1023456789', 'carlos@mail.com', '3101234567', 'Admin123', 'T1', '101', 'activo'),
(2, 2, 'Laura', 'Martínez Ruiz', '1034567890', 'laura@mail.com', '3209876543', 'Laura2026', 'T2', '204', 'activo'),
(3, 2, 'Andrés', 'López Díaz', '1045678901', 'andres@mail.com', '3154567890', 'Andres45', 'T3', '305', 'activo'),
(4, 2, 'Sofía', 'Ramírez Castro', '1056789012', 'sofia@mail.com', '3006543210', 'Sofi789', 'T4', '402', 'inactivo'),
(5, 2, 'Miguel', 'Torres Vega', '1067890123', 'miguel@mail.com', '3198901234', 'Miguel01', 'T5', '503', 'activo'),
(6, 2, 'Valentina', 'Rojas Mora', '1078901234', 'valen@mail.com', '3112345678', 'Valen2026', 'T1', '106', 'activo'),
(7, 2, 'Julián', 'Herrera Silva', '1089012345', 'julian@mail.com', '3223456789', 'Julian77', 'T2', '208', 'activo'),
(8, 2, 'Camila', 'Vargas León', '1090123456', 'camila@mail.com', '3134567890', 'Cami456', 'T3', '310', 'activo'),
(9, 2, 'Daniel', 'Castro Ríos', '1001234567', 'daniel@mail.com', '3045678901', 'Dani2026', 'T4', '407', 'inactivo'),
(10, 1, 'Paola', 'Suárez Niño', '1012345678', 'paola@mail.com', '3176789012', 'Paola321', 'T5', '509', 'activo');

INSERT INTO Solicitud  VALUES 
(1,  1, 'soporte',   'No puedo iniciar sesión en la plataforma',          '2026-10-01 08:15:00', 'pendiente',  'alta'),
(2,  2, 'consulta',  'Información sobre horarios de atención',            '2026-10-01 09:30:00', 'cerrada',    'baja'),
(3,  3, 'reclamo',   'Cobro duplicado en la factura de septiembre',       '2026-10-02 10:45:00', 'en_proceso', 'alta'),
(4,  1, 'soporte',   'Error al descargar el certificado en PDF',          '2026-10-03 14:20:00', 'cerrada',    'media'),
(5,  4, 'peticion',  'Solicitud de cambio de correo electrónico',         '2026-10-04 11:05:00', 'pendiente',  'baja'),
(6,  5, 'reclamo',   'El pedido llegó incompleto',                        '2026-10-05 16:40:00', 'en_proceso', 'alta'),
(7,  2, 'soporte',   'La aplicación se cierra al abrir el perfil',        '2026-10-07 07:55:00', 'pendiente',  'media'),
(8,  6, 'consulta',  'Requisitos para actualizar datos personales',       '2026-10-08 13:10:00', 'cerrada',    'baja'),
(9,  3, 'peticion',  'Solicitud de copia del historial de pagos',         '2026-10-10 09:00:00', 'en_proceso', 'media'),
(10, 5, 'reclamo',   'Demora de más de 15 días en respuesta anterior',    '2026-10-12 17:25:00', 'pendiente',  'alta');

INSERT INTO Historial_solicitud  VALUES
(1, 1, 1, 'RECIBIDA', 'EN_PROCESO', '2026-10-01 08:00:00', 'Se revisa la solicitud'),
(2, 1, 1, 'EN_PROCESO', 'RESUELTA', '2026-10-02 10:30:00', 'Se arregló la fuga de agua'),
(3, 2, 1, 'RECIBIDA', 'EN_PROCESO', '2026-10-03 09:15:00', 'Se asigna a mantenimiento'),
(4, 2, 1, 'EN_PROCESO', 'CERRADA', '2026-10-04 14:00:00', 'Residente confirma la solución'),
(5, 3, 1, 'RECIBIDA', 'EN_PROCESO', '2026-10-05 11:00:00', 'Se verifica el daño del ascensor'),
(6, 3, 1, 'EN_PROCESO', 'RESUELTA', '2026-10-06 16:45:00', 'Técnico reparó el ascensor'),
(7, 4, 1, 'RECIBIDA', 'EN_PROCESO', '2026-10-07 08:30:00', 'Se revisa queja por ruido'),
(8, 4, 1, 'EN_PROCESO', 'RESUELTA', '2026-10-08 12:00:00', 'Se habló con el vecino'),
(9, 5, 1, 'RECIBIDA', 'EN_PROCESO', '2026-10-09 09:00:00', 'Se revisa reserva del salón'),
(10, 5, 1, 'EN_PROCESO', 'CERRADA', '2026-10-10 15:20:00', 'Reserva aprobada');

INSERT INTO Pregunta_frecuente  VALUES
(1, '¿Cuál es el horario de la piscina?', 'De martes a domingo de 8:00 a.m. a 6:00 p.m.', 'Zonas comunes', 'ACTIVO'),
(2, '¿Cómo reservo el salón social?', 'Envía una solicitud en la plataforma con 3 días de anticipación', 'Zonas comunes', 'ACTIVO'),
(3, '¿Hasta qué día pago la administración?', 'Hasta el día 10 de cada mes', 'Pagos', 'ACTIVO'),
(4, '¿Dónde pago la administración?', 'En la cuenta del banco o en la oficina de administración', 'Pagos', 'ACTIVO'),
(5, '¿Puedo tener mascotas?', 'Sí, con collar, correa y recogiendo sus desechos', 'Convivencia', 'ACTIVO'),
(6, '¿Cuál es el horario de silencio?', 'De 10:00 p.m. a 7:00 a.m.', 'Convivencia', 'ACTIVO'),
(7, '¿Cómo reporto un daño?', 'Crea una solicitud en la plataforma explicando el daño', 'Solicitudes', 'ACTIVO'),
(8, '¿Cuánto tarda una solicitud?', 'Entre 1 y 5 días hábiles según el caso', 'Solicitudes', 'ACTIVO'),
(9, '¿Pueden entrar visitantes en carro?', 'Sí, deben registrarse en portería', 'Seguridad', 'ACTIVO'),
(10, '¿Hay parqueadero para visitantes?', 'Ya no, se usa para motos de residentes', 'Seguridad', 'INACTIVO');

INSERT INTO Zona_comun  VALUES
(1, 'Piscina', 'Piscina para adultos y niños', '30 personas', 'Martes a domingo 8:00 a.m. - 6:00 p.m.', 'DISPONIBLE'),
(2, 'Salón social', 'Salón para reuniones y celebraciones', '50 personas', 'Todos los días 9:00 a.m. - 10:00 p.m.', 'DISPONIBLE'),
(3, 'Gimnasio', 'Gimnasio con máquinas y pesas', '15 personas', 'Lunes a sábado 5:00 a.m. - 9:00 p.m.', 'DISPONIBLE'),
(4, 'Parque infantil', 'Zona de juegos para niños', '20 personas', 'Todos los días 7:00 a.m. - 7:00 p.m.', 'DISPONIBLE'),
(5, 'Cancha múltiple', 'Cancha de fútbol y baloncesto', '20 personas', 'Todos los días 6:00 a.m. - 8:00 p.m.', 'DISPONIBLE'),
(6, 'BBQ', 'Zona para asados', '15 personas', 'Fines de semana 10:00 a.m. - 8:00 p.m.', 'DISPONIBLE'),
(7, 'Sala de estudio', 'Espacio tranquilo para estudiar', '10 personas', 'Lunes a viernes 8:00 a.m. - 8:00 p.m.', 'DISPONIBLE'),
(8, 'Terraza', 'Terraza con vista al conjunto', '25 personas', 'Todos los días 8:00 a.m. - 9:00 p.m.', 'DISPONIBLE'),
(9, 'Sauna', 'Sauna para adultos', '6 personas', 'Martes a domingo 2:00 p.m. - 8:00 p.m.', 'EN_MANTENIMIENTO'),
(10, 'Cancha de tenis', 'Cancha de tenis al aire libre', '4 personas', 'No disponible', 'INACTIVO');

INSERT INTO Reserva  VALUES
(1, 1, 2, '2026-10-01 08:00:00', '2026-10-05 15:00:00', '2026-10-05 20:00:00', 'APROBADA', 'Fiesta de cumpleaños'),
(2, 2, 6, '2026-10-02 09:00:00', '2026-10-06 12:00:00', '2026-10-06 16:00:00', 'APROBADA', 'Asado familiar'),
(3, 3, 1, '2026-10-03 10:00:00', '2026-10-07 09:00:00', '2026-10-07 11:00:00', 'APROBADA', 'Clase de natación'),
(4, 4, 5, '2026-10-04 11:00:00', '2026-10-08 17:00:00', '2026-10-08 19:00:00', 'PENDIENTE', 'Partido de fútbol'),
(5, 5, 7, '2026-10-05 08:30:00', '2026-10-09 14:00:00', '2026-10-09 17:00:00', 'APROBADA', 'Reunión de estudio'),
(6, 1, 8, '2026-10-06 07:00:00', '2026-10-10 18:00:00', '2026-10-10 21:00:00', 'RECHAZADA', 'Horario ya ocupado'),
(7, 2, 2, '2026-10-07 12:00:00', '2026-10-12 10:00:00', '2026-10-12 14:00:00', 'APROBADA', 'Reunión del consejo'),
(8, 3, 3, '2026-10-08 06:00:00', '2026-10-13 06:00:00', '2026-10-13 07:00:00', 'CANCELADA', 'El residente canceló'),
(9, 4, 4, '2026-10-09 15:00:00', '2026-10-14 15:00:00', '2026-10-14 17:00:00', 'PENDIENTE', 'Celebración infantil'),
(10, 5, 6, '2026-10-10 16:00:00', '2026-10-17 11:00:00', '2026-10-17 15:00:00', 'APROBADA', 'Almuerzo de vecinos');

INSERT INTO Comunicado (id_comunicado, id_usuario, titulo, contenido, fecha_publicacion, tipo, estado) VALUES
(1, 1, 'Corte de agua', 'El martes no habrá agua de 8:00 a.m. a 2:00 p.m. por arreglo de tubería', '2026-10-01 07:00:00', 'Aviso', 'ACTIVO'),
(2, 1, 'Asamblea general', 'Se invita a todos los propietarios a la asamblea el sábado a las 9:00 a.m.', '2026-10-02 08:00:00', 'Reunión', 'ACTIVO'),
(3, 1, 'Pago de administración', 'Recuerden pagar la administración antes del día 10', '2026-10-03 09:00:00', 'Pagos', 'ACTIVO'),
(4, 1, 'Mantenimiento del ascensor', 'El ascensor de la torre 2 estará fuera de servicio el jueves', '2026-10-04 10:00:00', 'Mantenimiento', 'ACTIVO'),
(5, 1, 'Fumigación', 'El viernes se fumigarán las zonas comunes, mantener ventanas cerradas', '2026-10-05 07:30:00', 'Aviso', 'ACTIVO'),
(6, 1, 'Normas para mascotas', 'Las mascotas deben andar con correa y se deben recoger sus desechos', '2026-10-06 11:00:00', 'Convivencia', 'ACTIVO'),
(7, 1, 'Horario de silencio', 'Se recuerda que el horario de silencio es de 10:00 p.m. a 7:00 a.m.', '2026-10-07 12:00:00', 'Convivencia', 'ACTIVO'),
(8, 1, 'Sauna en mantenimiento', 'El sauna estará cerrado por reparación hasta nuevo aviso', '2026-10-08 08:00:00', 'Mantenimiento', 'ACTIVO'),
(9, 1, 'Fiesta de Halloween', 'Habrá actividad para niños el 31 de octubre en el salón social', '2026-10-09 15:00:00', 'Evento', 'ACTIVO'),
(10, 1, 'Cambio de vigilancia', 'Desde septiembre cambió la empresa de vigilancia', '2026-09-01 08:00:00', 'Aviso', 'INACTIVO');



UPDATE Usuario SET nombre = 'Heidy' WHERE id_usuario = 2;
Select *
FROM Usuario WHERE id_usuario = 2;


ALTER TABLE Usuario ADD COLUMN nacionalidad text;


Select *
FROM Solicitud 
WHERE fecha_registro between '2026-10-03 23:59:59' AND '2026-10-07 23:59:59';

Select *
FROM Usuario
WHERE correo is null

\dt  
