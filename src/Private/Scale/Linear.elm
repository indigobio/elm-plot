module Private.Scale.Linear exposing (createTicks, inDomain, interpolate, uninterpolate)

import Private.Extras.Float exposing (ln, roundTo)
import Private.Extras.Interval as Interval exposing (Interval)
import Private.PointValue exposing (PointValue)
import Private.Tick as Tick exposing (Tick)


interpolate : Interval -> Interval -> Float -> PointValue Float
interpolate domain range x =
    let
        value =
            if domain.start == domain.end then
                range.start
            else
                (((x - domain.start) * (range.end - range.start)) / (domain.end - domain.start)) + range.start
    in
    { value = value, width = 0, originalValue = x }


uninterpolate : Interval -> Interval -> Float -> Float
uninterpolate domain range y =
    if range.start == range.end then
        domain.start
    else
        ((y - range.start) * (domain.end - domain.start) / (range.end - range.start)) + domain.start


inDomain : Interval -> Float -> Bool
inDomain domain x =
    let
        extent =
            Interval.extentOf domain
    in
    (x >= extent.start) && (x <= extent.end)



-- https://github.com/mbostock/d3/blob/78ce531f79e82275fe50f975e784ee2be097226b/src/scale/linear.js#L96


createTicks : Int -> Interval -> Interval -> List Tick
createTicks numTicks domain range =
    let
        extent =
            Interval.extentOf domain

        step =
            stepSize extent (toFloat numTicks)

        min =
            toFloat (ceiling (extent.start / step)) * step

        max =
            toFloat (floor (extent.end / step)) * step + step * 0.5
    in
    makeTicks min max step
        |> List.map (createTick (significantDigits step) domain range)


createTick : Int -> Interval -> Interval -> Float -> Tick
createTick sigDigits domain range position =
    Tick.create (roundTo (interpolate domain range position).value sigDigits)
        (toString position)


stepSize : Interval -> Float -> Float
stepSize extent numTicks =
    let
        span =
            Interval.span extent

        step =
            toFloat (10 ^ floor (ln (span / numTicks) / ln 10))

        err =
            numTicks / span * step
    in
    if err <= 0.15 then
        step * 10
    else if err < 0.35 then
        step * 5
    else if err < 0.75 then
        step * 2
    else
        step


makeTicks : Float -> Float -> Float -> List Float
makeTicks min max step =
    if min >= max then
        []
    else
        [ min ] ++ makeTicks (min + step) max step


significantDigits : Float -> Int
significantDigits step =
    negate (floor (ln step / ln 10 + 0.01))
