function initAudio(params) {
    // Webkit/blink browsers need prefix, Safari won't work without window.
    var audioCtx = new (window.AudioContext || window.webkitAudioContext)(); // define audio context
    
    var osc = audioCtx.createOscillator();
    osc.type = 'sine';
    osc.frequency.value = params.frequency;
    osc.connect(audioCtx.destination);
    osc.start();

    return {
        audioCtx: audioCtx,
        osc: osc
    };
}

function termAudio(audio) {
    audio.audioCtx.close();
}
