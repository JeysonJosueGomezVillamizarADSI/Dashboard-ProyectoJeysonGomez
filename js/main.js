const ws = new Worker("./ws.js");
addEventListener("DOMContentLoaded", (e) => {

    let myLogin = document.querySelector("#myLogin");
    let myHeader = new Headers();

    myLogin.addEventListener("submit", async(e) => {
        e.preventDefault();
        myHeader.set("accept", "login");
        let data = Object.fromEntries(new FormData(e.target));
        let config =  {
            headers: myHeader,
            method: myLogin.method,
            body: JSON.stringify(data)
        };
        let peticion = await fetch(myLogin.action, config);
        let res = await peticion.json();
        if(typeof res == "object"){
            sessionStorage.setItem("login", JSON.stringify(res));
            location.href = "view/home.html";
          
        }
        
    })
















    ws.postMessage({file:"sistema", nombre: "index"});
    ws.addEventListener("message", (e) => {
        let data = e.data;
        document.querySelector(".left-panel .content h3").innerHTML = data[0];
        document.querySelector(".left-panel .content p").innerHTML = data[1];
        document.querySelector(".left-panel .content button").innerHTML = data[2];
        document.querySelector(".title").innerHTML = data[3];
        document.querySelector('[name="usuario"]').placeholder = data[4];
        document.querySelector('[name="contrasena"]').placeholder = data[5];
        document.querySelector('[type="submit"]').value = data[6];
        document.querySelector('.social-text').innerHTML = data[7];
        document.querySelector(".right-panel .content h3").innerHTML = data[8];
        document.querySelector(".right-panel .content p").innerHTML = data[9];
        document.querySelector(".right-panel .content button").innerHTML = data[10];
        document.querySelector(".sign-up-form").innerHTML = data[11];
        
    })
    const sign_up_btn = document.querySelector("#sign-up-btn");
    const sign_in_btn = document.querySelector("#sign-in-btn");
    const container = document.querySelector(".container");
    sign_up_btn.addEventListener("click", (e)=>{
        container.classList.add("sign-up-mode");
    })
    sign_in_btn.addEventListener("click", (e)=>{
        container.classList.remove("sign-up-mode");
    })

})