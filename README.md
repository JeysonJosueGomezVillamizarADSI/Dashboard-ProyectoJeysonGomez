# Creación de procedimiento LOGIN(Corregido)

```sql
DELIMITER $$
CREATE OR REPLACE PROCEDURE login(IN user varchar(40), IN cont varchar(40))
BEGIN
	SELECT `id` as 'numero', `admin` as 'usuario', `contrasena` as 'id' FROM `tb_login` WHERE `admin`= user AND `contraseña`= cont;
END$$
DELIMITER ;
```



# Procedimientos

#### (Correcion Procedimiento)tabla empleados , Empleados Activos 

```sql
DELIMITER $$
CREATE OR REPLACE PROCEDURE Empleados_Activos()
BEGIN
set @activos = (SELECT COUNT(Ced_Empleado) as 'Empleados' FROM tb_empleado WHERE Estado_Empleado= 'Activo');
set @empleados = (SELECT COUNT(*) FROM `tb_empleado` WHERE Ced_Empleado);
set @porcentaje = (@activos/@empleados)*100;
SELECT @empleados as "Total","Empleados Activos" AS "Empleados Activos", @porcentaje AS 'Porcentaje', @activos AS 'Total empleados activos';
END$$
DELIMITER ;

```

#### Procedimiento tabla teléfono , Cantidad de teléfonos de los empleados

```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE Telefonos_Empleados()
BEGIN 
	SET @CantidadTelefono = (SELECT COUNT(Id_Telef) FROM tb_telef_empleado INNER JOIN tb_empleado WHERE Ced_Empleado=tb_telef_empleado.Ced_Empleado_fk);
	SET @CantidadTotal = (SELECT COUNT(*) FROM tb_telef_empleado);
	SET @Porcentaje = (@cantidadTelefono/@cantidadTotal) * 100;  
	SELECT @CantidadTotal as "Total","Empleados con numeros de telefono" as "Telefonos",@porcentaje AS "Porcentaje",@CantidadTelefono as "Telefonos Empleados" ;
END //
DELIMITER ;
```


#### (Correcion)Procedimiento tabla rol empleado, Cantidad Empleados con el rol de Emplantillador

```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE Rol_Empleados()
BEGIN
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_rol_emple);
SET @cantidadRol = (SELECT COUNT(Nomb_Rol) FROM tb_rol_emple WHERE Nomb_Rol LIKE "Emplantillador(a)");
SET @porcentaje = (@cantidadRol/@cantidadTotal) * 100;  
SELECT @cantidadTotal as "Total","Empleados  con el rol Emplantillador" as "empleado",@porcentaje AS "Porcentaje",@cantidadRol as "total";
END //
DELIMITER ;
```

#### Procedimiento tabla Puesto Empleado, Cantidad Empleados con el Salario menor a 1'400.000

```sql
DELIMITER $$
CREATE OR REPLACE PROCEDURE Salario_Menor()
BEGIN 
SET @cantidadSalario = (SELECT COUNT(tb_puesto_emple.Id_Puesto_Emple) FROM tb_puesto_emple WHERE tb_puesto_emple.Salar_Empleado <= 1400000);
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_puesto_emple);
SET @porcentaje = @cantidadSalario/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Empleados con salario menor a 1400000" as "Salarios",@porcentaje AS "Porcentaje",@cantidadSalario"Subtotal";
END$$
```

#### Procedimiento tabla Puesto ,  Cantidad Empleados que trabajan desde la casa

```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE Puesto_Empleado()
BEGIN
SET @cantidadPuestos = (SELECT COUNT(Nom_Puesto) FROM tb_puesto WHERE Nom_Puesto LIKE "Casa Empleado");
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_puesto);
SET @porcentaje = (@cantidadPuestos/@cantidadTotal) * 100;  
SELECT @cantidadTotal as "Total","Empleados que trabajan desde la casa " as "empleado",@porcentaje AS "Porcentaje",@cantidadPuestos as "total";
END //
DELIMITER ;
```

#### Procedimiento tabla Material, Cantidad de productos que se le asignaron materiales

```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE Cantidad_Material_con_Productos()
BEGIN 
SET @cantidadMaterial = (SELECT COUNT(tb_material.Id_Material) FROM tb_material INNER JOIN tb_producto WHERE tb_material.Id_Material =tb_producto.Id_Material_fk);
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_material);
SET @porcentaje = @cantidadMaterial/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Productos Con Material Asignado" as "Productos",@porcentaje AS "Porcentaje",@cantidadMaterial as "Subtotal";
END //
DELIMITER ;
```

#### Procedimiento tabla Productos , Cantidad de Pares del producto mayores o igual  a 50

```sql
DELIMITER $$
CREATE OR REPLACE PROCEDURE Pares_Mayores()
BEGIN 
SET @cantidadPares = (SELECT COUNT(tb_producto.Id_Producto) FROM tb_producto WHERE tb_producto.Pares_Producto >=50);
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_producto);
SET @porcentaje = @cantidadPares/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Pares mayores o iguales a 50 " as "Pares",@porcentaje AS "Porcentaje",@cantidadPares"Subtotal";
END$$
```

