<?php
    interface Cantidad_Pares {
        public function promedio_pares();
    }
    class ParesMayores implements Cantidad_Pares {
        static $pares;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$pares instanceof self) {
                self::$pares = new ParesMayores();
            }
            return self::$pares;
        }
        public function promedio_pares() {
            $sql = "call Pares_Mayores();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
    }
?>