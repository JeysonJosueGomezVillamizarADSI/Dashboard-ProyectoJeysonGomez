<?php
    interface Material_Productos {
        public function material_producto();
        public function materialgetALL();
        public function UpdateMaterial(object $data);
    }
    class ProductoMaterial implements Material_Productos{
        static $producto;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$producto instanceof self) {
                self::$producto = new ProductoMaterial();
            }
            return self::$producto;
        }
        public function material_producto() {
            $sql = "call Cantidad_Material_con_Productos();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }

        public function materialgetALL() {
            $sql = "SELECT `Id_Material`, `Nom_Material`, `Desc_Material`, `Prec_Material`,`Cant_Material` FROM `tb_material`;";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }

        public function UpdateMaterial(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE `tb_material` SET `Nom_Material` =:material, `Desc_Material`=:descrip ,`Prec_Material`=:precio,`Cant_Material`=:cantidad WHERE `Id_Material`=:id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
    }
?>