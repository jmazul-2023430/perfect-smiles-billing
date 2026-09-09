drop database if exists sonrisa_perfecta_IN4AM;
create database sonrisa_perfecta_IN4AM;
use sonrisa_perfecta_IN4AM;

create table rol (
    id_rol int auto_increment,
    nombre_rol varchar(50) not null,
    descripcion varchar(100),
    constraint pk_rol primary key (id_rol)
);

create table permiso (
    id_permiso int auto_increment,
    nombre varchar(50) not null,
    descripcion varchar(50),
    modulo varchar(50),
    estado boolean default true,
    constraint pk_permiso primary key (id_permiso)
);

create table rol_permiso (
    id_rol_permiso int auto_increment,
    id_rol int not null,
    id_permiso int not null,
    estado boolean default true,
    constraint pk_rol_permiso primary key (id_rol_permiso),
    constraint fk_rol_permiso_rol foreign key (id_rol) references rol(id_rol) on delete cascade,
    constraint fk_rol_permiso_permiso foreign key (id_permiso) references permiso(id_permiso) on delete cascade
);

create table user (
    id_user int auto_increment,
    id_rol int not null,
    user varchar(50) not null,
    password_hash varchar(255) not null,
    complete_name varchar(100) not null,
    email varchar(100),
    telefono varchar(15),
    ultimo_acceso datetime,
    estado boolean default true,
    constraint pk_user primary key (id_user),
    constraint fk_user_rol foreign key (id_rol) references rol(id_rol),
    constraint uq_user_username unique (user)
);

create table patient (
    id_paciente int auto_increment,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    dpi varchar(20),
    telefono varchar(15),
    email varchar(100),
    direccion varchar(100),
    estado boolean default true,
    constraint pk_patient primary key (id_paciente)
);

create table tratamiento (
    id_tratamiento int auto_increment,
    id_user int not null,
    codigo_interno varchar(20),
    nombre varchar(120) not null,
    costo_estandar decimal(10, 2),
    estado boolean default true,
    descripcion varchar(500),
    constraint pk_tratamiento primary key (id_tratamiento),
    constraint fk_tratamiento_user foreign key (id_user) references user(id_user)
);

create table presupuesto (
    id_presupuesto int auto_increment,
    id_paciente int not null,
    id_user int not null,
    fecha_emision date not null,
    subtotal decimal(10, 2),
    iva decimal(10, 2),
    total decimal(10, 2),
    estado boolean default true,
    constraint pk_presupuesto primary key (id_presupuesto),
    constraint fk_presupuesto_patient foreign key (id_paciente) references patient(id_paciente),
    constraint fk_presupuesto_user foreign key (id_user) references user(id_user)
);

create table presupuesto_detalle (
    id_detalle_presupuesto int auto_increment,
    id_presupuesto int not null,
    id_tratamiento int not null,
    precio_unitario decimal(10, 2) not null,
    cantidad int not null,
    subtotal decimal(10, 2),
    constraint pk_presupuesto_detalle primary key (id_detalle_presupuesto),
    constraint fk_detalle_presupuesto foreign key (id_presupuesto) references presupuesto(id_presupuesto) on delete cascade,
    constraint fk_detalle_tratamiento foreign key (id_tratamiento) references tratamiento(id_tratamiento)
);



-- ================================================ rol =============================================

-- Crate
delimiter $$
create procedure sp_create_rol(in nombre_rol_p varchar(50), in descripcion_p varchar(100))
begin
    insert into rol(nombre_rol, descripcion)
        values(nombre_rol_p, descripcion_p);
end $$
delimiter ;

-- Read 
delimiter $$
create procedure sp_read_rol()
begin
    select 
        id_rol as ID_ROL,
        nombre_rol as `Role Name`,
        descripcion as Description
        from rol;
end $$
delimiter ;