#### (Correccion)Procedimiento tabla Tareas ,Cantidad tareas con Armado

```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE Tareas_Armar()
BEGIN
SET @cantidadArmado = (SELECT COUNT(Id_Tarea) FROM tb_tareas WHERE Nom_Tarea = "Armado");
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_tareas); 
SET @porcentaje = @cantidadArmado/@cantidadTotal * 100;                    
SELECT @cantidadTotal as 'Total','Tareas Armado'as "Tarea de Armado",@porcentaje AS 'porcentaje',@cantidadArmado as 'Tareas con Armado';
END //
DELIMITER ;
```

#### Procedimiento tabla Tareas-Productos , Cantidad de tareas con inicio después del 1 de noviembre del 2022

```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE Tarea_Producto_Fecha()
BEGIN 
SET @cantidadTareas = (SELECT COUNT(tb_tarea_productos.Id_Tarea_Produc) FROM tb_tarea_productos WHERE tb_tarea_productos.Fecha_Inicio_Tarea >= '2022-11-01');
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_tarea_productos);
SET @porcentaje = @cantidadTareas/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Tareas iniciadas despues del 1 de noviembre" as "Tareas-Productos",@porcentaje AS "Porcentaje",@cantidadTareas as "Subtotal";
END //
DELIMITER ;
```

#### Procedimiento tabla Material Entregado , Cantidad y Promedio de materiales entregados

```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE Cantidad_Material_Entregado()
BEGIN 
SET @cantidadMaterial = (SELECT COUNT(tb_material_entregado.Id_Mat_Entregado) FROM tb_material_entregado INNER JOIN tb_material WHERE tb_material.Id_Material =tb_material_entregado.Id_Material_fk);
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_material);
SET @porcentaje = @cantidadMaterial/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Material Entregado" as "Material Entregado",@porcentaje AS "Porcentaje",@cantidadMaterial as "total";
END //
DELIMITER ;
```

#### Procedimiento tabla Material Faltante , Cantidad de material faltante mayor a  10

```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE Cantidad_Material_Faltante()
BEGIN 
SET @cantidadMaterial = (SELECT COUNT(tb_material_faltante.Id_Material_Faltante) FROM tb_material_faltante WHERE  tb_material_faltante.Cant_Faltante>=10);
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_material_faltante);
SET @porcentaje = @cantidadMaterial/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Material Faltante" as "Material Faltante",@porcentaje AS "Porcentaje",@cantidadMaterial as "total";
END //
DELIMITER ;
```

#### Procedimiento tabla Material Devoluciones , Cantidad materiales con ninguna observación

```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE Material_Devuelto()
BEGIN 
SET @cantidadMaterial = (SELECT COUNT(tb_material_devoluciones.Id_Material_Devuelto) FROM tb_material_devoluciones WHERE  tb_material_devoluciones.Observaciones="Ninguna");
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_material_devoluciones);
SET @porcentaje = @cantidadMaterial/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Material Devuelto con ninguna observacion" as "Material Devuelto",@porcentaje AS "Porcentaje",@cantidadMaterial as "total";
END //
DELIMITER ;
```
#### Listar Teléfono Empleados

```sql
SELECT Ced_Empleado AS "@CEDULA" , Nom_Empleado AS "@NOMBRE", Apell_Empleado AS "@ALIAS",  CONCAT(tb_empleado.Ced_Empleado," ",tb_telef_empleado.Num_Telef) AS "@Telefono_fk" FROM tb_empleado INNER JOIN tb_telef_empleado ON tb_empleado.Ced_Empleado = tb_telef_empleado.Ced_Empleado_fk;
```

#### Procedimiento Listar material Entregado

```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE ListarMaterialEntregado()
BEGIN
	SELECT Id_Mat_Entregado, Cant_Material_Entregado,Fech_Entrega_Material AS "Fecha",Hora_Entrega AS "Hora", CONCAT (tb_material_entregado.Id_Material_fk," ",tb_material.Nom_Material)AS "Material_fk" FROM tb_material_entregado INNER JOIN tb_material ON tb_material_entregado.Id_Material_fk=tb_material.Id_Material;
`DELIMITER ;
```

#### Procedimiento Listar material Faltante

```sql
DELIMITER $$
CREATE OR REPLACE PROCEDURE ListarMaterialFaltante()
BEGIN
SELECT Id_Material_Faltante, Cant_Faltante,Observaciones, CONCAT (tb_material_faltante.Id_Material_fk," ",tb_material.Nom_Material) FROM tb_material_faltante INNER JOIN tb_material ON tb_material_faltante.Id_Material_fk=tb_material.Id_Material;
END$$
DELIMITER ;
```

#### Procedimiento Listar material Devuelto

```sql
DELIMITER $$
CREATE OR REPLACE PROCEDURE ListarMaterialDevuelto()
BEGIN 
SELECT Id_Material_Devuelto, Cant_Material_Devuelto,Observaciones, CONCAT (tb_material_devoluciones.Id_Material_fk," ",tb_material.Nom_Material) FROM tb_material_devoluciones INNER JOIN tb_material ON tb_material_devoluciones.Id_Material_fk=tb_material.Id_Material;
END$$
DELIMITER ;
```