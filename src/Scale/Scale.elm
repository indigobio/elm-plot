module Scale.Scale where

import Private.Models exposing (PointValue, Tick)
import Sets exposing (Range)

type alias Scale a =
  { range : Range
  , interpolate : (Range -> a -> PointValue a)
  , createTicks : (Range -> List Tick)
  }
