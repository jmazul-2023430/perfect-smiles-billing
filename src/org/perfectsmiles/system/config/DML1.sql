use sonrisa_perfecta_IN4AM;

-- ================================================================= rol ===============================================================
call sp_create_rol('admin', 'administrador del sistema');
call sp_create_rol('dentist', 'odontologo');
call sp_create_rol('receptionist', 'recepcionista');
call sp_create_rol('assistant', 'asistente dental');

call sp_read_rol();

call sp_edit_rol('administrador', 'admin principal del sistema', 1);
call sp_edit_rol('odontologo especialista', 'odontologo con especialidad', 2);
call sp_edit_rol('recepcionista principal', 'recepcion de pacientes', 3);

call sp_delete_rol(2);
call sp_delete_rol(3);
call sp_delete_rol(4);

-- ================================================================= permiso ===============================================================
call sp_create_permiso('create_user', 'crear usuarios', 'users', true);
call sp_create_permiso('edit_user', 'editar usuarios', 'users', true);
call sp_create_permiso('delete_user', 'eliminar usuarios', 'users', true);
call sp_create_permiso('view_user', 'ver usuarios', 'users', true);

call sp_read_permiso();

call sp_edit_permiso('crear usuario', 'permiso para crear usuarios', 'users', true, 1);
call sp_edit_permiso('editar usuario', 'permiso para editar usuarios', 'users', true, 2);
call sp_edit_permiso('eliminar usuario', 'permiso para eliminar usuarios', 'users', true, 3);

call sp_delete_permiso(2);
call sp_delete_permiso(3);
call sp_delete_permiso(4);

-- ================================================================= rol_permiso ===============================================================
call sp_create_rol_permiso(1, 1, true);
call sp_create_rol_permiso(1, 2, true);
call sp_create_rol_permiso(1, 3, true);
call sp_create_rol_permiso(2, 5, true);

call sp_read_rol_permiso();

call sp_edit_rol_permiso(1, 1, false, 1);
call sp_edit_rol_permiso(1, 2, false, 2);
call sp_edit_rol_permiso(1, 3, false, 3);

call sp_delete_rol_permiso(2);
call sp_delete_rol_permiso(3);
call sp_delete_rol_permiso(4);

-- ================================================================= user ===============================================================
call sp_create_user(1, 'admin', 'hash123', 'admin sistema', 'admin@sonrisaperfecta.com', '50212345678', '2026-09-09 08:00:00', true);
call sp_create_user(2, 'dr.garcia', 'hash456', 'dr. carlos garcia', 'garcia@sonrisaperfecta.com', '50287654321', '2026-09-09 09:00:00', true);
call sp_create_user(2, 'dr.lopez', 'hash789', 'dra. maria lopez', 'lopez@sonrisaperfecta.com', '50211223344', '2026-09-09 09:30:00', true);

call sp_read_user();

call sp_edit_user(1, 'admin', 'hash123', 'admin principal', 'admin@sonrisaperfecta.com', '50212345678', '2026-09-09 08:00:00', true, 1);
call sp_edit_user(2, 'dr.garcia', 'hash456', 'dr. carlos garcia actualizado', 'garcia@sonrisaperfecta.com', '50287654321', '2026-09-09 09:00:00', true, 2);
call sp_edit_user(2, 'dr.lopez', 'hash789', 'dra. maria lopez actualizada', 'lopez@sonrisaperfecta.com', '50211223344', '2026-09-09 09:30:00', true, 3);

call sp_delete_user(2);
call sp_delete_user(3);
call sp_delete_user(4);

-- ================================================================= patient ===============================================================
call sp_create_patient('juan', 'perez', '1234567890123', '50299887766', 'juan.perez@email.com', 'zona 1, ciudad de guatemala', true);
call sp_create_patient('maria', 'gonzalez', '9876543210987', '50288776655', 'maria.gonzalez@email.com', 'zona 10, ciudad de guatemala', true);
call sp_create_patient('pedro', 'ramirez', '4567891230456', '50277665544', 'pedro.ramirez@email.com', 'zona 4, mixco', true);

call sp_read_patient();

call sp_edit_patient('juan', 'perez actualizado', '1234567890123', '50299887766', 'juan.perez@email.com', 'zona 1, ciudad de guatemala', true, 1);
call sp_edit_patient('maria', 'gonzalez actualizada', '9876543210987', '50288776655', 'maria.gonzalez@email.com', 'zona 10, ciudad de guatemala', true, 2);
call sp_edit_patient('pedro', 'ramirez actualizado', '4567891230456', '50277665544', 'pedro.ramirez@email.com', 'zona 4, mixco', true, 3);

call sp_delete_patient(2);
call sp_delete_patient(3);
call sp_delete_patient(4);

-- ================================================================= tratamiento ===============================================================
call sp_create_tratamiento(2, 'TRT-001', 'limpieza dental', 250.00, true, 'limpieza profesional de dientes y encias');
call sp_create_tratamiento(2, 'TRT-002', 'extraccion simple', 500.00, true, 'extraccion de pieza dental sin complicaciones');
call sp_create_tratamiento(3, 'TRT-004', 'obturacion composite', 350.00, true, 'restauracion dental con resina composite');

call sp_read_tratamiento();

call sp_edit_tratamiento(2, 'TRT-001', 'limpieza dental profunda', 300.00, true, 'limpieza con ultrasonido', 1);
call sp_edit_tratamiento(2, 'TRT-002', 'extraccion simple actualizada', 550.00, true, 'extraccion sin complicaciones', 2);
call sp_edit_tratamiento(3, 'TRT-004', 'obturacion composite avanzada', 400.00, true, 'restauracion con resina de alta calidad', 3);

call sp_delete_tratamiento(2);
call sp_delete_tratamiento(3);
call sp_delete_tratamiento(4);

-- ================================================================= presupuesto ===============================================================
call sp_create_presupuesto(1, 2, '2026-09-01', 250.00, 30.00, 280.00, true);
call sp_create_presupuesto(2, 3, '2026-09-03', 3850.00, 462.00, 4312.00, true);
call sp_create_presupuesto(3, 2, '2026-09-05', 12500.00, 1500.00, 14000.00, true);

call sp_read_presupuesto();

call sp_edit_presupuesto(1, 2, '2026-09-01', 300.00, 36.00, 336.00, true, 1);
call sp_edit_presupuesto(2, 3, '2026-09-03', 4000.00, 480.00, 4480.00, true, 2);
call sp_edit_presupuesto(3, 2, '2026-09-05', 13000.00, 1560.00, 14560.00, true, 3);

call sp_delete_presupuesto(2);
call sp_delete_presupuesto(3);
call sp_delete_presupuesto(4);

-- ================================================================= presupuesto_detalle ===============================================================
call sp_create_presupuesto_detalle(1, 1, 250.00, 1, 250.00);
call sp_create_presupuesto_detalle(2, 4, 350.00, 2, 700.00);
call sp_create_presupuesto_detalle(3, 9, 12000.00, 1, 12000.00);

call sp_read_presupuesto_detalle();

call sp_edit_presupuesto_detalle(1, 1, 300.00, 1, 300.00, 1);
call sp_edit_presupuesto_detalle(2, 4, 400.00, 2, 800.00, 2);
call sp_edit_presupuesto_detalle(3, 9, 12500.00, 1, 12500.00, 3);

call sp_delete_presupuesto_detalle(2);
call sp_delete_presupuesto_detalle(3);
call sp_delete_presupuesto_detalle(4);