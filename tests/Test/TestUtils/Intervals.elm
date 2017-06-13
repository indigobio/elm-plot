module Test.TestUtils.Intervals exposing (..)

import Expect
import Private.Extras.Interval as Interval exposing (..)


assertInterval : ( Float, Float ) -> Interval -> Expect.Expectation
assertInterval tuple =
    Expect.equal (createFromTuple tuple)
