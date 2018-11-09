module Private.Scale.OrdinalBands exposing (createMapping, createTicks, inDomain, interpolate, uninterpolate)

import Dict exposing (Dict)
import Private.Extras.Interval exposing (Interval)
import Private.PointValue exposing (PointValue)
import Private.Scale.Ordinal as OrdinalScale exposing (OrdinalMapping)
import Private.Tick as Tick exposing (Tick)


interpolate : (List String -> Interval -> OrdinalMapping) -> List String -> Interval -> String -> PointValue String
interpolate mapping domain range s =
    OrdinalScale.interpolate (mapping domain range) s


uninterpolate : (List String -> Interval -> OrdinalMapping) -> List String -> Interval -> Float -> String
uninterpolate mapping domain range x =
    OrdinalScale.uninterpolate (mapping domain range) x


createTicks : (List String -> Interval -> OrdinalMapping) -> List String -> Interval -> List Tick
createTicks mapping domain range =
    OrdinalScale.createTicks (mapping domain range)
        (\label pv -> Tick.create (pv.value + pv.width / 2) label)


inDomain : List String -> String -> Bool
inDomain domain x =
    List.member x domain



-- https://github.com/mbostock/d3/blob/6cc03db0de3777f034dc910a7cae2cbecb0ed099/src/scale/ordinal.js#L61


createMapping : Float -> Float -> List String -> Interval -> OrdinalMapping
createMapping padding outerPadding domain range =
    let
        start =
            min range.start range.end

        stop =
            max range.start range.end

        step =
            (stop - start) / (toFloat (List.length domain) - padding + 2 * outerPadding)

        bandWidth =
            abs (step * (1 - padding))

        adjStart =
            start + step * outerPadding

        adjDomain =
            if range.start < range.end then
                domain

            else
                List.reverse domain
    in
    { lookup = OrdinalScale.buildLookup adjStart step bandWidth adjDomain Dict.empty
    , stepSize = step
    }
