module Private.Axis.View exposing (axisSvg, axisTranslation, calculateAxisExtent, horizontalAxisString, pathString, toSvg, verticalAxisString)

import Plot.Axis as Axis exposing (Axis, Orient)
import Private.Axis.Ticks as AxisTicks
import Private.Axis.Title as AxisTitle
import Private.BoundingBox exposing (BoundingBox)
import Private.Extras.Interval as Interval exposing (Interval)
import Private.Extras.SvgAttributes exposing (translate)
import Private.Scale exposing (Scale)
import Svg exposing (Svg, g, path)
import Svg.Attributes exposing (d)


toSvg : Axis a b msg -> Svg msg
toSvg axis =
    let
        extent =
            calculateAxisExtent axis.boundingBox axis.orient axis.scale.range
    in
    g [ axisTranslation axis.boundingBox axis.orient ] <|
        List.concat
            [ [ axisSvg axis ]
            , AxisTicks.createTicks axis
            , AxisTitle.createTitle extent axis.orient axis.innerTickSize axis.tickPadding axis.titleAttributes axis.titleOffset axis.title
            ]


calculateAxisExtent : BoundingBox -> Orient -> Interval -> Interval
calculateAxisExtent bBox orient interval =
    let
        extent =
            Interval.extentOf interval

        calc =
            if orient == Axis.Top || orient == Axis.Bottom then
                Interval.create (max extent.start bBox.xStart) (min extent.end bBox.xEnd)

            else
                Interval.create (max extent.start bBox.yStart) (min extent.end bBox.yEnd)
    in
    Interval.extentOf calc


axisTranslation : BoundingBox -> Orient -> Svg.Attribute msg
axisTranslation bBox orient =
    let
        pos =
            case orient of
                Axis.Top ->
                    ( 0, bBox.yStart )

                Axis.Bottom ->
                    ( 0, bBox.yEnd )

                Axis.Left ->
                    ( bBox.xStart, 0 )

                Axis.Right ->
                    ( bBox.xEnd, 0 )
    in
    translate pos


axisSvg : Axis a b msg -> Svg msg
axisSvg axis =
    let
        ps =
            pathString axis.boundingBox axis.scale axis.orient axis.outerTickSize

        attrs =
            d ps :: axis.axisAttributes
    in
    path attrs
        []


pathString : BoundingBox -> Scale a b -> Orient -> Int -> String
pathString bBox scale orient tickSize =
    let
        extent =
            Interval.extentOf scale.range

        start =
            extent.start

        end =
            extent.end

        path =
            case orient of
                Axis.Top ->
                    verticalAxisString bBox -tickSize start end

                Axis.Bottom ->
                    verticalAxisString bBox tickSize start end

                Axis.Left ->
                    horizontalAxisString bBox -tickSize start end

                Axis.Right ->
                    horizontalAxisString bBox tickSize start end
    in
    "M" ++ path


verticalAxisString : BoundingBox -> Int -> Float -> Float -> String
verticalAxisString bBox tickLocation xStart xEnd =
    let
        start =
            max xStart bBox.xStart

        end =
            min xEnd bBox.xEnd
    in
    String.fromFloat start ++ "," ++ String.fromInt tickLocation ++ "V0H" ++ String.fromFloat end ++ "V" ++ String.fromInt tickLocation


horizontalAxisString : BoundingBox -> Int -> Float -> Float -> String
horizontalAxisString bBox tickLocation yStart yEnd =
    let
        start =
            max yStart bBox.yStart

        end =
            min yEnd bBox.yEnd
    in
    String.fromInt tickLocation ++ "," ++ String.fromFloat start ++ "H0V" ++ String.fromFloat end ++ "H" ++ String.fromInt tickLocation
