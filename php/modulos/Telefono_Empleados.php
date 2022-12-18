<?php
    interface Telef_Empleado {
        public function promedio_telefonos();
        public function ListarTelefonos();
        public function UpdateTelefono(object $data);
        public function TelefonoDelete(object $data);
    }
    class Telefono implements Telef_Empleado {
        static $telefono;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$telefono instanceof self) {
                self::$telefono = new Telefono();
            }
            return self::$telefono;
        }
        public function promedio_telefonos() {
            $sql = "call Telefonos_Empleados();";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetch(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function ListarTelefonos() {
            $sql = 'SELECT `Id_Telef` AS"id", `Num_Telef` AS "Telefono", CONCAT(tb_telef_empleado.Ced_Empleado_fk, " ",tb_empleado.Nom_Empleado)AS "@Cedula_fk" FROM tb_empleado INNER join tb_telef_empleado on tb_telef_empleado.Ced_Empleado_fk = tb_empleado.Ced_Empleado;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function UpdateTelefono(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE tb_telef_empleado SET Num_Telef =:telefono WHERE Id_Telef=:id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
        public function TelefonoDelete(object $data){
            $json = (array) $data;
            $sql = "call eliminarTelefono(:id);";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["@Mensaje" => $data->rowCount()];
            return $mensaje;
        }  
        
    }
?>