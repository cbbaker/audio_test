(function () {
    var node = document.getElementById('main');
    var app = Elm.Main.embed(node);
    var audio = null;

    app.ports.startAudio.subscribe(function(params) {
        if (params.oscillators !== undefined) {
            if (audio) {
                termAudio(audio);
                audio = null;
            }

            audio = initAudio(params.oscillators);
        }
    });

    app.ports.stopAudio.subscribe(function() {
        if (audio) {
            termAudio(audio);
            audio = null;
        }
    });

    app.ports.updateOscillator.subscribe(function(params) {
        if (params.index !== undefined && params.gain !== undefined) {
            updateOscillator(audio, params.index, params.gain);
        }
    });
})();
