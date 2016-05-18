module Private.Extras.SvgAttributes exposing (..)

import Svg
import Svg.Attributes exposing (transform)


translate : ( number, number ) -> Svg.Attribute msg
translate pos =
    transform <| "translate(" ++ (toString (fst pos)) ++ "," ++ (toString (snd pos)) ++ ")"


rotate : ( number, number ) -> Int -> Svg.Attribute msg
rotate pos rotation =
    transform <| "rotate(" ++ (toString rotation) ++ "," ++ (toString (fst pos)) ++ "," ++ (toString (snd pos)) ++ ")"


x1 : number -> Svg.Attribute msg
x1 x =
    Svg.Attributes.x1 (toString x)


y1 : number -> Svg.Attribute msg
y1 y =
    Svg.Attributes.y1 (toString y)


x2 : number -> Svg.Attribute msg
x2 x =
    Svg.Attributes.x2 (toString x)


y2 : number -> Svg.Attribute msg
y2 y =
    Svg.Attributes.y2 (toString y)


x : number -> Svg.Attribute msg
x num =
    Svg.Attributes.x (toString num)


y : number -> Svg.Attribute msg
y num =
    Svg.Attributes.y (toString num)


width : number -> Svg.Attribute msg
width w =
    Svg.Attributes.width (toString w)


height : number -> Svg.Attribute msg
height h =
    Svg.Attributes.height (toString h)


cx : number -> Svg.Attribute msg
cx num =
    Svg.Attributes.cx (toString num)


cy : number -> Svg.Attribute msg
cy num =
    Svg.Attributes.cy (toString num)


r : number -> Svg.Attribute msg
r num =
    Svg.Attributes.r (toString num)
