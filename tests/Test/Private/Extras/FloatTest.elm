module Test.Private.Extras.FloatTest exposing (lnTests, roundTests, tests)

import Expect
import Private.Extras.Float exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Private.Extras.Float"
        [ lnTests
        , roundTests
        ]


lnTests : Test
lnTests =
    describe "ln"
        [ test "ln of anything < 0" <|
            \_ -> Expect.true "Expected ln 0 to be infinite." (isInfinite (ln 0))
        , test "ln 1 = 0" <|
            \_ ->
                ln 1
                    |> Expect.equal 0
        , test "greater than 0 and != 1" <|
            \_ ->
                roundTo (ln 5) 3
                    |> Expect.equal 1.609
        ]


roundTests : Test
roundTests =
    describe "roundTo"
        [ test "rounding float with no decimal places" <|
            \_ ->
                roundTo 3 0
                    |> Expect.equal 3
        , test "rounding float with more decimal places than it has" <|
            \_ ->
                roundTo 3.1 2
                    |> Expect.equal 3.1
        , test "rounding float down" <|
            \_ ->
                roundTo 3.14159 2
                    |> Expect.equal 3.14
        , test "rounding float up" <|
            \_ ->
                roundTo 3.14159 3
                    |> Expect.equal 3.142
        , test "when given a negative number returns the number" <|
            \_ ->
                roundTo 3 -1
                    |> Expect.equal 3
        ]
