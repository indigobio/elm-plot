module Private.Bars exposing (..)

import Private.Point as Point exposing (Point, InterpolatedPoint)
import Private.BoundingBox exposing (BoundingBox)
import Svg exposing (Svg, rect)
import Private.Scale exposing (Scale)
import Private.Extras.SvgAttributes exposing (x, y, height, width)
import Private.Points as Points exposing (InterpolatedPoints)


type Orient
    = Vertical
    | Horizontal


type alias PosInfo =
    { x : Float, y : Float, width : Float, height : Float }


interpolate : Scale x a -> Scale y b -> List (Point a b msg) -> InterpolatedPoints a b msg
interpolate xScale yScale points =
    Points.interpolate xScale yScale points


toSvg : BoundingBox -> Orient -> InterpolatedPoints a b msg -> List (Svg msg)
toSvg bBox orient points =
    List.map (createBar bBox orient) points


createBar : BoundingBox -> Orient -> InterpolatedPoint a b msg -> Svg msg
createBar bBox orient point =
    rect (barAttrs bBox orient point)
        []


barAttrs : BoundingBox -> Orient -> InterpolatedPoint a b msg -> List (Svg.Attribute msg)
barAttrs bBox orient point =
    let
        pos =
            posInfo bBox orient point
    in
        [ x pos.x
        , y pos.y
        , width pos.width
        , height pos.height
        ]
            ++ point.attrs


posInfo : BoundingBox -> Orient -> InterpolatedPoint a b msg -> PosInfo
posInfo bBox orient point =
    case orient of
        Vertical ->
            { x = point.x.value
            , y = point.y.value
            , width = point.x.width
            , height = bBox.yEnd - point.y.value
            }

        Horizontal ->
            { x = bBox.xStart
            , y = point.y.value
            , width = point.x.value - bBox.xStart
            , height = point.y.width
            }
