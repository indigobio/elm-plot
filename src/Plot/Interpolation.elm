module Plot.Interpolation exposing (Interpolation, linear)

import Private.Points exposing (Points)


type alias Interpolation msg =
    Points Float Float msg -> String


linear : Interpolation msg
linear points =
    let
        pointStrings =
            List.map (\p -> toString p.x ++ "," ++ toString p.y) points
    in
        if List.length points == 1 then
            join pointStrings ++ "Z"
        else
            join (List.intersperse "L" pointStrings)


join : List String -> String
join list =
    List.foldr (++) "" list
