window.onload = function () {
    // Check query parameters
    // If there is a msg parameter, show it
    msgs = [
        "Un fichier identique dont vous êtes l'auteur existe déjà."
    ]
    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('msg')) {
        alert(msgs[parseInt(urlParams.get('msg'), 10)]);
    }
}

function bindFileName(ev, id) {
    document.getElementById(id).value = ev.target.value.replace(/.*[\/\\]/, '');
}