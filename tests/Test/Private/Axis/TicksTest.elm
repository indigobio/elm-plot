module Test.Private.Axis.TicksTest exposing (createTickInfosTests, innerTickLineAttributesTests, labelAttributesTests, tests)

import Expect
import Plot.Axis as Axis
import Plot.Scale as Scale
import Private.Axis.Ticks exposing (..)
import Svg.Attributes exposing (dy, textAnchor, transform, x, x2, y, y2)
import Test exposing (..)


tests : Test
tests =
    describe "Private.Axis.Ticks"
        [ createTickInfosTests
        , innerTickLineAttributesTests
        , labelAttributesTests
        ]


createTickInfosTests : Test
createTickInfosTests =
    let
        scale =
            Scale.linear ( 0, 1 ) ( 0, 10 ) 1
    in
    describe "createTickInfos"
        [ test "for top orient" <|
            \_ ->
                createTickInfos scale Axis.Top
                    |> Expect.equal [ { label = "0", translation = ( 0, 0 ) }, { label = "1", translation = ( 10, 0 ) } ]
        , test "for bottom orient" <|
            \_ ->
                createTickInfos scale Axis.Bottom
                    |> Expect.equal [ { label = "0", translation = ( 0, 0 ) }, { label = "1", translation = ( 10, 0 ) } ]
        , test "for left orient" <|
            \_ ->
                createTickInfos scale Axis.Left
                    |> Expect.equal [ { label = "0", translation = ( 0, 0 ) }, { label = "1", translation = ( 0, 10 ) } ]
        , test "for right orient" <|
            \_ ->
                createTickInfos scale Axis.Right
                    |> Expect.equal [ { label = "0", translation = ( 0, 0 ) }, { label = "1", translation = ( 0, 10 ) } ]
        ]


innerTickLineAttributesTests : Test
innerTickLineAttributesTests =
    describe "innerTickLineAttributes"
        [ test "for top orient" <|
            \_ ->
                innerTickLineAttributes Axis.Top 6
                    |> Expect.equal [ x2 "0", y2 "-6" ]
        , test "for bottom orient" <|
            \_ ->
                innerTickLineAttributes Axis.Bottom 6
                    |> Expect.equal [ x2 "0", y2 "6" ]
        , test "for left orient" <|
            \_ ->
                innerTickLineAttributes Axis.Left 4
                    |> Expect.equal [ x2 "-4", y2 "0" ]
        , test "for right orient" <|
            \_ ->
                innerTickLineAttributes Axis.Right 4
                    |> Expect.equal [ x2 "4", y2 "0" ]
        ]


labelAttributesTests : Test
labelAttributesTests =
    describe "labelAttributes"
        [ test "for top orient" <|
            \_ ->
                labelAttributes Axis.Top 6 0 0
                    |> Expect.equal [ x "0", y "-6", dy "0em", textAnchor "middle" ]
        , test "for bottom orient" <|
            \_ ->
                labelAttributes Axis.Bottom 6 0 0
                    |> Expect.equal [ x "0", y "6", dy ".71em", textAnchor "middle" ]
        , test "for left orient" <|
            \_ ->
                labelAttributes Axis.Left 6 0 0
                    |> Expect.equal [ x "-6", y "0", dy ".32em", textAnchor "end" ]
        , test "for right orient" <|
            \_ ->
                labelAttributes Axis.Right 6 0 0
                    |> Expect.equal [ x "6", y "0", dy ".32em", textAnchor "start" ]
        , test "tick padding is included in the ofset" <|
            \_ ->
                labelAttributes Axis.Right 8 2 0
                    |> Expect.equal [ x "10", y "0", dy ".32em", textAnchor "start" ]
        , test "when rotation is not zero a rotaion transform is included" <|
            \_ ->
                labelAttributes Axis.Right 6 0 25
                    |> Expect.equal [ x "6", y "0", dy ".32em", textAnchor "start", transform "rotate(25,6,0)" ]
        ]
