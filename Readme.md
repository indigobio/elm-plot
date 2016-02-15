# elm-plots
elm-plots is a plotting framework built entirely in elm using svgs. It draws inspiration from [d3](https://github.com/mbostock/d3) and [vega](https://github.com/vega/vega). Its goal is to make drawing visuals such as plots and charts easy to do. 

## Plots
A plot consists of top level attributes, scales, and visual elements. To make it easy to build up a plot, its functions are setup in a way to chain together updating and adding to it using the [forward function applicator](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Basics#|). For example a bar chart with vertical bars without axes can be created with the following elm code: 

```elm
import Svg exposing (Svg)
import Plot exposing (..)
import Plot.Scale as Scale

main : Svg
main =
  let
    xScale = Scale.ordinalBands ["a", "b", "c", "d"] (0, 800) 0 0
    yScale = Scale.linear (0, 400) (800, 0) 0
  in
    createPlot 800 800
      |> addVerticalBars points .x .y xScale yScale []
      |> toSvg

points : List { x : String, y : Float }
points =
  [ {x = "a", y = 10}
  , {x = "b", y = 50}
  , {x = "c", y = 100}
  , {x = "d", y = 400}
  , {x = "e", y = 150}
  ]
```

### Top level attributes
Top level attributes include things like dimensions, margins, title, etc. The only information that is needed to initially create a plot is its dimensions. The rest have defaults that can be overridden as needed.

### Scales
Scales tell how to position your visual elements in a plot. All scales are given an input (domain) and an output (range). The domain is dependent on the type of scale. The range is the range in pixels that you would like your inputs mapped to. Scales are also in charge of creating the locations for ticks for an axis. This is because the tick placement for an axis is dependent on the given scale. Information needed creating ticks varies from scale to scale. As an example, a linear scale can be created with the following: 

```elm
import Plot.Scale as Scale

Scale.linear (0, 400) (0, 800) 10
```

This creates a linear scale that handles inputted floats from 0 to 400 and maps those values to a pixel values from 0 to 800. If this scale is added to a axis with ticks then 10 ticks will be created. 

### Visual elements
These are added to the plot and drawn in the order they were added. This allows control of what overlaps what in your plot. Do you want your bars to overlap your lines? Then add the lines before you add the bars to the plot.

All visual elements require some type of data so the framework knows where to draw them at. Instead of forcing you to shape your data in a way that framework understands, you can pass in whatever data necessary to create it with and then provide functions to tell the framework what is what. For example to draw bars an x and y is needed. This data and functions to provide it can be used like the following: 

```
createPlot 100 100
  |> addVerticalBars bars .year .value xScale yScale []

bars = 
  [ {year = "2016", value = 10}
  , {year = "2017", value = 15}
  ]
```

All visual elements also take in additional svg attributes that will be applied to them. This allows you to provide additional styles or events to be added to whatever you want. [elm-svg](http://package.elm-lang.org/packages/evancz/elm-svg/latest) provides a comprehensive list of the attributes and events than can be provided. 

# Examples
Examples on how to create and use elm-plots are included in the `examples` folder. To run these examples checkout this repository, install the dependencies, start `elm-reactor`, and then navigate to the examples in the browser. 

```
elm package install -y 
elm reactor 
# then navigate to http://localhost:8000/examples/ in a browser to see all examples in action
```

# Tests
Unit tests are written for logic other than the outputted svgs using [elm-test](https://github.com/deadfoxygrandpa/elm-test). 

Test can be ran by:

```
tests/run-tests.sh
```
