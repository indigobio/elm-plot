module Symbols exposing (Model, Msg(..), init, main, mkOption, options, plot, points, selectBox, update, view, xScale, yScale)

import Browser
import Html exposing (Html, div, option, select, text)
import Html.Attributes exposing (class, selected, style, value)
import Html.Events exposing (on, targetValue)
import Json.Decode as Json
import Plot exposing (..)
import Plot.Axis as Axis
import Plot.Scale as Scale exposing (LinearScale)
import Plot.SymbolCreator exposing (SymbolCreator)
import Plot.Symbols exposing (circle, cross, diamond, square, triangleDown, triangleUp)
import Svg exposing (Svg)
import Svg.Attributes exposing (fill)


type alias Model =
    SymbolCreator Float Float Msg


type Msg
    = Select String


init : Model
init =
    circle 5


update : Msg -> Model -> Model
update msg model =
    case msg of
        Select symbolType ->
            case symbolType of
                "circle" ->
                    circle 5

                "square" ->
                    square 10

                "diamond" ->
                    diamond 10

                "triangleUp" ->
                    triangleUp 10

                "triangleDown" ->
                    triangleDown 10

                "cross" ->
                    cross 10

                _ ->
                    init


view : Model -> Html Msg
view model =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        ]
        [ plot model
        , selectBox
        ]


plot : Model -> Svg Msg
plot createSym =
    createPlot 800 800
        |> addSymbols points xScale yScale createSym
        |> addAxis (Axis.create xScale Axis.Bottom)
        |> addAxis (Axis.create yScale Axis.Left)
        |> addTitle "Symbols" []
        |> toSvg


xScale : LinearScale
xScale =
    Scale.linear ( 0, 400 ) ( 0, 800 ) 10


yScale : LinearScale
yScale =
    Scale.linear ( 0, 400 ) ( 800, 0 ) 10


points : List { x : Float, y : Float, attrs : List (Svg.Attribute msg) }
points =
    [ { x = 0, y = 0, attrs = [ fill "blue" ] }
    , { x = 50, y = 50, attrs = [ fill "red" ] }
    , { x = 100, y = 100, attrs = [ fill "green" ] }
    , { x = 150, y = 150, attrs = [ fill "yellow" ] }
    , { x = 200, y = 200, attrs = [ fill "black" ] }
    , { x = 250, y = 250, attrs = [ fill "grey" ] }
    , { x = 300, y = 300, attrs = [ fill "purple" ] }
    , { x = 350, y = 350, attrs = [ fill "pink" ] }
    , { x = 400, y = 400, attrs = [ fill "magenta" ] }
    ]


selectBox : Html Msg
selectBox =
    select
        [ style "width" "120px"
        , style "margin-left" "400px"
        , on "change" (Json.map Select targetValue)
        ]
        options


options : List (Html Msg)
options =
    let
        opts =
            [ ( "circle", True )
            , ( "square", False )
            , ( "diamond", False )
            , ( "triangleUp", False )
            , ( "triangleDown", False )
            , ( "cross", False )
            ]
    in
    List.map mkOption opts


mkOption : ( String, Bool ) -> Html Msg
mkOption ( opt, default ) =
    option
        [ value opt
        , selected default
        ]
        [ text opt ]


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
