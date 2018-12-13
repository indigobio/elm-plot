module Private.PointValue exposing (PointValue)


type alias PointValue a =
    { value : Float, width : Float, originalValue : a }