-- Edit 
delimiter $$
create procedure sp_edit_rol(in nombre_rol_p varchar(50), in descripcion_p varchar(100), in id_rol_p int)
begin
    update rol set 
        nombre_rol = nombre_rol_p,
        descripcion = descripcion_p
        where id_rol = id_rol_p;
end $$
delimiter ;

-- Delete 
delimiter $$
create procedure sp_delete_rol(in id_rol_p int)
begin
    delete from rol
        where id_rol = id_rol_p;
end $$
delimiter ;


-- ======================================= permiso =================================

-- Create
delimiter $$
create procedure sp_create_permiso(in nombre_p varchar(50), in descripcion_p varchar(50), in modulo_p varchar(50), in estado_p boolean)
begin
    insert into permiso(nombre, descripcion, modulo, estado)
        values(nombre_p, descripcion_p, modulo_p, estado_p);
end $$
delimiter ;

-- Read
delimiter $$
create procedure sp_read_permiso()
begin
    select 
        id_permiso as ID_PERMISO,
        nombre as `Permission Name`,
        descripcion as Description,
        modulo as Module,
        estado as Status
        from permiso;
end $$
delimiter ;

-- Edit
delimiter $$
create procedure sp_edit_permiso(in nombre_p varchar(50), in descripcion_p varchar(50), in modulo_p varchar(50), in estado_p boolean, in id_permiso_p int)
begin
    update permiso set 
        nombre = nombre_p,
        descripcion = descripcion_p,
        modulo = modulo_p,
        estado = estado_p
        where id_permiso = id_permiso_p;
end $$
delimiter ;

-- Delete
delimiter $$
create procedure sp_delete_permiso(in id_permiso_p int)
begin
    delete from permiso
        where id_permiso = id_permiso_p;
end $$
delimiter ;


-- ================================== rol_permiso =============================================
-- Create
delimiter $$
create procedure sp_create_rol_permiso(in id_rol_p int, in id_permiso_p int, in estado_p boolean)
begin
    insert into rol_permiso(id_rol, id_permiso, estado)
        values(id_rol_p, id_permiso_p, estado_p);
end $$
delimiter ;

-- Read
delimiter $$
create procedure sp_read_rol_permiso()
begin
    select 
        id_rol_permiso as ID_ROL_PERMISO,
        id_rol as ID_ROL,
        id_permiso as ID_PERMISO,
        estado as Status
        from rol_permiso;
end $$
delimiter ;

-- Edit
delimiter $$
create procedure sp_edit_rol_permiso(in id_rol_p int, in id_permiso_p int, in estado_p boolean, in id_rol_permiso_p int)
begin
    update rol_permiso set 
        id_rol = id_rol_p,
        id_permiso = id_permiso_p,
        estado = estado_p
        where id_rol_permiso = id_rol_permiso_p;
end $$
delimiter ;

-- Delete
delimiter $$
create procedure sp_delete_rol_permiso(in id_rol_permiso_p int)
begin
    delete from rol_permiso
        where id_rol_permiso = id_rol_permiso_p;
end $$
delimiter ;


-- =========================================================== user ===============================================

-- Create
delimiter $$
create procedure sp_create_user(in id_rol_p int, in user_p varchar(50), in password_hash_p varchar(255), in complete_name_p varchar(100), in email_p varchar(100), in telefono_p varchar(15), in ultimo_acceso_p datetime, in estado_p boolean)
begin
    insert into user(id_rol, user, password_hash, complete_name, email, telefono, ultimo_acceso, estado)
        values(id_rol_p, user_p, password_hash_p, complete_name_p, email_p, telefono_p, ultimo_acceso_p, estado_p);
end $$
delimiter ;

-- Read
delimiter $$
create procedure sp_read_user()
begin
    select 
        id_user as ID_USER,
        id_rol as ID_ROL,
        user as Username,
        complete_name as `Complete Name`,
        email as Email,
        telefono as Phone,
        ultimo_acceso as `Last Access`,
        estado as Status
        from user;
end $$
delimiter ;

