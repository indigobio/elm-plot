module Private.Points exposing (InterpolatedPoints, Points, interpolate, toSvg)

import Private.Point as Point exposing (InterpolatedPoint, Point)
import Private.Scale exposing (Scale)
import Private.Scale.Utils as Scale
import Svg exposing (Svg, rect)


type alias Points a b msg =
    List (Point a b msg)


type alias InterpolatedPoints a b msg =
    List (InterpolatedPoint a b msg)


interpolate : Scale x a -> Scale y b -> Points a b msg -> InterpolatedPoints a b msg
interpolate xScale yScale points =
    List.map (Point.interpolate xScale yScale)
        (filterPointsOutOfDomain xScale yScale points)


toSvg : (Float -> Float -> a -> b -> List (Svg.Attribute msg) -> Svg msg) -> InterpolatedPoints a b msg -> List (Svg msg)
toSvg pointToSvg points =
    List.map (\p -> pointToSvg p.x.value p.y.value p.x.originalValue p.y.originalValue p.attrs) points


filterPointsOutOfDomain : Scale x a -> Scale y b -> Points a b msg -> Points a b msg
filterPointsOutOfDomain xScale yScale points =
    case points of
        [] ->
            points

        hd :: tail ->
            if insideDomain xScale yScale hd then
                hd :: filterPointsOutOfDomain xScale yScale tail
            else
                filterPointsOutOfDomain xScale yScale tail


insideDomain : Scale x a -> Scale y b -> Point a b msg -> Bool
insideDomain xScale yScale point =
    Scale.inDomain xScale point.x && Scale.inDomain yScale point.y
