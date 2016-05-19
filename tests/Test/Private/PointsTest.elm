module Test.Private.PointsTest exposing (..)

import Private.Points exposing (..)
import ElmTest exposing (..)
import Plot.Scale as Scale
import Test.TestUtils.Point exposing (createPoints)


tests : Test
tests =
    suite "Private.Points"
        [ interpolateTests ]


interpolateTests : Test
interpolateTests =
    let
        xScale =
            Scale.linear ( 0, 1 ) ( 0, 1 ) 0

        yScale =
            Scale.linear ( 0, 1 ) ( 0, 1 ) 0

        interpolate' =
            \points -> List.length (interpolate xScale yScale points)
    in
        suite "interpolate"
            [ test "points within the domain of the x and y scale are not filtered out"
                <| assertEqual 2
                <| interpolate' (createPoints [ ( 1, 1 ), ( 0.5, 0.5 ) ])
            , test "points ouside of the x domain are filtered out"
                <| assertEqual 0
                <| interpolate' (createPoints [ ( 1.5, 1 ), ( -1, -1 ) ])
            , test "points ouside of the y domain are filtered out"
                <| assertEqual 0
                <| interpolate' (createPoints [ ( 1, 1.5 ), ( 1, -2 ) ])
            ]
