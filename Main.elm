module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Audio


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


baseFrequency : Float
baseFrequency =
    220.0


type alias Model =
    { state : State
    , overtone : Int
    , gain : Float
    }


frequency : Model -> Float
frequency { overtone } =
    baseFrequency * (toFloat overtone)


type State
    = Stopped
    | Playing


init : ( Model, Cmd msg )
init =
    Model Stopped 1 1.0 ! []


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none



-- UPDATE


type Msg
    = Start
    | Stop
    | Overtone String
    | Gain String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Start ->
            { model | state = Playing } ! [ Audio.start (frequency model) model.gain ]

        Stop ->
            { model | state = Stopped } ! [ Audio.stop ]

        Overtone overtoneInput ->
            let
                overtone =
                    String.toInt overtoneInput |> Result.withDefault model.overtone

                newModel =
                    { model | overtone = overtone }
            in
                newModel ! startAudio newModel

        Gain gainInput ->
            let
                gain =
                    String.toFloat gainInput |> Result.withDefault model.gain

                newModel =
                    { model | gain = gain }
            in
                newModel ! [ Audio.update gain ]


startAudio : Model -> List (Cmd Msg)
startAudio model =
    case model.state of
        Playing ->
            [ Audio.start (frequency model) model.gain ]

        Stopped ->
            []



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ header model
        , jumbotron model
        , footer model
        ]


header : Model -> Html Msg
header model =
    div [ class "header clearfix" ]
        [ nav []
            [ ul [ class "nav nav-pills float-right" ]
                [ li [ class "nav-item" ]
                    [ a
                        [ class "nav-link active"
                        , href "#"
                        ]
                        [ text "Home "
                        , span [ class "sr-only" ] [ text "(current)" ]
                        ]
                    ]
                , li [ class "nav-item" ]
                    [ a
                        [ class "nav-link"
                        , href "#"
                        ]
                        [ text "About"
                        ]
                    ]
                , li [ class "nav-item" ]
                    [ a
                        [ class "nav-link"
                        , href "#"
                        ]
                        [ text "Contact"
                        ]
                    ]
                ]
            ]
        ]


jumbotron : Model -> Html Msg
jumbotron model =
    div [ class "jumbotron" ]
        [ h1 [ class "display-3" ] [ text "Web audio" ]
        , p [ class "lead" ] [ text "Turn on your sound and press the button below to start" ]
        , controls model
        , button model
        ]


controls : Model -> Html Msg
controls model =
    Html.form []
        [ div [ class "form-group" ]
            [ label [ for "overtoneInput" ] [ text "overtone" ]
            , input
                [ type_ "number"
                , Html.Attributes.min "1"
                , class "form-control"
                , id "overtoneInput"
                , value (toString model.overtone)
                , onInput Overtone
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label [ for "gainInput" ] [ text "gain" ]
            , input
                [ type_ "number"
                , class "form-control"
                , id "gainInput"
                , Html.Attributes.min "0"
                , Html.Attributes.max "1"
                , value (toString model.gain)
                , onInput Gain
                ]
                []
            ]
        ]


button : Model -> Html Msg
button model =
    case model.state of
        Playing ->
            Html.button
                [ onClick Stop
                , class "btn btn-lrg btn-danger"
                ]
                [ text "Stop" ]

        Stopped ->
            Html.button
                [ onClick Start
                , class "btn btn-lrg btn-success"
                ]
                [ text "Start" ]


footer : Model -> Html Msg
footer model =
    Html.footer [ class "footer" ]
        [ p [] [ text "© 2017" ]
        ]
