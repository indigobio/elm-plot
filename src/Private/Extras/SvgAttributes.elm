module Private.Extras.SvgAttributes exposing (cx, cy, height, r, rotate, translate, width, x, x1, x2, y, y1, y2)

import Svg
import Svg.Attributes exposing (transform)


translate : ( Float, Float ) -> Svg.Attribute msg
translate pos =
    transform <| "translate(" ++ String.fromFloat (Tuple.first pos) ++ "," ++ String.fromFloat (Tuple.second pos) ++ ")"


rotate : ( Float, Float ) -> Int -> Svg.Attribute msg
rotate pos rotation =
    transform <| "rotate(" ++ String.fromInt rotation ++ "," ++ String.fromFloat (Tuple.first pos) ++ "," ++ String.fromFloat (Tuple.second pos) ++ ")"


x1 : Float -> Svg.Attribute msg
x1 xVal =
    Svg.Attributes.x1 (String.fromFloat xVal)


y1 : Float -> Svg.Attribute msg
y1 yVal =
    Svg.Attributes.y1 (String.fromFloat yVal)


x2 : Float -> Svg.Attribute msg
x2 xVal =
    Svg.Attributes.x2 (String.fromFloat xVal)


y2 : Float -> Svg.Attribute msg
y2 yVal =
    Svg.Attributes.y2 (String.fromFloat yVal)


x : Float -> Svg.Attribute msg
x num =
    Svg.Attributes.x (String.fromFloat num)


y : Float -> Svg.Attribute msg
y num =
    Svg.Attributes.y (String.fromFloat num)


width : Float -> Svg.Attribute msg
width w =
    Svg.Attributes.width (String.fromFloat w)


height : Float -> Svg.Attribute msg
height h =
    Svg.Attributes.height (String.fromFloat h)


cx : Float -> Svg.Attribute msg
cx num =
    Svg.Attributes.cx (String.fromFloat num)


cy : Float -> Svg.Attribute msg
cy num =
    Svg.Attributes.cy (String.fromFloat num)


r : Int -> Svg.Attribute msg
r num =
    Svg.Attributes.r (String.fromInt num)