-- Edit
delimiter $$
create procedure sp_edit_user(in id_rol_p int, in user_p varchar(50), in password_hash_p varchar(255), in complete_name_p varchar(100), in email_p varchar(100), in telefono_p varchar(15), in ultimo_acceso_p datetime, in estado_p boolean, in id_user_p int)
begin
    update user set 
        id_rol = id_rol_p,
        user = user_p,
        password_hash = password_hash_p,
        complete_name = complete_name_p,
        email = email_p,
        telefono = telefono_p,
        ultimo_acceso = ultimo_acceso_p,
        estado = estado_p
        where id_user = id_user_p;
end $$
delimiter ;

-- Delete
delimiter $$
create procedure sp_delete_user(in id_user_p int)
begin
    delete from user
        where id_user = id_user_p;
end $$
delimiter ;

-- ===========================================================  patient =============================================================

-- Create
delimiter $$
create procedure sp_create_patient(in nombre_p varchar(100), in apellido_p varchar(100), in dpi_p varchar(20), in telefono_p varchar(15), in email_p varchar(100), in direccion_p varchar(100), in estado_p boolean)
begin
    insert into patient(nombre, apellido, dpi, telefono, email, direccion, estado)
        values(nombre_p, apellido_p, dpi_p, telefono_p, email_p, direccion_p, estado_p);
end $$
delimiter ;

-- Read
delimiter $$
create procedure sp_read_patient()
begin
    select 
        id_paciente as ID_PATIENT,
        nombre as `First Name`,
        apellido as `Last Name`,
        dpi as DPI,
        telefono as Phone,
        email as Email,
        direccion as Address,
        estado as Status
        from patient;
end $$
delimiter ;

-- Edit
delimiter $$
create procedure sp_edit_patient(in nombre_p varchar(100), in apellido_p varchar(100), in dpi_p varchar(20), in telefono_p varchar(15), in email_p varchar(100), in direccion_p varchar(100), in estado_p boolean, in id_paciente_p int)
begin
    update patient set 
        nombre = nombre_p,
        apellido = apellido_p,
        dpi = dpi_p,
        telefono = telefono_p,
        email = email_p,
        direccion = direccion_p,
        estado = estado_p
        where id_paciente = id_paciente_p;
end $$
delimiter ;

-- Delete
delimiter $$
create procedure sp_delete_patient(in id_paciente_p int)
begin
    delete from patient
        where id_paciente = id_paciente_p;
end $$
delimiter ;

-- =================================================== tratamiento ============================================================================

-- Create
delimiter $$
create procedure sp_create_tratamiento(in id_user_p int, in codigo_interno_p varchar(20), in nombre_p varchar(120), in costo_estandar_p decimal(10,2), in estado_p boolean, in descripcion_p text)
begin
    insert into tratamiento(id_user, codigo_interno, nombre, costo_estandar, estado, descripcion)
        values(id_user_p, codigo_interno_p, nombre_p, costo_estandar_p, estado_p, descripcion_p);
end $$
delimiter ;

-- Read
delimiter $$
create procedure sp_read_tratamiento()
begin
    select 
        id_tratamiento as ID_TREATMENT,
        id_user as ID_USER,
        codigo_interno as `Internal Code`,
        nombre as `Treatment Name`,
        costo_estandar as `Standard Cost`,
        estado as Status,
        descripcion as Description
        from tratamiento;
end $$
delimiter ;

-- Edit
delimiter $$
create procedure sp_edit_tratamiento(in id_user_p int, in codigo_interno_p varchar(20), in nombre_p varchar(120), in costo_estandar_p decimal(10,2), in estado_p boolean, in descripcion_p text, in id_tratamiento_p int)
begin
    update tratamiento set 
        id_user = id_user_p,
        codigo_interno = codigo_interno_p,
        nombre = nombre_p,
        costo_estandar = costo_estandar_p,
        estado = estado_p,
        descripcion = descripcion_p
        where id_tratamiento = id_tratamiento_p;
end $$
delimiter ;

