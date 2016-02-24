module Line.Interpolation (linear) where

import Private.Models exposing (TransformedPoints, Interpolation)

linear : Interpolation
linear points =
  let
    pointsStrings = List.map (\p -> toString p.x ++ "," ++ toString p.y) points
  in
    if List.length points == 1 then
      join pointsStrings ++ "Z"
    else
      join <| List.intersperse "L"  pointsStrings

join : List String -> String
join list =
  List.foldr (++) "" list
