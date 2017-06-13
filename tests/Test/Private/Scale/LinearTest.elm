module Test.Private.Scale.LinearTest exposing (..)

import Private.Scale.Linear exposing (..)
import Test exposing (..)
import Expect
import Private.Extras.Interval as Interval


tests : Test
tests =
    describe "Private.Scale.Linear"
        [ interpolateTests
        , uninterpolateTests
        , createTicksTests
        , inDomainTests
        ]


interpolateTests : Test
interpolateTests =
    let
        range =
            ( 0, 16 )

        interpolate_ =
            \d r v ->
                interpolate (Interval.createFromTuple d) (Interval.createFromTuple r) v
    in
        describe "interpolate"
            [ test "for a regular domain" <|
                \_ ->
                    (interpolate_ ( 0, 1 ) range 0.25).value
                        |> Expect.equal (4)
            , test "for a reverse domain" <|
                \_ ->
                    (interpolate_ ( -1, 0 ) range -0.25).value
                        |> Expect.equal (12)
            , test "when the min and max of the domain is equal" <|
                \_ ->
                    (interpolate_ ( 1, 1 ) range 2).value
                        |> Expect.equal (0)
            , test "the band width is always 0" <|
                \_ ->
                    (interpolate_ ( 0, 1 ) range 0.25).width
                        |> Expect.equal (0)
            ]


uninterpolateTests : Test
uninterpolateTests =
    let
        domain =
            ( 0, 1 )

        uninteropolate_ =
            \d r v ->
                uninterpolate (Interval.createFromTuple d) (Interval.createFromTuple r) v
    in
        describe "uninterpolate"
            [ test "for a regular domain" <|
                \_ ->
                    uninteropolate_ domain ( 0, 16 ) 4
                        |> Expect.equal (0.25)
            , test "for a reverse domain" <|
                \_ ->
                    uninteropolate_ domain ( 16, 0 ) 12
                        |> Expect.equal (0.25)
            , test "when the min and max of the range is equal" <|
                \_ ->
                    uninteropolate_ domain ( 16, 16 ) 2
                        |> Expect.equal (0)
            ]


createTicksTests : Test
createTicksTests =
    let
        range =
            ( 0, 10 )

        createTicks_ =
            \num d r ->
                createTicks num (Interval.createFromTuple d) (Interval.createFromTuple r)
    in
        describe "createTicks"
            [ test "for a regular domain and 1 tick" <|
                \_ ->
                    List.map .position (createTicks_ 1 ( 0, 1 ) range)
                        |> Expect.equal ([ 0, 10 ])
            , test "for a regular domain and 2 ticks" <|
                \_ ->
                    List.map .position (createTicks_ 2 ( 0, 1 ) range)
                        |> Expect.equal ([ 0, 5, 10 ])
            , test "for a regular domain and 5 ticks" <|
                \_ ->
                    List.map .position (createTicks_ 5 ( 0, 1 ) range)
                        |> Expect.equal ([ 0, 2, 4, 6, 8, 10 ])
            , test "for a regular domain and 10 ticks" <|
                \_ ->
                    List.map .position (createTicks_ 10 ( 0, 1 ) range)
                        |> Expect.equal (List.map toFloat <| List.range 0 10)
            , test "for a reverse domain and 1 tick" <|
                \_ ->
                    List.map .position (createTicks_ 1 ( 1, 0 ) range)
                        |> Expect.equal ([ 10, 0 ])
            , test "for a reverse domain and 2 ticks" <|
                \_ ->
                    List.map .position (createTicks_ 2 ( 1, 0 ) range)
                        |> Expect.equal ([ 10, 5, 0 ])
            , test "for a reverse domain and 5 ticks" <|
                \_ ->
                    List.map .position (createTicks_ 5 ( 1, 0 ) range)
                        |> Expect.equal ([ 10, 8, 6, 4, 2, 0 ])
            , test "for a reverse domain and 10 ticks" <|
                \_ ->
                    List.map .position (createTicks_ 10 ( 1, 0 ) range)
                        |> Expect.equal (List.map toFloat <| List.reverse <| List.range 0 10)
            , test "for a larger domain when no rounding should take place" <|
                \_ ->
                    List.map .position (createTicks_ 10 ( 0, 400 ) ( 70, 330 ))
                        |> Expect.equal ([ 70, 102.5, 135, 167.5, 200, 232.5, 265, 297.5, 330 ])
            ]


inDomainTests : Test
inDomainTests =
    let
        inDomain_ =
            \d v ->
                inDomain (Interval.createFromTuple d) v
    in
        describe "inDomain"
            [ test "in the domain for an ascending domain" <|
                \_ ->
                    inDomain_ ( 0, 1 ) 0.5
                        |> Expect.equal (True)
            , test "less than the min of domain for an ascending domain" <|
                \_ ->
                    inDomain_ ( 0, 1 ) -1
                        |> Expect.equal (False)
            , test "greater than the max of domain for an ascending domain" <|
                \_ ->
                    inDomain_ ( 0, 1 ) 2
                        |> Expect.equal (False)
            , test "in the domain for an descending domain" <|
                \_ ->
                    inDomain_ ( 1, 0 ) 0.5
                        |> Expect.equal (True)
            , test "less than the min of domain for an descending domain" <|
                \_ ->
                    inDomain_ ( 1, 0 ) -1
                        |> Expect.equal (False)
            , test "greater than the max of domain for an descending domain" <|
                \_ ->
                    inDomain_ ( 1, 0 ) 2
                        |> Expect.equal (False)
            , test "equal to the min or max of the domain" <|
                \_ ->
                    List.map (inDomain_ ( 1, 0 )) [ 0, 1 ]
                        |> Expect.equal ([ True, True ])
            ]
