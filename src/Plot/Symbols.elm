module Plot.Symbols exposing (circle, square, diamond, triangleUp, triangleDown, cross)

import Svg exposing (Svg, g, line)
import Svg.Attributes exposing (d, stroke, strokeWidth)
import Plot.Interpolation exposing (linear)
import Private.Point as Point
import Private.Points exposing (Points)
import Private.Extras.SvgAttributes exposing (rotate, cx, cy, r, x, y, width, height, x1, x2, y1, y2)
import Plot.SymbolCreator exposing (SymbolCreator)


circle : Int -> SymbolCreator a b msg
circle radius xPos yPos origX origY additionalAttrs =
    createSvg Svg.circle
        additionalAttrs
        [ cx xPos
        , cy yPos
        , r radius
        ]


square : Float -> SymbolCreator a b msg
square length xPos yPos origX origY additionalAttrs =
    createSvg Svg.rect
        additionalAttrs
        [ x (xPos - length / 2)
        , y (yPos - length / 2)
        , width length
        , height length
        ]


diamond : Float -> SymbolCreator a b msg
diamond length xPos yPos origX origY additionalAttrs =
    let
        attrs =
            (rotate ( xPos, yPos ) 45) :: additionalAttrs
    in
        square length xPos yPos origX origY attrs


triangleUp : Float -> SymbolCreator a b msg
triangleUp length xPos yPos origX origY additionalAttrs =
    pathSvg additionalAttrs
        [ Point.create xPos (yPos - length / 2) []
        , Point.create (xPos - length / 2) (yPos + length / 2) []
        , Point.create (xPos + length / 2) (yPos + length / 2) []
        ]


triangleDown : Float -> SymbolCreator a b msg
triangleDown length xPos yPos origX origY additionalAttrs =
    pathSvg additionalAttrs
        [ Point.create xPos (yPos + length / 2) []
        , Point.create (xPos - length / 2) (yPos - length / 2) []
        , Point.create (xPos + length / 2) (yPos - length / 2) []
        ]


cross : Float -> SymbolCreator a b msg
cross length xPos yPos origX origY additionalAttrs =
    let
        attrs =
            (stroke "black") :: additionalAttrs
    in
        g []
            [ line
                ([ x1 (xPos - length / 2)
                 , y1 (yPos - length / 2)
                 , x2 (xPos + length / 2)
                 , y2 (yPos + length / 2)
                 ]
                    ++ attrs
                )
                []
            , line
                ([ x1 (xPos - length / 2)
                 , y1 (yPos + length / 2)
                 , x2 (xPos + length / 2)
                 , y2 (yPos - length / 2)
                 ]
                    ++ attrs
                )
                []
            ]


pathSvg : List (Svg.Attribute msg) -> Points Float Float msg -> Svg msg
pathSvg additionalAttrs points =
    createSvg Svg.path additionalAttrs [ d ("M" ++ linear points) ]


createSvg : (List (Svg.Attribute msg) -> List (Svg msg) -> Svg msg) -> List (Svg.Attribute msg) -> List (Svg.Attribute msg) -> Svg msg
createSvg svgFunc additionalAttrs posAttrs =
    svgFunc (List.append posAttrs additionalAttrs)
        []
