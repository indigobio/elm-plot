module Private.Bars where

import Private.Point as Point exposing (Point, InterpolatedPoint)
import Private.BoundingBox exposing (BoundingBox)
import Svg exposing (Svg, rect)
import Private.Scale exposing (Scale)
import Private.Scale.Utils as Scale
import Private.Extras.SvgAttributes exposing (x, y, height, width)

type Orient = Vertical | Horizontal
type alias PosInfo = {x: Float, y: Float, width: Float, height: Float}

interpolate : Scale x a -> Scale y b -> List (Point a b) -> List (InterpolatedPoint a b)
interpolate xScale yScale points =
  List.map
    (Point.interpolate xScale yScale)
    (filterPointsOutOfDomain xScale yScale points)

filterPointsOutOfDomain : Scale x a -> Scale y b -> List (Point a b) -> List (Point a b)
filterPointsOutOfDomain xScale yScale points =
  case points of
    [] ->
      points
    hd :: tail ->
      if insideDomain xScale yScale hd then
        hd :: filterPointsOutOfDomain xScale yScale tail
      else
        filterPointsOutOfDomain xScale yScale tail

insideDomain : Scale x a -> Scale y b -> Point a b -> Bool
insideDomain xScale yScale point =
  Scale.inDomain xScale point.x && Scale.inDomain yScale point.y

toSvg : BoundingBox -> Orient -> List (List Svg.Attribute) -> List (InterpolatedPoint a b) -> List Svg
toSvg bBox orient additionalAttrs points =
  List.map2 (createBar bBox orient) additionalAttrs points

createBar : BoundingBox -> Orient -> List Svg.Attribute -> InterpolatedPoint a b -> Svg
createBar bBox orient additionalAttrs point =
  rect
    (barAttrs bBox orient additionalAttrs point)
    []

barAttrs : BoundingBox -> Orient -> List Svg.Attribute -> InterpolatedPoint a b -> List Svg.Attribute
barAttrs bBox orient additionalAttrs point =
  let
    pos = posInfo bBox orient point
  in
    [ x pos.x
    , y pos.y
    , width pos.width
    , height pos.height
    ] ++ additionalAttrs

posInfo : BoundingBox -> Orient -> InterpolatedPoint a b -> PosInfo
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
