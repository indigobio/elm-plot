module BarChart exposing (createLabels, main, points, xScale, yScale)

import Plot exposing (..)
import Plot.Axis as Axis
import Plot.Scale as Scale exposing (LinearScale, OrdinalScale)
import Plot.SymbolCreator exposing (SymbolCreator)
import Svg exposing (Svg, text, text_)
import Svg.Attributes exposing (fill, x, y)


main : Svg msg
main =
    createPlot 800 800
        |> addVerticalBars points xScale yScale
        |> addSymbols points xScale yScale createLabels
        |> addAxis (Axis.create xScale Axis.Bottom)
        |> addAxis (Axis.create yScale Axis.Left)
        |> addTitle "Bar Chart" []
        |> toSvg


createLabels : SymbolCreator String Float msg
createLabels xPos yPos origX origY attrs =
    text_
        [ x <| String.fromFloat <| xPos + 60
        , y <| String.fromFloat <| yPos - 10
        ]
        [ text (String.fromFloat origY) ]


xScale : OrdinalScale
xScale =
    Scale.ordinalBands [ "a", "b", "c", "d" ] ( 0, 800 ) 0.2 0.2


yScale : LinearScale
yScale =
    Scale.linear ( 0, 400 ) ( 800, 0 ) 10


points : List { x : String, y : Float, attrs : List (Svg.Attribute msg) }
points =
    [ { x = "a", y = 10, attrs = [ fill "blue" ] }
    , { x = "b", y = 50, attrs = [ fill "red" ] }
    , { x = "c", y = 100, attrs = [ fill "yellow" ] }
    , { x = "d", y = 400, attrs = [ fill "black" ] }
    ]
