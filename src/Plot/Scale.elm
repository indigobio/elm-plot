module Plot.Scale where

import Private.Scale.Linear as LinearScale
import Private.Scale.OrdinalBands as OrdinalBands
import Private.Extras.Set as Set exposing (Set)
import Private.Scale exposing (Scale)

type alias LinearScale = Scale Set Float
type alias OrdinalScale = Scale (List String) String

linear : (Float, Float) -> (Float, Float) -> Int -> LinearScale
linear domain range numTicks =
  { domain = Set.createFromTuple domain
  , range = Set.createFromTuple range
  , interpolate = LinearScale.interpolate
  , uninterpolate = LinearScale.uninterpolate
  , createTicks = LinearScale.createTicks numTicks
  , inDomain = LinearScale.inDomain
  }

ordinalBands : List String -> (Float, Float) -> Float -> Float -> OrdinalScale
ordinalBands domain range padding outerPadding =
  let
    mapping = OrdinalBands.createMapping padding outerPadding
  in
    { domain = domain
    , range = Set.createFromTuple range
    , interpolate = OrdinalBands.interpolate mapping
    , uninterpolate = OrdinalBands.uninterpolate mapping
    , createTicks = OrdinalBands.createTicks mapping
    , inDomain = OrdinalBands.inDomain
    }