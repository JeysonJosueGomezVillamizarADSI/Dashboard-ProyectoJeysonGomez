const ws = new Worker("../ws.js");
const view = new Worker("../ws.js");
addEventListener("DOMContentLoaded", async (e) => {
    if(!sessionStorage.getItem("login")){
        location.href = "../";
    }else{
        let data = JSON.parse(sessionStorage.getItem("login"));
        document.querySelector(".profile-link li:first-child a").insertAdjacentText("beforeend", data.usuario);
    }
    document.querySelector(".profile-link li:last-child").addEventListener("click", (e)=>{
        sessionStorage.removeItem("login");
        location.reload();
    })


    ws.postMessage({ file: "sistema", nombre: "home" });
    ws.addEventListener("message", (e) => {
        let data = e.data, plantilla = "";
        localStorage.setItem("menu", JSON.stringify(data));
        document.querySelector(".brand").innerHTML = `<ion-icon name="${data.titulo.icono}" class="icon"></ion-icon>${data.titulo.nombre}`;
        document.querySelector(".side-menu li:nth-child(1)").innerHTML = `<a href="#${data.titulo.view}" data-miga="${data.titulo.nombre},${data.subtitulo.nombre}" class="active"><ion-icon name="${data.subtitulo.icono}" class="icon"></ion-icon>${data.subtitulo.nombre}</a>`;
        for (let [titulo, menu] of Object.entries(e.data.menu)) {
            plantilla += `
                <li class="divider" data-text="main">${titulo}</li>
            `;
            menu.forEach((menus) => {
                if (menus.submenu) {
                    plantilla += `
                    <li>
                        <a href="#"><ion-icon name="${menus.icono}" class="icon"></ion-icon> ${menus.nombre} <ion-icon name="chevron-forward" class="icon-right"></ion-icon></a>
                        <ul class="side-dropdown">
                            ${menus.submenu.map(res => `<li><a href="#${res.view}" data-miga="${titulo},${menus.nombre},${res.nombre}">${res.nombre}</a></li>`).join("")}
                        </ul>
                    </li>
                    `;
                } else {
                    plantilla += `
                        <li><a href="#${menus.view}" data-miga="${titulo},${menus.nombre}"><ion-icon name="${menus.icono}" class="icon"></ion-icon>${menus.nombre}</a></li>
                    `;
                }
            });

        }
        document.querySelector(".side-menu").insertAdjacentHTML("beforeend", plantilla);
        // SIDEBAR DROPDOWN
        const allDropdown = document.querySelectorAll('#sidebar .side-dropdown');
        allDropdown.forEach(item => {
            const a = item.parentElement.querySelector('a:first-child');
            a.addEventListener('click', function (e) {
                e.preventDefault();

                if (!this.classList.contains('active')) {
                    allDropdown.forEach(i => {
                        const aLink = i.parentElement.querySelector('a:first-child');

                        aLink.classList.remove('active');
                        i.classList.remove('show');
                    })
                }

                this.classList.toggle('active');
                item.classList.toggle('show');
            })
        })
    })
    addEventListener("hashchange", (e) => {
        let url = ("" + window.location).split('#');
        if (url[1]) {
            view.postMessage({ file: "vistas", nombre: url[1] });
        }
    })
    view.addEventListener("message", (e) => {
        let script = document.createElement("SCRIPT");
        script.innerHTML = e.data.js;
        document.querySelector("main").innerHTML = "";
        document.querySelector("main").insertAdjacentHTML("beforeend", e.data.html);
        document.querySelector("main").insertAdjacentElement("beforeend", script);
    })























    const sidebar = document.querySelector('#sidebar');
    // SIDEBAR COLLAPSE
    const toggleSidebar = document.querySelector('nav .toggle-sidebar');
    const allSideDivider = document.querySelectorAll('#sidebar .divider');
    // PROFILE DROPDOWN
    const profile = document.querySelector('nav .profile');
    const imgProfile = profile.querySelector('img');
    const dropdownProfile = profile.querySelector('.profile-link');
    // MENU
    const allMenu = document.querySelectorAll('main .content-data .head .menu');


    // SIDEBAR COLLAPSE
    if (sidebar.classList.contains('hide')) {
        allSideDivider.forEach(item => {
            item.textContent = '-'
        })
        allDropdown.forEach(item => {
            const a = item.parentElement.querySelector('a:first-child');
            a.classList.remove('active');
            item.classList.remove('show');
        })
    } else {
        allSideDivider.forEach(item => {
            item.textContent = item.dataset.text;
        })
    }
    toggleSidebar.addEventListener('click', function () {
        sidebar.classList.toggle('hide');
        
        if (sidebar.classList.contains('hide')) {
            allSideDivider.forEach(item => {
                item.textContent = '-'
            })

            allDropdown.forEach(item => {
                const a = item.parentElement.querySelector('a:first-child');
                a.classList.remove('active');
                item.classList.remove('show');
            })
        } else {
            allSideDivider.forEach(item => {
                item.textContent = item.dataset.text;
            })
        }
    })
    sidebar.addEventListener('mouseleave', function () {
        if (this.classList.contains('hide')) {
            allDropdown.forEach(item => {
                const a = item.parentElement.querySelector('a:first-child');
                a.classList.remove('active');
                item.classList.remove('show');
            })
            allSideDivider.forEach(item => {
                item.textContent = '-'
            })
        }
    })
    sidebar.addEventListener('mouseenter', function () {
        if (this.classList.contains('hide')) {
            allDropdown.forEach(item => {
                const a = item.parentElement.querySelector('a:first-child');
                a.classList.remove('active');
                item.classList.remove('show');
            })
            allSideDivider.forEach(item => {
                item.textContent = item.dataset.text;
            })
        }
    })
    // PROFILE DROPDOWN
    imgProfile.addEventListener('click', function () {
        dropdownProfile.classList.toggle('show');
    })
    // MENU
    allMenu.forEach(item => {
        const icon = item.querySelector('.icon');
        const menuLink = item.querySelector('.menu-link');

        icon.addEventListener('click', function () {
            
            menuLink.classList.toggle('show');
        })
    })
    addEventListener('click', function (e) {
        localStorage.setItem("miga", e.target.dataset.miga);
        if (e.target !== imgProfile) {
            if (e.target !== dropdownProfile) {
                
                if (dropdownProfile.classList.contains('show')) {
                    dropdownProfile.classList.remove('show');
                }
            }
        }
        
        allMenu.forEach(item => {
            
            const icon = item.querySelector('.icon');
            const menuLink = item.querySelector('.menu-link');

            if (e.target !== icon) {
                if (e.target !== menuLink) {
                    if (menuLink.classList.contains('show')) {
                        menuLink.classList.remove('show')
                    }
                }
            }
        })
    })



})