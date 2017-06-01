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


type alias Model =
    State


type State
    = Stopped
    | Playing


init : ( Model, Cmd msg )
init =
    Stopped ! []


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none



-- UPDATE


type Msg
    = Start
    | Stop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Start ->
            Playing ! [ Audio.start 220.0 ]

        Stop ->
            Stopped ! [ Audio.stop ]



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
        ]


controls : Model -> Html Msg
controls model =
    case model of
        Playing ->
            button
                [ onClick Stop
                , class "btn btn-lrg btn-danger"
                ]
                [ text "Stop" ]

        Stopped ->
            button
                [ onClick Start
                , class "btn btn-lrg btn-success"
                ]
                [ text "Start" ]


footer : Model -> Html Msg
footer model =
    Html.footer [ class "footer" ]
        [ p [] [ text "© 2017" ]
        ]
