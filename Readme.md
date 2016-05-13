# elm-plots
elm-plots is a plotting framework built entirely in elm using svg. It draws inspiration from [d3](https://github.com/mbostock/d3) and [vega](https://github.com/vega/vega). The goal of elm-plots is to make drawing visuals such as plots and charts easy to do.

## Plots
A plot consists of top level attributes, scales, and visual elements. To make it easy to build up a plot, its functions are setup in a way to chain together updating and adding to it using the [forward function applicator](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Basics#|).

### Top Level Attributes
Top level attributes include things like dimensions, margins, title, etc. The only information that is needed to initially create a plot is its dimensions. The rest have defaults that can be overridden as needed.

### Scales
Scales determine how to position your visual elements in a plot. All scales are created with an input (domain) and an output (range). The domain is dependent on the type of scale. For example, a linear scale would have a domain of floats, but an ordinal scale would have a domain of strings. The range is the interval in pixels that you would like your inputs mapped to. Scales are also in charge of creating the locations for ticks for an axis. This is because the tick placement for an axis is dependent on the given scale. Information needed creating ticks varies from scale to scale.

### Visual Elements
Visual Elements are drawn on the plot in they order they are added. This allows you control of what overlaps what in your plot. Do you want your bars to overlap your lines? Then add the lines before you add the bars to the plot.

All visual elements require data so the framework knows where to draw them. Additionally svg attributes can be included along with each piece of data. This allows you to provide additional styles or event handlers for each data point individually. [elm-svg](http://package.elm-lang.org/packages/evancz/elm-svg/latest) provides a comprehensive list of the attributes and event handlers than can be provided.

## Examples
Examples on how to create and use elm-plots are included in the [examples](examples/) folder. To run these examples checkout this repository, install the dependencies, start `elm-reactor`, and then navigate to the examples in the browser.

```
elm package install -y
elm reactor
# then navigate to http://localhost:8000/examples/ in a browser to see all examples in action
```

## Tests
Unit tests are written for logic other than the outputted svg using [elm-test](https://github.com/deadfoxygrandpa/elm-test).

Test can be ran by:

```
tests/run-tests.sh
```
