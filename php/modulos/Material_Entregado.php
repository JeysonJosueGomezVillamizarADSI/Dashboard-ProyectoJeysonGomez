<?php
    interface Material_Entregado {
        public function promedio_entregado();
        public function ListarMaterialEntregado();
        public function updateMatEntreg(object $data);
        public function deleteMatEntreg(object $data);
    }
    class Entregado implements Material_Entregado {
        static $material;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$material instanceof self) {
                self::$material = new Entregado();
            }
            return self::$material;
        }
        public function promedio_entregado() {
            $sql = "call Cantidad_Material_Entregado();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function ListarMaterialEntregado(){
            $sql = 'CALL `ListarMaterialEntregado`();';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function updateMatEntreg(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE `tb_material_entregado` SET `Cant_Material_Entregado`=:Cantidad ,`Fech_Entrega_Material`=:Fecha,`Hora_Entrega`=:Hora WHERE `Id_Mat_Entregado`=:Id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
        public function deleteMatEntreg(object $data){
            $json = (array) $data;
            $sql = 'DELETE FROM `tb_material_entregado` WHERE Id_Mat_Entregado=:Id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos eliminados" => $data->rowCount()];
            return $mensaje;
        }
    }
?>