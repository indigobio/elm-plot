module Test.Private.PointsTest exposing (interpolateTests, tests)

import Expect
import Plot.Scale as Scale
import Private.Points exposing (..)
import Test exposing (..)
import Test.TestUtils.Point exposing (createPoints)


tests : Test
tests =
    describe "Private.Points"
        [ interpolateTests ]


interpolateTests : Test
interpolateTests =
    let
        xScale =
            Scale.linear ( 0, 1 ) ( 0, 1 ) 0

        yScale =
            Scale.linear ( 0, 1 ) ( 0, 1 ) 0

        interpolate_ =
            \points -> List.length (interpolate xScale yScale points)
    in
    describe "interpolate"
        [ test "points within the domain of the x and y scale are not filtered out" <|
            \_ ->
                interpolate_ (createPoints [ ( 1, 1 ), ( 0.5, 0.5 ) ])
                    |> Expect.equal 2
        , test "points ouside of the x domain are filtered out" <|
            \_ ->
                interpolate_ (createPoints [ ( 1.5, 1 ), ( -1, -1 ) ])
                    |> Expect.equal 0
        , test "points ouside of the y domain are filtered out" <|
            \_ ->
                interpolate_ (createPoints [ ( 1, 1.5 ), ( 1, -2 ) ])
                    |> Expect.equal 0
        ]