-- Delete
delimiter $$
create procedure sp_delete_tratamiento(in id_tratamiento_p int)
begin
    delete from tratamiento
        where id_tratamiento = id_tratamiento_p;
end $$
delimiter ;


-- ======================================================================= presupuesto ============================================================


-- Create
delimiter $$
create procedure sp_create_presupuesto(in id_paciente_p int, in id_user_p int, in fecha_emision_p date, in subtotal_p decimal(10,2), in iva_p decimal(10,2), in total_p decimal(10,2), in estado_p boolean)
begin
    insert into presupuesto(id_paciente, id_user, fecha_emision, subtotal, iva, total, estado)
        values(id_paciente_p, id_user_p, fecha_emision_p, subtotal_p, iva_p, total_p, estado_p);
end $$
delimiter ;

-- Read
delimiter $$
create procedure sp_read_presupuesto()
begin
    select 
        id_presupuesto as ID_BUDGET,
        id_paciente as ID_PATIENT,
        id_user as ID_USER,
        fecha_emision as `Issue Date`,
        subtotal as Subtotal,
        iva as IVA,
        total as Total,
        estado as Status
        from presupuesto;
end $$
delimiter ;

-- Edit
delimiter $$
create procedure sp_edit_presupuesto(in id_paciente_p int, in id_user_p int, in fecha_emision_p date, in subtotal_p decimal(10,2), in iva_p decimal(10,2), in total_p decimal(10,2), in estado_p boolean, in id_presupuesto_p int)
begin
    update presupuesto set 
        id_paciente = id_paciente_p,
        id_user = id_user_p,
        fecha_emision = fecha_emision_p,
        subtotal = subtotal_p,
        iva = iva_p,
        total = total_p,
        estado = estado_p
        where id_presupuesto = id_presupuesto_p;
end $$
delimiter ;

-- Delete
delimiter $$
create procedure sp_delete_presupuesto(in id_presupuesto_p int)
begin
    delete from presupuesto
        where id_presupuesto = id_presupuesto_p;
end $$
delimiter ;

-- ====================================================================== presupuesto_detalle ======================================================


-- Create
delimiter $$
create procedure sp_create_presupuesto_detalle(in id_presupuesto_p int, in id_tratamiento_p int, in precio_unitario_p decimal(10,2), in cantidad_p int, in subtotal_p decimal(10,2))
begin
    insert into presupuesto_detalle(id_presupuesto, id_tratamiento, precio_unitario, cantidad, subtotal)
        values(id_presupuesto_p, id_tratamiento_p, precio_unitario_p, cantidad_p, subtotal_p);
end $$
delimiter ;

-- Read
delimiter $$
create procedure sp_read_presupuesto_detalle()
begin
    select 
        id_detalle_presupuesto as ID_BUDGET_DETAIL,
        id_presupuesto as ID_BUDGET,
        id_tratamiento as ID_TREATMENT,
        precio_unitario as `Unit Price`,
        cantidad as Quantity,
        subtotal as Subtotal
        from presupuesto_detalle;
end $$
delimiter ;

-- Edit
delimiter $$
create procedure sp_edit_presupuesto_detalle(in id_presupuesto_p int, in id_tratamiento_p int, in precio_unitario_p decimal(10,2), in cantidad_p int, in subtotal_p decimal(10,2), in id_detalle_presupuesto_p int)
begin
    update presupuesto_detalle set 
        id_presupuesto = id_presupuesto_p,
        id_tratamiento = id_tratamiento_p,
        precio_unitario = precio_unitario_p,
        cantidad = cantidad_p,
        subtotal = subtotal_p
        where id_detalle_presupuesto = id_detalle_presupuesto_p;
end $$
delimiter ;

-- Delete
delimiter $$
create procedure sp_delete_presupuesto_detalle(in id_detalle_presupuesto_p int)
begin
    delete from presupuesto_detalle
        where id_detalle_presupuesto = id_detalle_presupuesto_p;
end $$
delimiter ;

