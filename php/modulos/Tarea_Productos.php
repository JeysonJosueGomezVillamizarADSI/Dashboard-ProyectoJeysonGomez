<?php
    interface Tarea_Producto {
        public function promedio_producto();
        public function ListarProductos();
        public function UpdateProductos(object $data);
        public function ListarTareaProductos();
        public function updateTareaProd(object $data); 
    }
    class Productos implements Tarea_Producto {
        static $tareas;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$tareas instanceof self) {
                self::$tareas = new Productos();
            }
            return self::$tareas;
        }
        public function promedio_producto() {
            $sql = "call Tarea_Producto_Fecha();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function ListarProductos() {
            $sql = 'SELECT `Id_Producto`, `Nom_Producto`, `Pares_Producto`, `Desc_Producto`, `Talla`, `Color` FROM `tb_producto`;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function UpdateProductos(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE `tb_producto` SET `Nom_Producto`=:produc,`Pares_Producto`=:pares,`Desc_Producto`=:descrip,`Talla`=:talla,`Color`=:color WHERE `Id_Producto`=:id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
        public function ListarTareaProductos() {
            $sql = "CALL ListarTareaproducto();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }

        public function updateTareaProd(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE `tb_tarea_productos` SET `Fecha_Inicio_Tarea`=:inicio,`Fecha_Fin_Tarea`=:fin,`Cant`=:cant WHERE `Id_Tarea_Produc`=:id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
    }
?>