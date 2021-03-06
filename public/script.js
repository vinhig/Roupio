window.onload = function () {
    // Check query parameters
    // If there is a msg parameter, show it
    msgs = [
        "Un fichier identique dont vous êtes l'auteur existe déjà.",
        "Ce fichier est inaccessible.",
        "Une ressource identique a déjà été partagée."
    ]
    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('msg')) {
        // Show sent message
        alert(msgs[parseInt(urlParams.get('msg'), 10)]);
    }
}

function bindFileName(ev, id) {
    // When the user choose a file
    // we have to store the original name of it
    document.getElementById(id).value = ev.target.value.replace(/.*[\/\\]/, '');
}