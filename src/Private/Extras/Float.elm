module Private.Extras.Float exposing (ln, roundTo)


ln : Float -> Float
ln x =
    logBase 10 x / logBase 10 e


roundTo : Float -> Int -> Float
roundTo x numPlaces =
    if numPlaces > 0 then
        toFloat (round (x * toFloat (10 ^ numPlaces))) / toFloat (10 ^ numPlaces)

    else
        x
