var miga = localStorage.getItem("miga").split(',');
document.querySelector(".title").innerHTML = miga[0];
document.querySelector(".breadcrumbs li:nth-child(1) a").innerHTML = miga[1];
document.querySelector(".breadcrumbs li:nth-child(3) a").innerHTML = miga[2];


var tablaSinFK = async (data) => {
    return new Promise((resolve) => {
        var frag = new DocumentFragment();
        for (let [id, fila] of Object.entries(data)) {
            var tr = document.createElement("TR");
            tr.setAttribute("data-id", id);
            var editar = document.createElement("ION-ICON");
            editar.name = "cloud-upload";
            editar.classList.add("edit");
            editar.setAttribute("data-btn", id);
            var tdU = document.createElement("TD");
            tdU.append(editar);
            for (let [columna, value] of Object.entries(fila)) {
                var td = document.createElement("TD");
                tdU.setAttribute("style", "text-align: center;");
                if (columna != "Ced_Empleado") {
                    console.log(columna);
                    td.setAttribute("contenteditable", "");
                }
                td.innerHTML = value;
                tr.append(td);
            }
            tr.append(tdU);
            frag.append(tr);
        }
        resolve(frag);
    })
}



var empleado = async () => {
    let myHeader = new Headers();
    let config = {
        headers: myHeader,
        method: "POST"
    };
    myHeader.set("accept", "ListarEmpleados");
    let peticion = await fetch("../php/api.php", config);
    let res = await peticion.json();
    let plantilla = await tablaSinFK(res);
    document.querySelector("tbody").append(plantilla);
}
empleado();


document.querySelector("tbody").addEventListener("click", async (e) => {
    if (!e.target.classList.value.indexOf("edit")) {
        let input = document.querySelector(`tbody tr[data-id="${e.target.dataset.btn}"]`);
        let json = {
            ced: input.children[0].innerHTML,
            nom: input.children[1].innerHTML,
            apell: input.children[2].innerHTML,
            Direcc: input.children[3].innerHTML,
            Estado: input.children[4].innerHTML,
        }
        let myHeader = new Headers();
        let config = {
            headers: myHeader,
            method: "POST",
            body: JSON.stringify(json)
        };
        myHeader.set("accept", "UpdateEmpleado");
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

        // document.querySelector("pre").innerHTML = res;
    }

})