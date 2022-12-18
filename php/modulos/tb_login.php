<?php

    interface tb_login{
        public function loginAdmin(object $data);
        public function ListarAdmin();
        public function UpdateLogin(object $data);
    }

    class Usuario implements tb_login{
        static $usuario;
        public function __construct(){}
        static function getIns():object{
        if(!self::$usuario instanceof self){
            self::$usuario = new Usuario();
        }
        return self::$usuario;
    }
    public function loginAdmin(object $data){
        $json =  (array) $data;
        $sql = "call login(:usuario,:contrasena);";
        $data = Conexion::getIns()->db()->prepare($sql);
        $data->execute($json);
        $mensaje = $data->fetch(PDO::FETCH_ASSOC);
        return $mensaje;
        }
        public function ListarAdmin() {
            $sql = "SELECT `id`, `admin`, `contrasena` FROM `tb_login`;";
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }
        public function UpdateLogin(object $data) {
            $json = (array) $data;
            $sql = 'UPDATE `tb_login` SET `admin` =:adminis, `contrasena`=:contra  WHERE `id`=:Id;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute($json);
            $mensaje = (array) ["Datos actualizados" => $data->rowCount()];
            return $mensaje;
        }
    }

?>