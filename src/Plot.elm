module Plot exposing
    ( addAttributes
    , addAxis
    , addHorizontalBars
    , addSymbols
    , addTitle
    , addVerticalBars
    , createPlot
    , margins
    , toSvg
    )

import Plot.Axis as Axis exposing (Axis)
import Plot.SymbolCreator exposing (SymbolCreator)
import Private.Axis.View as AxisView
import Private.Bars as Bars exposing (Orient)
import Private.BoundingBox as BoundingBox exposing (BoundingBox)
import Private.Dimensions exposing (Dimensions)
import Private.Extras.SvgAttributes exposing (height, width)
import Private.Margins as Margins exposing (Margins)
import Private.Points as Points
import Private.Scale exposing (Scale)
import Private.Scale.Utils as Scale
import Private.Title as Title
import Svg exposing (Svg, svg)


type alias Plot msg =
    { dimensions : Dimensions
    , margins : Margins
    , svgs : List (BoundingBox -> List (Svg msg))
    , attrs : List (Svg.Attribute msg)
    , title : Title.Model msg
    }


type alias Points a b msg =
    List (Point a b msg)


type alias Point a b msg =
    { x : a
    , y : b
    , attrs : List (Svg.Attribute msg)
    }


createPlot : Float -> Float -> Plot msg
createPlot w h =
    { dimensions = { width = w, height = h }
    , margins = Margins.init
    , svgs = []
    , attrs = [ width w, height h ]
    , title = Title.init
    }


addTitle : String -> List (Svg.Attribute msg) -> Plot msg -> Plot msg
addTitle title attrs plot =
    { plot | title = Title.create title attrs }


addAttributes : List (Svg.Attribute msg) -> Plot msg -> Plot msg
addAttributes attrs plot =
    { plot | attrs = plot.attrs ++ attrs }


margins : Margins -> Plot msg -> Plot msg
margins m plot =
    { plot | margins = m }


addSymbols : Points a b msg -> Scale x a -> Scale y b -> SymbolCreator a b msg -> Plot msg -> Plot msg
addSymbols points xScale yScale pointToSvg plot =
    let
        toSvgHelper =
            \bBox xScaling yScaling ->
                Points.interpolate xScaling yScaling points
                    |> Points.toSvg pointToSvg
    in
    addSvgWithTwoScales toSvgHelper xScale yScale plot


addVerticalBars : Points a b msg -> Scale x a -> Scale y b -> Plot msg -> Plot msg
addVerticalBars points xScale yScale plot =
    addBars points xScale yScale Bars.Vertical plot


addHorizontalBars : Points a b msg -> Scale x a -> Scale y b -> Plot msg -> Plot msg
addHorizontalBars points xScale yScale plot =
    addBars points xScale yScale Bars.Horizontal plot


addAxis : Axis a b msg -> Plot msg -> Plot msg
addAxis axis plot =
    let
        svg =
            \bBox ->
                let
                    scale =
                        if axis.orient == Axis.Top || axis.orient == Axis.Bottom then
                            Scale.rescaleX bBox axis.scale

                        else
                            Scale.rescaleY bBox axis.scale

                    a =
                        { axis
                            | scale = scale
                            , boundingBox = bBox
                        }
                in
                [ AxisView.toSvg a ]
    in
    addSvg svg plot


toSvg : Plot msg -> Svg msg
toSvg plot =
    let
        bBox =
            BoundingBox.from plot.dimensions plot.margins

        plotElements =
            List.concat (List.map (\s -> s bBox) plot.svgs)

        svgs =
            if Title.isEmpty plot.title then
                plotElements

            else
                plotElements ++ [ Title.toSvg plot.title bBox ]
    in
    svg plot.attrs svgs


addBars : Points a b msg -> Scale x a -> Scale y b -> Bars.Orient -> Plot msg -> Plot msg
addBars points xScale yScale orient plot =
    let
        createBar =
            \bBox xScaling yScaling ->
                Bars.interpolate xScaling yScaling points
                    |> Bars.toSvg bBox orient
    in
    addSvgWithTwoScales createBar xScale yScale plot


addSvgWithTwoScales : (BoundingBox -> Scale a b -> Scale c d -> List (Svg msg)) -> Scale a b -> Scale c d -> Plot msg -> Plot msg
addSvgWithTwoScales createSvg xScale yScale plot =
    let
        toSvgWithScales =
            \bBox ->
                createSvg bBox (Scale.rescaleX bBox xScale) (Scale.rescaleY bBox yScale)
    in
    addSvg toSvgWithScales plot


addSvg : (BoundingBox -> List (Svg msg)) -> Plot msg -> Plot msg
addSvg svg plot =
    { plot | svgs = plot.svgs ++ [ svg ] }
