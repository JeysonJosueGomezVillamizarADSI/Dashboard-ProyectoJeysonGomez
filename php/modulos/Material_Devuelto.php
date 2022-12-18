<?php
    interface Material_Devuelto {
        public function promedio_devuelto();
        public function ListarMaterialDevuelto();
    }
    class Devoluciones implements Material_Devuelto {
        static $material;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$material instanceof self) {
                self::$material = new Devoluciones();
            }
            return self::$material;
        }
        public function promedio_devuelto() {
            $sql = "call Material_Devuelto();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function ListarMaterialDevuelto(){
            $sql = 'CALL `ListarMaterialDevuelto`();';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function updateMatDevuelt(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE `tb_material_devoluciones` SET `Cant_Material_Devuelto`=:cant ,`Observaciones`=:obser WHERE `Id_Material_Devuelto`=:Id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
        public function deleteMatDevuelt(object $data){
            $json = (array) $data;
            $sql = 'DELETE FROM `tb_material_devoluciones` WHERE Id_Material_Devuelto=:Id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos eliminados" => $data->rowCount()];
            return $mensaje;
        }
    }
?>