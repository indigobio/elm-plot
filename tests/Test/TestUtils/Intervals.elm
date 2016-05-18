module Test.TestUtils.Intervals exposing (..)

import ElmTest exposing (..)
import Private.Extras.Interval as Interval exposing (..)


assertInterval : ( Float, Float ) -> Interval -> Assertion
assertInterval tuple =
    assertEqual (createFromTuple tuple)
