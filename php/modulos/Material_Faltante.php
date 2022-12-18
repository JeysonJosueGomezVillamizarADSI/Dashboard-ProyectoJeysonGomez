<?php
    interface Material_Faltante{
        public function promedio_faltante();
        public function ListarMaterialFaltante();
        public function updateMatFaltan(object $data);
        public function deleteMatFaltan(object $data);
    }
    class Faltante implements Material_Faltante {
        static $material;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$material instanceof self) {
                self::$material = new Faltante();
            }
            return self::$material;
        }
        public function promedio_faltante() {
            $sql = "call Cantidad_Material_Faltante();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function ListarMaterialFaltante(){
            $sql = 'CALL `ListarMaterialFaltante`();';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function updateMatFaltan(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE `tb_material_faltante` SET `Cant_Faltante`=:cant,`Observaciones`=:obser WHERE `Id_Material_Faltante`=:Id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
        public function deleteMatFaltan(object $data){
            $json = (array) $data;
            $sql = 'DELETE FROM `tb_material_faltante` WHERE Id_Material_Faltante=:Id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos eliminados" => $data->rowCount()];
            return $mensaje;
        }
    }
?>