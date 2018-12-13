module Private.Extras.Interval exposing (Interval, create, createFromTuple, extentOf, isAscending, isDescending, reverse, span)


type alias Interval =
    { start : Float, end : Float }


create : Float -> Float -> Interval
create start end =
    { start = start
    , end = end
    }


createFromTuple : ( Float, Float ) -> Interval
createFromTuple interval =
    create (Tuple.first interval) (Tuple.second interval)


extentOf : Interval -> Interval
extentOf interval =
    if isAscending interval then
        interval

    else
        reverse interval


span : Interval -> Float
span interval =
    abs (interval.end - interval.start)


isAscending : Interval -> Bool
isAscending interval =
    interval.start < interval.end


isDescending : Interval -> Bool
isDescending interval =
    interval.start > interval.end


reverse : Interval -> Interval
reverse interval =
    create interval.end interval.start
