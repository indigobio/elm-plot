module Test.Private.Extras.IntervalTest exposing (..)

import Private.Extras.Interval as Interval exposing (..)
import ElmTest exposing (..)
import Test.TestUtils.Intervals exposing (assertInterval)


tests : Test
tests =
    suite "Private.Extras.Interval"
        [ extentOfTests ]


extentOfTests : Test
extentOfTests =
    suite "extentOf"
        [ test "for a interval"
            <| assertInterval ( 0, 1 )
            <| extentOf
            <| createFromTuple ( 0, 1 )
        , test "for a reversed interval"
            <| assertInterval ( 0, 1 )
            <| extentOf
            <| createFromTuple ( 1, 0 )
        ]
