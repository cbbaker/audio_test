port module Audio exposing (..)


type alias StartParams =
    { oscillators : List Oscillator
    }


type alias Oscillator =
    { frequency : Float
    , gain : Float
    }


type alias UpdateParams =
    { index : Int
    , gain : Float
    }


port startAudio : StartParams -> Cmd msg


port stopAudio : () -> Cmd msg


port updateOscillator : UpdateParams -> Cmd msg


start : Float -> Float -> Cmd msg
start frequency gain =
    startAudio <| StartParams [ Oscillator frequency gain ]


stop : Cmd msg
stop =
    stopAudio ()


update : Float -> Cmd msg
update gain =
    updateOscillator <| UpdateParams 0 gain
