module Test.TestUtils.Intervals where

import ElmTest exposing (..)
import Private.Extras.Interval as Interval exposing (..)

assertInterval : (Float, Float) -> Interval -> Assertion
assertInterval tuple =
  assertEqual (createFromTuple tuple)
