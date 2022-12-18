<?php
    interface Puesto_Empleado {
        public function promedio_empleado();
        public function ListarPuestos();
        public function UpdatePuesto(object $data);
    }
    class Empleados implements Puesto_Empleado {
        static $empleados;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$empleados instanceof self) {
                self::$empleados = new Empleados();
            }
            return self::$empleados;
        }
        public function promedio_empleado() {
            $sql = "call Puesto_Empleado();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function ListarPuestos() {
            $sql = "SELECT `Id_Puesto`, `Nom_Puesto`, `Direcc_Puesto` FROM `tb_puesto`;";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function UpdatePuesto(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE `tb_puesto` SET `Nom_Puesto` =:puesto, `Direcc_Puesto`=:direcc  WHERE `Id_Puesto`=:id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
    }
?>