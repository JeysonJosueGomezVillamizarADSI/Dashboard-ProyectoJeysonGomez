var miga = localStorage.getItem("miga").split(',');
document.querySelector(".title").innerHTML = miga[0];
document.querySelector(".breadcrumbs li:nth-child(1) a").innerHTML = miga[1];
document.querySelector(".breadcrumbs li:nth-child(3) a").innerHTML = miga[2];

var URI = {
    url: "../php/api.php",
    method: "POST"
}

var tablaConFK = async (data) => {
    return new Promise((resolve) => {
        var frag = new DocumentFragment();
        for (let [id, fila] of Object.entries(data)) {
            var tr = document.createElement("TR");
            tr.setAttribute("data-id", id);
            var editar = document.createElement("ION-ICON");
            editar.name = "cloud-upload";
            editar.classList.add("edit");
            editar.setAttribute("data-btn", id);
            var eliminar = document.createElement("ION-ICON");
            eliminar.name = "trash";
            eliminar.classList.add("delete");
            eliminar.setAttribute("data-btn", id);
            var tdU = document.createElement("TD");
            tdU.setAttribute("style", "text-align: center;");
            tdU.append(editar);
            var tdD = document.createElement("TD");
            tdD.setAttribute("style", "text-align: center;");
            tdD.append(eliminar);
            for (let [name, columna] of Object.entries(fila)) {
                var td = document.createElement("TD");
                td.setAttribute("contenteditable", "");
                if (name.replace(/\s+/g, '').substring(name.length - 2).toUpperCase() == "FK") {
                    var fk = columna.split(" ");
                    var div = document.createElement("DIV");
                    div.classList.add("select");
                    var select = document.createElement("SELECT");
                    var option = document.createElement("OPTION");
                    option.value = fk[0];
                    option.innerHTML = fk[1];
                    select.append(option);
                    var div2 = document.createElement("DIV");
                    div2.classList.add("select_arrow");
                    var icono = document.createElement("ION-ICON");
                    icono.name = "chevron-down";
                    div2.append(icono);
                    div.append(select, div2);
                    td.append(div);
                } else {
                    td.innerHTML = columna;
                }
                tr.append(td);

            }
            tr.append(tdU);
            tr.append(tdD);
            frag.append(tr);
        }
        resolve(frag);
    })
}

var MatFaltante= async () => {
    let myHeader = new Headers();
    myHeader.set("accept", "ListarMaterialFaltante");
    let config = {
        headers: myHeader,
        method: URI.method
    };
    let peticion = await fetch(URI.url, config);
    let res = await peticion.json();
    let plantilla = await tablaConFK(res);
   // console.log(plantilla);
   document.querySelector("tbody").append(plantilla);
}
MatFaltante();

document.querySelector("tbody").addEventListener("click", async (e) => {
    if (!e.target.classList.value.indexOf("edit")) {
        let input = document.querySelector(`tbody tr[data-id="${e.target.dataset.btn}"]`);
        let json = {
            Id: input.children[0].innerHTML,
            cant: input.children[1].innerHTML,
            obser: input.children[2].innerHTML,
        }
        let myHeader = new Headers();
        let config = {
            headers: myHeader,
            method: "POST",
            body: JSON.stringify(json)
        };
        myHeader.set("accept", "updateMatFaltan");
        let peticion = await fetch("../php/api.php", config);
        let res = await peticion.json();
        if (res["Datos actualizados"]) {
            Swal.fire({
                position: 'center',
                icon: 'success',
                title: 'Datos actualizados',
                showConfirmButton: false,
                timer: 1500
            })
        }
    }else if (!e.target.classList.value.indexOf("delete")) {
        let input = document.querySelector(`tbody tr[data-id="${e.target.dataset.btn}"]`);
        let json = {
            Id: input.children[0].innerHTML,
        }
        let myHeader = new Headers();
        myHeader.set("accept", "deleteMatFaltan");
        let config = {
            headers: myHeader,
            method: "POST",
            body: JSON.stringify(json)
        };
        let peticion = await fetch("../php/api.php", config);
        let res = await peticion.json();
        if (res["Datos eliminados"]) {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: `El Material Faltante  ha sido eliminado`,
                showConfirmButton: false,
                timer: 3000
            })
            input.remove();
        }
    }

})