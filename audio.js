function initAudio(oscillatorParams) {
    // Webkit/blink browsers need prefix, Safari won't work without window.
    var audioCtx = new (window.AudioContext || window.webkitAudioContext)(); // define audio context

    var i, oscillators = []
    for (i = 0; i < oscillatorParams.length; ++i) {
        var gain = audioCtx.createGain();
        gain.gain.value = oscillatorParams[i].gain || 1.0;
        gain.connect(audioCtx.destination)
        
        var osc = audioCtx.createOscillator();
        osc.type = 'sine';
        osc.frequency.value = oscillatorParams[i].frequency || 440.0;
        osc.connect(gain);
        osc.start();

        oscillators.push({
            node: osc,
            gain: gain
        });
    }

    return {
        audioCtx: audioCtx,
        oscillators: oscillators
    };
}

function termAudio(audio) {
    audio.audioCtx.close();
}

function updateOscillator(audio, index, gain) {
    audio.oscillators[index].gain.gain.value = gain;
}
