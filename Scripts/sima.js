function setHourglass() {
    document.body.style.cursor = 'wait';
}

// Agrega css al head del documento.
const addCSS = css => document.head.appendChild(document.createElement("style")).innerHTML = css;

function ShowProgress() {
    //addCSS(".modal { position: absolute; top: 0; left: 0; background - color: black; z - index: 99; opacity: 0.8; filter: alpha(opacity = 80); -moz - opacity: 0.8; min - height: 100 %; width: 100 %; }");
    //addCSS(".loading { padding: 5px; font - family: Arial; font - size: 10pt; border: 1px outset #0094ff; width: 200px; height: 100px; display: none; background - color: lightgrey; z - index: 999; position: absolute; }");
    setTimeout(function () {
        var modal = $('<div />');
        modal.addClass("modal");
        $('body').append(modal);
        var loading = $(".loading");
        loading.show();
        var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
        var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
        loading.css({ top: top, left: left });
    }, 200);
};
