// PROGRESSBAR
var allProgress = document.querySelectorAll('main .card .progress');
// PROGRESSBAR
allProgress.forEach(item => {
    item.style.setProperty('--value', item.dataset.value)
})
var miga = localStorage.getItem("miga").split(',');
document.querySelector(".title").innerHTML = miga[0];
document.querySelector(".breadcrumbs li:nth-child(1) a").innerHTML = miga[0];
document.querySelector(".breadcrumbs li:nth-child(3) a").innerHTML = miga[1];

var sesion = JSON.parse(sessionStorage.getItem("login"));


//Procedimientos de las tablas
var materialentregado = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "promedio_entregado");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["total"]}</sup></small></h2>
                <p>${res["Material Entregado"]}</p>
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

var materialfaltante = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "promedio_faltante");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["total"]}</sup></small></h2>
                <p>${res["Material Faltante"]}</p>
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

var empleadosactivos = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "empleados_activos");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["Total empleados activos"]}</sup></small></h2>
                <p>${res["Empleados Activos"]}</p>
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

var productosMaterial = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "material_producto");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["Subtotal"]}</sup></small></h2>
                <p>${res["Productos"]}</p>
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

var materialDevuelto = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "promedio_devuelto");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["total"]}</sup></small></h2>
                <p>${res["Material Devuelto"]}</p>
            </div>  
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

var Cantidadpares = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "promedio_pares");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["Subtotal"]}</sup></small></h2>
                <p>${res["Pares"]}
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}
var empleados = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "promedio_empleado");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["total"]}</sup></small></h2>
                <p>${res["empleado"]}
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

var empleadosRol = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "promedio_rol");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["total"]}</sup></small></h2>
                <p>${res["empleado"]}
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

var empleadosSalario = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "promedio_salario");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["Subtotal"]}</sup></small></h2>
                <p>${res["Salarios"]}
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

var Productos = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "promedio_producto");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["Subtotal"]}</sup></small></h2>
                <p>${res["Tareas-Productos"]}
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

var Tareas = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "promedio_tarea");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["Tareas con Armado"]}</sup></small></h2>
                <p>${res["Tarea de Armado"]}
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`porcentaje`])}%" style="--value:${Math.round(res[`porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

var Telefonos = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "promedio_telefonos");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    if (res["Total"] > 0) {
        var plantilla =
            `<div class="card">
        <div class="head">
            <div>
                <h2>${res["Total"]}<small>/<sup>${res["Telefonos Empleados"]}</sup></small></h2>
                <p>${res["Telefonos"]}
            </div> 
            <ion-icon name="trending-up" class="icon"></ion-icon>
        </div>
        <span class="progress" data-value="${Math.round(res[`Porcentaje`])}%" style="--value:${Math.round(res[`Porcentaje`])}%;"></span>
        <span class="label">${Math.round(res[`Porcentaje`])}%</span>
    </div>
    `;
    }
    document.querySelector(".info-data").insertAdjacentHTML("beforeend", plantilla);
}

empleadosactivos();
productosMaterial();
materialentregado();
materialfaltante();
materialDevuelto();
Cantidadpares();
empleados();
empleadosRol();
empleadosSalario();
Productos();
Tareas();
Telefonos();