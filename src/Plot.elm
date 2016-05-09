module Plot where

import Svg exposing (svg, Svg)
import Private.Extras.SvgAttributes exposing (width, height)
import Private.Dimensions exposing (Dimensions)
import Private.Margins as Margins exposing (Margins)
import Private.BoundingBox as BoundingBox exposing (BoundingBox)
import Private.Scale.Utils as Scale
import Private.Scale exposing (Scale)
import Plot.Axis as Axis exposing (Axis)
import Private.Bars as Bars exposing (Orient)
import Private.Axis.View as AxisView
import Private.Title as Title

type alias Plot =
  { dimensions: Dimensions
  , margins: Margins
  , svgs: List (BoundingBox -> List Svg)
  , eventHandlers: List (BoundingBox -> Svg.Attribute)
  , attrs: List Svg.Attribute
  , title : Title.Model
  }

type alias Points a b p =
  List { p | x : a, y : b, attrs : List Svg.Attribute}

createPlot : Float -> Float -> Plot
createPlot w h =
  { dimensions = { width = w, height = h }
  , margins = Margins.init
  , svgs = []
  , eventHandlers = []
  , attrs = [width w, height h]
  , title = Title.init
  }

addTitle : String -> List Svg.Attribute -> Plot -> Plot
addTitle title attrs plot =
  { plot | title = Title.create title attrs }

attributes : List Svg.Attribute -> Plot -> Plot
attributes attrs plot =
  { plot | attrs = plot.attrs ++ attrs }

margins : Margins -> Plot -> Plot
margins m plot =
  { plot | margins = m }

addVerticalBars : Points a b point -> Scale x a -> Scale y b -> Plot -> Plot
addVerticalBars points xScale yScale plot =
  addBars points xScale yScale Bars.Vertical plot

addHorizontalBars : Points a b point -> Scale x a -> Scale y b -> Plot -> Plot
addHorizontalBars points xScale yScale plot =
  addBars points xScale yScale Bars.Horizontal plot

addAxis : Axis a b -> Plot -> Plot
addAxis axis plot =
  let
    svg = \bBox ->
      let
        scale =
          if axis.orient == Axis.Top || axis.orient == Axis.Bottom then
            Scale.rescaleX bBox axis.scale
          else
            Scale.rescaleY bBox axis.scale
        a = { axis
              | scale = scale
              , boundingBox = bBox
            }
      in
        [ AxisView.toSvg a ]
  in
    addSvg svg plot

toSvg : Plot -> Svg
toSvg plot =
  let
    bBox = BoundingBox.from plot.dimensions plot.margins
    plotElements = List.concat (List.map (\s -> s bBox) plot.svgs)
    events = List.map (\s -> s bBox) plot.eventHandlers
    svgs =
      if Title.isEmpty plot.title then
        plotElements
      else
        plotElements ++ [Title.toSvg plot.title bBox]
  in
    svg (plot.attrs ++ events) (svgs)

addBars : Points a b point -> Scale x a -> Scale y b -> Bars.Orient -> Plot -> Plot
addBars points xScale yScale orient plot =
  let
    toSvg = \bBox xScale yScale ->
      List.map (\p -> { x = p.x, y = p.y}) points
        |> Bars.interpolate xScale yScale
        |> Bars.toSvg bBox orient (List.map (\p -> p.attrs) points)
  in
    addSvgWithTwoScales toSvg xScale yScale plot

addSvgWithTwoScales : (BoundingBox -> Scale a b -> Scale c d -> List Svg) -> Scale a b -> Scale c d -> Plot -> Plot
addSvgWithTwoScales toSvg xScale yScale plot =
  let
    toSvgWithScales = \bBox ->
      toSvg bBox (Scale.rescaleX bBox xScale) (Scale.rescaleY bBox yScale)
  in
    addSvg toSvgWithScales plot

addSvg : (BoundingBox -> List Svg) -> Plot -> Plot
addSvg svg plot =
  { plot | svgs = List.append plot.svgs [svg] }
