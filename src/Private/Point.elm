module Private.Point exposing (InterpolatedPoint, Point, create, interpolate)

import Private.PointValue exposing (PointValue)
import Private.Scale exposing (Scale)
import Private.Scale.Utils as Scale
import Svg


type alias Point a b msg =
    { x : a
    , y : b
    , attrs : List (Svg.Attribute msg)
    }


type alias InterpolatedPoint a b msg =
    { x : PointValue a
    , y : PointValue b
    , attrs : List (Svg.Attribute msg)
    }


create : a -> b -> List (Svg.Attribute msg) -> Point a b msg
create x y attrs =
    { x = x
    , y = y
    , attrs = attrs
    }


interpolate : Scale x a -> Scale y b -> Point a b msg -> InterpolatedPoint a b msg
interpolate xScale yScale point =
    { x = Scale.interpolate xScale point.x
    , y = Scale.interpolate yScale point.y
    , attrs = point.attrs
    }
