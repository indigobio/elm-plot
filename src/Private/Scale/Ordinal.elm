module Private.Scale.Ordinal exposing (OrdinalMapping, buildLookup, createTicks, interpolate, uninterpolate)

import Dict exposing (Dict)
import Private.Extras.List exposing (find)
import Private.PointValue exposing (PointValue)
import Private.Tick exposing (Tick)


type alias OrdinalMapping =
    { lookup : Dict String (PointValue String)
    , stepSize : Float
    }


interpolate : OrdinalMapping -> String -> PointValue String
interpolate mapping s =
    case Dict.get s (.lookup mapping) of
        Just x ->
            x

        Nothing ->
            { value = 0, width = 0, originalValue = s }


uninterpolate : OrdinalMapping -> Float -> String
uninterpolate mapping x =
    let
        withinHalfStepSize =
            \kv -> abs (.value (Tuple.second kv) - x) <= mapping.stepSize / 2
    in
    case find withinHalfStepSize (Dict.toList mapping.lookup) of
        Just kv ->
            Tuple.first kv

        Nothing ->
            ""


createTicks : OrdinalMapping -> (String -> PointValue String -> Tick) -> List Tick
createTicks mapping createTick =
    List.map (\v -> createTick (Tuple.first v) (Tuple.second v)) <| Dict.toList <| mapping.lookup


buildLookup : Float -> Float -> Float -> List String -> Dict String (PointValue String) -> Dict String (PointValue String)
buildLookup start step width domain dict =
    if List.length domain == 0 then
        dict

    else
        let
            orgValue =
                Maybe.withDefault "" (List.head domain)

            pv =
                { value = start, width = width, originalValue = orgValue }
        in
        buildLookup (start + step) step width (List.drop 1 domain) <|
            Dict.insert orgValue pv dict
