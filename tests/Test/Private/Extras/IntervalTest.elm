module Test.Private.Extras.IntervalTest exposing (..)

import Private.Extras.Interval as Interval exposing (..)
import Test exposing (..)
import Expect
import Test.TestUtils.Intervals exposing (assertInterval)


tests : Test
tests =
    describe "Private.Extras.Interval"
        [ extentOfTests ]


extentOfTests : Test
extentOfTests =
    describe "extentOf"
        [ test "for a interval" <|
            \_ ->
                assertInterval ( 0, 1 ) <|
                    extentOf <|
                        createFromTuple ( 0, 1 )
        , test "for a reversed interval" <|
            \_ ->
                assertInterval ( 0, 1 ) <|
                    extentOf <|
                        createFromTuple ( 1, 0 )
        ]
