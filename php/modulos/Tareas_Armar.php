<?php
    interface Tarea_Armar {
        public function promedio_tarea();
        public function ListarTareas();
        public function UpdateTareas(object $data);
    }
    class Tarea implements Tarea_Armar {
        static $tareasArmar;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$tareasArmar instanceof self) {
                self::$tareasArmar = new Tarea();
            }
            return self::$tareasArmar;
        }
        public function promedio_tarea() {
            $sql = "call Tareas_Armar();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function ListarTareas() {
            $sql = "SELECT `Id_Tarea`, `Nom_Tarea`, `Cant_Pares_Tarea`, `Desc_Tarea` FROM `tb_tareas`;";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }

        public function UpdateTareas(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE `tb_tareas` SET `Nom_Tarea` =:tarea, `Cant_Pares_Tarea`=:cant ,`Desc_Tarea`=:descrip WHERE `Id_Tarea`=:id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
    }
?>