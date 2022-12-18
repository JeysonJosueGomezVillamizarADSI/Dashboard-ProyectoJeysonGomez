<?php
    interface Empleados_Activos{
        public function empleados_activos();
        public function ListarEmpleados();
        public function UpdateEmpleado(object $data);
    }
    class Activos implements Empleados_Activos {
        static $empleados;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$empleados instanceof self) {
                self::$empleados = new Activos();
            }
            return self::$empleados;
        }
        public function empleados_activos() {
            $sql = "call Empleados_Activos();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function ListarEmpleados() {
            $sql = 'SELECT `Ced_Empleado`, `Nom_Empleado`, `Apell_Empleado`, `Direcc_Empleado`, `Estado_Empleado` FROM `tb_empleado`';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function UpdateEmpleado(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE `tb_empleado` SET Nom_Empleado =:nom, `Apell_Empleado`=:apell ,`Direcc_Empleado`=:Direcc,`Estado_Empleado`=:Estado WHERE `Ced_Empleado`=:ced;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
    }
?>