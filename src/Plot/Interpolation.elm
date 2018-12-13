module Plot.Interpolation exposing (Interpolation, linear)

import Private.Points exposing (Points)


type alias Interpolation msg =
    Points Float Float msg -> String


linear : Interpolation msg
linear points =
    let
        pointStrings =
            List.map (\p -> String.fromFloat p.x ++ "," ++ String.fromFloat p.y) points
    in
    if List.length points == 1 then
        join pointStrings ++ "Z"

    else
        join (List.intersperse "L" pointStrings)


join : List String -> String
join list =
    List.foldr (++) "" list
