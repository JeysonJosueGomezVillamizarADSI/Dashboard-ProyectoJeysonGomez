<?php

class Conexion{
    protected $usuario ="root";
    protected $contrasena ="";
    protected $nombreBaseDeDatos ="sistema_invza";
    static $conexion;
    public function __construct(){}
    static function getIns():object{
        if(!self::$conexion instanceof self){
            self::$conexion = new Conexion();
        }
        return self::$conexion;
    }
    public function db(){
        $con=null;
        try {
            $con= new PDO("mysql:host=localhost;dbname=".$this->nombreBaseDeDatos,
            $this->usuario,$this->contrasena);
        } catch (PDOException $e) {
            $con=$e->getMessage();
        }
        return $con;
    }
}

?>