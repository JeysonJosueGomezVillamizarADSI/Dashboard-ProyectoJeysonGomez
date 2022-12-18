<?php 
    interface Puesto{
        public function ListarPuesto();
        // public function UpdatePuesto(object $data);
    }
    class Empleado implements Puesto {
        static $empleado;
        public function __construct() {} 
        static function getIns():object {
            if (!self::$empleado instanceof self) {
                self::$empleado = new Empleado();
            }
            return self::$empleados;
        }
        public function ListarPuesto() {
            $sql = 'SELECT `Id_Puesto_Emple`, Nom_Empleado AS "Nombre",Apell_Empleado AS "Apellido", `Horario_Asignado` AS "Horario", `Salar_Empleado` AS "Salario" , CONCAT (tb_puesto_emple.Id_Puesto_fk," ",tb_puesto.Nom_Puesto)AS "Id_fk" FROM tb_puesto_emple INNER JOIN tb_puesto ON tb_puesto_emple.Id_Puesto_fk=tb_puesto.Id_Puesto INNER JOIN tb_empleado ON tb_empleado.Ced_Empleado=tb_puesto_emple.Ced_Empleado_fk;';
            $data = Conexion::getIns()->db()->prepare($sql);
            $data->execute();
            $mensaje = $data->fetchAll(PDO::FETCH_ASSOC);
            return $mensaje;
        }
    }
?>