module Symbols (circle, square, diamond, triangleUp, triangleDown, cross) where

import Svg exposing (Svg, g, line)
import Svg.Attributes exposing (d, x1, x2, y1, y2, stroke, strokeWidth)
import Line.Interpolation exposing (linear)
import Private.Models exposing (Points)
import SvgAttributesExtra exposing (rotate, cx, cy, r, x, y, width, height)

circle : Int -> List Svg.Attribute -> Float -> Float -> Svg
circle radius additionalAttrs x y =
  createSvg Svg.circle  additionalAttrs [cx x, cy y, r radius]

square : Float -> List Svg.Attribute -> Float -> Float -> Svg
square length additionalAttrs xPos yPos =
  createSvg Svg.rect additionalAttrs
    [ x (xPos - length / 2)
    , y (yPos - length / 2)
    , width length
    , height length
    ]

diamond : Float -> List Svg.Attribute -> Float -> Float -> Svg
diamond length additionalAttrs xPos yPos =
  square length ((rotate (xPos, yPos) 45) :: additionalAttrs) xPos yPos

triangleUp : Float -> List Svg.Attribute -> Float -> Float -> Svg
triangleUp length additionalAttrs xPos yPos =
  pathSvg additionalAttrs
      [ { x = xPos, y = yPos - length / 2 }
      , { x = xPos - length / 2, y = yPos + length / 2}
      , { x = xPos + length / 2, y = yPos + length / 2}
      ]

triangleDown : Float -> List Svg.Attribute -> Float -> Float -> Svg
triangleDown length additionalAttrs xPos yPos =
  pathSvg additionalAttrs
      [ { x = xPos, y = yPos + length / 2 }
      , { x = xPos - length / 2, y = yPos - length / 2}
      , { x = xPos + length / 2, y = yPos - length / 2}
      ]

cross : Float -> List Svg.Attribute -> Float -> Float -> Svg
cross length additionalAttrs xPos yPos =
  let
    attrs =
      if List.isEmpty additionalAttrs then
        [ stroke "black"]
      else
        additionalAttrs
  in
  g
    additionalAttrs
    [ line
        ( [ x1 (toString (xPos - length / 2))
          , y1 (toString (yPos - length / 2))
          , x2 (toString (xPos + length / 2))
          , y2 (toString (yPos + length / 2))
          ] ++ attrs )
        []
    , line
        ( [ x1 (toString (xPos - length / 2))
          , y1 (toString (yPos + length / 2))
          , x2 (toString (xPos + length / 2))
          , y2 (toString (yPos - length / 2))
          ] ++ attrs )
        []
    ]

pathSvg : List Svg.Attribute -> Points Float Float -> Svg
pathSvg additionalAttrs points =
  createSvg Svg.path additionalAttrs [ d <| "M" ++ linear points]

createSvg : (List Svg.Attribute -> List Svg -> Svg) -> List Svg.Attribute -> List Svg.Attribute -> Svg
createSvg svgFunc additionalAttrs posAttrs =
  svgFunc
    (List.append posAttrs additionalAttrs)
    []
