module Private.Scale where

import Private.Extras.Interval as Interval exposing (Interval)
import Private.Tick exposing (Tick)
import Private.PointValue exposing (PointValue)

type alias Scale a b =
  { domain : a
  , range : Interval
  , interpolate : (a -> Interval -> b -> PointValue b)
  , uninterpolate : (a -> Interval -> Float -> b)
  , createTicks : (a -> Interval -> List Tick)
  , inDomain : (a -> b -> Bool)
  }
