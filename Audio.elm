port module Audio exposing (..)


type alias Params =
    { frequency : Float }


port startAudio : Params -> Cmd msg


port stopAudio : () -> Cmd msg


start : Float -> Cmd msg
start frequency =
    startAudio <| Params frequency


stop : Cmd msg
stop =
    stopAudio ()
