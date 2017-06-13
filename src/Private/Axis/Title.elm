module Private.Axis.Title exposing (..)

import Svg exposing (Svg, text, text_)
import Svg.Attributes exposing (textAnchor)
import Plot.Axis as Axis exposing (Orient)
import Private.Extras.Interval exposing (Interval)
import Private.Extras.SvgAttributes exposing (rotate, x, y)


createTitle : Interval -> Orient -> Int -> Int -> List (Svg.Attribute msg) -> Maybe Int -> Maybe String -> List (Svg msg)
createTitle extent orient innerTickSize tickPadding attrs offset title =
    case title of
        Just s ->
            [ titleSvg extent orient innerTickSize tickPadding attrs offset s ]

        Nothing ->
            []


titleSvg : Interval -> Orient -> Int -> Int -> List (Svg.Attribute msg) -> Maybe Int -> String -> Svg msg
titleSvg extent orient innerTickSize tickPadding attrs offset title =
    text_ (titleAttrs extent orient innerTickSize tickPadding attrs offset)
        [ text title ]


titleAttrs : Interval -> Orient -> Int -> Int -> List (Svg.Attribute msg) -> Maybe Int -> List (Svg.Attribute msg)
titleAttrs extent orient innerTickSize tickPadding attrs offset =
    let
        middle =
            ((extent.end - extent.start) / 2) + extent.start

        sign =
            if orient == Axis.Top || orient == Axis.Left then
                -1
            else
                1

        calOffset =
            case offset of
                Just o ->
                    toFloat (sign * o)

                Nothing ->
                    toFloat (sign * (innerTickSize + tickPadding + 30))

        posAttrs =
            if orient == Axis.Top || orient == Axis.Bottom then
                [ x middle, y calOffset ]
            else
                [ x calOffset, y middle, rotate ( calOffset, middle ) (sign * 90) ]
    in
        (textAnchor "middle") :: posAttrs ++ attrs
