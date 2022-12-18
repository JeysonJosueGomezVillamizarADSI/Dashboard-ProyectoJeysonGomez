<?php
    interface Rol_Empleado {
        public function promedio_rol();
        public function ListarRoles();
        public function updateRol(object $data);
        public function deleteRol(object $data);
    }
    class Empleados_Rol implements Rol_Empleado {
        static $empleados;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$empleados instanceof self) {
                self::$empleados = new Empleados_Rol();
            }
            return self::$empleados;
        }
        public function promedio_rol() {
            $sql = "call Rol_Empleados();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function ListarRoles(){
            $sql = 'CALL `ListarRoles`();';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }

        public function updateRol(object $data){
            $json = (array) $data;
            $sql = 'UPDATE `tb_rol_emple` SET `Nomb_Rol`=:rol WHERE Id_Rol=:id_rol;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }

        public function deleteRol(object $data){
            $json = (array) $data;
            $sql = 'DELETE FROM `tb_rol_emple` WHERE Id_Rol=:id_rol;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos eliminados" => $data->rowCount()];
            return $mensaje;
        }

    }
?>