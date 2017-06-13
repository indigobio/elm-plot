module BarChart exposing (..)

import Svg exposing (Svg, text, text_)
import Plot exposing (..)
import Plot.Scale as Scale
import Plot.Axis as Axis
import Svg.Attributes exposing (fill, x, y)
import Plot.Scale exposing (LinearScale, OrdinalScale)
import Plot.SymbolCreator exposing (SymbolCreator)


main : Svg msg
main =
    createPlot 800 800
        |> addVerticalBars points xScale yScale
        |> addSymbols points xScale yScale createLabels
        |> addAxis (Axis.create xScale Axis.Bottom)
        |> addAxis (Axis.create yScale Axis.Left)
        |> addTitle "Bar Chart" []
        |> toSvg


createLabels : SymbolCreator a b msg
createLabels xPos yPos origX origY attrs =
    text_
        [ x <| toString <| xPos + 60
        , y <| toString <| yPos - 10
        ]
        [ text (toString origY) ]


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
