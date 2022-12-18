<?php
    interface Salario_Empleado {
        public function promedio_salario();
    }
    class Salario implements Salario_Empleado {
        static $empleados;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$empleados instanceof self) {
                self::$empleados = new Salario();
            }
            return self::$empleados;
        }
        public function promedio_salario() {
            $sql = "call Salario_Menor();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
    }
?>