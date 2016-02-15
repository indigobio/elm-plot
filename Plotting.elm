module Plotting where

import Html exposing (Html)
import Plot exposing (..)
import Plot exposing (..)
import Line.InterpolationModes exposing (linear)
import Scale
import Point exposing (Point)

main : Html
main =
  createPlot 400 400
    |> addPoints points
    |> addLines linear lines
    |> addXScale (Scale.linear (0, 100) (0, 400))
    |> addYScale (Scale.linear (0, 100) (400, 0))
    |> toHtml

-- type alias Point' = {x : Float, y : Float, z : Float}

points : List Point
points =
  -- [ {x = 10, y = 10, z = 1}
  -- , {x = 50, y = 50, z = 1}
  -- , {x = 100, y = 100, z = 1}
  -- , {x = 200, y = 200, z = 1}
  -- , {x = 300, y = 300, z = 1}
  -- , {x = 400, y = 500, z = 1}
  -- ]
  [ {x = 10, y = 10}
  , {x = 50, y = 50}
  , {x = 100, y = 100}
  , {x = 200, y = 200}
  , {x = 300, y = 300}
  , {x = 400, y = 500}
  ]

lines : List Point
lines =
  -- [ { x =  1,   y =  5, z = 1}
  -- , { x =  20,  y =  20, z = 1}
  -- , { x =  40,  y =  10, z = 1}
  -- , { x =  60,  y =  40, z = 1}
  -- , { x =  80,  y =  5, z = 1}
  -- , { x =  100, y =  60, z = 1}
  -- ]
  [ { x =  1,   y =  5}
  , { x =  20,  y =  20}
  , { x =  40,  y =  10}
  , { x =  60,  y =  40}
  , { x =  80,  y =  5}
  , { x =  100, y =  60}
  ]
