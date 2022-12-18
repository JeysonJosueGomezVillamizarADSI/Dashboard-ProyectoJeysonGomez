<?php
    header("Access-Control-Allow-Origin: *");
    header('Content-Type: application/json; charset=utf-8');
    $_DATA = json_decode(file_get_contents("php://input"));
    

    include_once "conexion/conexion.php";
    class Api{
        static $api;
        public function __construct(){}
        static function getIns(){
            if(!self::$api instanceof self){
                return self::$api = new Api();
            }
            return self::$api;
        }
        public function login(object $obj) {
            include_once "modulos/tb_login.php";
            echo json_encode(Usuario::getIns()->loginAdmin($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }

        public function promedio_entregado() {
            include_once "modulos/Material_Entregado.php";
            echo json_encode(Entregado::getIns()->promedio_entregado(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function promedio_faltante() {
            include_once "modulos/Material_Faltante.php";
            echo json_encode(Faltante::getIns()->promedio_faltante(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function empleados_activos() {
            include_once "modulos/Empleados_Activos.php";
            echo json_encode(Activos::getIns()->empleados_activos(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function material_producto() {
            include_once "modulos/Material_Productos.php";
            echo json_encode(ProductoMaterial::getIns()->material_producto(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function promedio_devuelto() {
            include_once "modulos/Material_Devuelto.php";
            echo json_encode(Devoluciones::getIns()->promedio_devuelto(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function promedio_pares() {
            include_once "modulos/Cantidad_Pares.php";
            echo json_encode(ParesMayores::getIns()->promedio_pares(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function promedio_empleado() {
            include_once "modulos/Puesto_Empleado.php";
            echo json_encode(Empleados::getIns()->promedio_empleado(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function promedio_rol() {
            include_once "modulos/Rol_Empleados.php";
            echo json_encode(Empleados_Rol::getIns()->promedio_rol(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function promedio_salario() {
            include_once "modulos/Salario_Empleado.php";
            echo json_encode(Salario::getIns()->promedio_salario(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function promedio_producto() {
            include_once "modulos/Tarea_Productos.php";
            echo json_encode(Productos::getIns()->promedio_producto(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function promedio_tarea() {
            include_once "modulos/Tareas_Armar.php";
            echo json_encode(Tarea::getIns()->promedio_tarea(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function promedio_telefonos() {
            include_once "modulos/Telefono_Empleados.php";
            echo json_encode(Telefono::getIns()->promedio_telefonos(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function Listarempleados() {
            include_once "modulos/Empleados_Activos.php";
            echo json_encode(Activos::getIns()->ListarEmpleados(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }

        public function ListarTelefonos() {
            include_once "modulos/Telefono_Empleados.php";
            echo json_encode(Telefono::getIns()->ListarTelefonos(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function materialgetALL() {
            include_once "modulos/Material_Productos.php";
            echo json_encode(ProductoMaterial::getIns()->materialgetALL(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function ListarTareas() {
            include_once "modulos/Tareas_Armar.php";
            echo json_encode(Tarea::getIns()->ListarTareas(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function ListarRoles(){
            include_once "modulos/Rol_Empleados.php";
            echo json_encode(Empleados_Rol::getIns()->ListarRoles(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function ListarPuestos() {
            include_once "modulos/Puesto_Empleado.php";
            echo json_encode(Empleados::getIns()->ListarPuestos(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function UpdatePuesto($obj) {
            include_once "modulos/Puesto_Empleado.php";
            echo json_encode(Empleados::getIns()->UpdatePuesto($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function UpdateEmpleado($obj) {
            include_once "modulos/Empleados_Activos.php";
            echo json_encode(Activos::getIns()->UpdateEmpleado($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function UpdateMaterial($obj) {
            include_once "modulos/Material_Productos.php";
            echo json_encode(ProductoMaterial::getIns()->UpdateMaterial($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function UpdateTareas($obj) {
            include_once "modulos/Tareas_Armar.php";
            echo json_encode(Tarea::getIns()->UpdateTareas($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function ListarPuesto() {
            include_once "modulos/Puesto.php";
            echo json_encode(Empleado::getIns()->ListarPuesto(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function ListarProductos() {
            include_once "modulos/Tarea_Productos.php";
            echo json_encode(Productos::getIns()->ListarProductos(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function ListarMaterialEntregado(){
            include_once "modulos/Material_Entregado.php";
            echo json_encode(Entregado::getIns()->ListarMaterialEntregado(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function ListarMaterialFaltante(){
            include_once "modulos/Material_Faltante.php";
            echo json_encode(Faltante::getIns()->ListarMaterialFaltante(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function ListarMaterialDevuelto(){
            include_once "modulos/Material_Devuelto.php";
            echo json_encode(Devoluciones::getIns()->ListarMaterialDevuelto(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function ListarAdmin(){
            include_once "modulos/tb_login.php";
            echo json_encode(Usuario::getIns()->ListarAdmin(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function UpdateProductos($obj) {
            include_once "modulos/Tarea_Productos.php";
            echo json_encode(Productos::getIns()->UpdateProductos($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function ListarTareaProducto(){
            include_once "modulos/Tarea_Productos.php";
            echo json_encode(Productos::getIns()->ListarTareaProductos(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function UpdateTelefono($obj) {
            include_once "modulos/Telefono_Empleados.php";
            echo json_encode(Telefono::getIns()->UpdateTelefono($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        } 
        public function TelefonoDelete(object $obj){ 
            include_once "modulos/Telefono_Empleados.php";
            echo json_encode(Telefono::getIns()->TelefonoDelete($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }


        public function updateRol(object $obj){ 
            include_once "modulos/Rol_Empleados.php";
            echo json_encode(Empleados_Rol::getIns()->updateRol($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }

        public function deleteRol(object $obj){ 
            include_once "modulos/Rol_Empleados.php";
            echo json_encode(Empleados_Rol::getIns()->deleteRol($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }

        public function updateTareaProd(object $obj){ 
            include_once "modulos/Tarea_Productos.php";
            echo json_encode(Productos::getIns()->updateTareaProd($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        
        public function updateMatEntreg(object $obj){ 
            include_once "modulos/Material_Entregado.php";
            echo json_encode(Entregado::getIns()->updateMatEntreg($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function deleteMatEntreg(object $obj){ 
            include_once "modulos/Material_Entregado.php";
            echo json_encode(Entregado::getIns()->deleteMatEntreg($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function updateMatFaltan(object $obj){ 
            include_once "modulos/Material_Faltante.php";
            echo json_encode(Faltante::getIns()->updateMatFaltan($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function deleteMatFaltan(object $obj){ 
            include_once "modulos/Material_Faltante.php";
            echo json_encode(Faltante::getIns()->deleteMatFaltan($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function updateMatDevuelt(object $obj){ 
            include_once "modulos/Material_Devuelto.php";
            echo json_encode(Devoluciones::getIns()->updateMatDevuelt($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function deleteMatDevuelt(object $obj){ 
            include_once "modulos/Material_Devuelto.php";
            echo json_encode(Devoluciones::getIns()->deleteMatDevuelt($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        public function UpdateLogin($obj) {
            include_once "modulos/tb_login.php";
            echo json_encode(Usuario::getIns()->UpdateLogin($obj), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        }
        
    }  
    call_user_func_array([Api::getIns(), apache_request_headers()["accept"]], [$_DATA]);
?>