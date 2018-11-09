module Test.Plot.InterpolationTest exposing (linearTests, tests)

import Expect
import Plot.Interpolation exposing (..)
import Test exposing (..)
import Test.TestUtils.Point exposing (createPoints)


tests : Test
tests =
    describe "Plot.Interpolation"
        [ linearTests ]


linearTests : Test
linearTests =
    describe "linear"
        [ test "for zero points" <|
            \_ ->
                linear []
                    |> Expect.equal ""
        , test "for one point" <|
            \_ ->
                linear (createPoints [ ( 1, 2 ) ])
                    |> Expect.equal "1,2Z"
        , test "for more than one point" <|
            \_ ->
                linear (createPoints [ ( 1, 2 ), ( 3, 4 ) ])
                    |> Expect.equal "1,2L3,4"
        ]
