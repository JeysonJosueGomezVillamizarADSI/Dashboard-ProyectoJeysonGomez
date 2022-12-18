
const file={
    sistema: async(url)=>{
        let file = await fetch("json/sistema.json");
        let json = await file.json();
        return json[url];
    },
    vistas: async(url)=>{
        let fileHTML = await fetch(`view/${url}.html`);
        let html = await fileHTML.text();
        let fileJavaScript = await fetch(`js/${url}.js`);
        let js = await fileJavaScript.text();
        return {html: html, js: js};
    },
}
addEventListener("message", async(e)=>{
    postMessage(await file[`${e.data.file}`](e.data.nombre));
})
