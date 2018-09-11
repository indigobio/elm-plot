module Test.Private.Scale.OrdinalBandsTest exposing (..)

import Dict exposing (Dict)
import Expect
import Private.Extras.Interval as Interval
import Private.Scale.OrdinalBands exposing (..)
import Test exposing (..)
import Test.TestUtils.Ordinal exposing (expectedInterpolation, expectedMapping, expectedTicks)


tests : Test
tests =
    describe "Private.Scale.OrdinalBands"
        [ createMappingTests
        , interpolateTests
        , uninterpolateTests
        , ticksTests
        , inDomainTests
        ]


createMappingTests : Test
createMappingTests =
    let
        domain =
            [ "a", "b", "c" ]

        range =
            Interval.createFromTuple ( 0, 120 )

        expected =
            expectedMapping domain
    in
    describe "createMapping"
        [ test "without any paddings" <|
            \_ ->
                Dict.toList (createMapping 0 0 domain range).lookup
                    |> Expect.equal (expected 40 [ 0, 40, 80 ])
        , test "with a padding set" <|
            \_ ->
                Dict.toList (createMapping 0.2 0.2 domain range).lookup
                    |> Expect.equal (expected 30 [ 7.5, 45, 82.5 ])
        , test "with a padding and a different outer padding set" <|
            \_ ->
                Dict.toList (createMapping 0.2 0.1 domain range).lookup
                    |> Expect.equal (expected 32 [ 4, 44, 84 ])
        , test "with a descending range" <|
            \_ ->
                Dict.toList (createMapping 0.2 0.2 domain (Interval.createFromTuple ( 120, 0 ))).lookup
                    |> Expect.equal (expected 30 [ 82.5, 45, 7.5 ])
        ]


interpolateTests : Test
interpolateTests =
    let
        domain =
            [ "a", "b", "c" ]

        range =
            Interval.createFromTuple ( 0, 120 )

        expected =
            expectedInterpolation domain
    in
    describe "interpolate"
        [ test "for inputs inside the domain" <|
            \_ ->
                List.map (interpolate (createMapping 0 0) domain range) domain
                    |> Expect.equal (expected 40 [ 0, 40, 80 ])
        , test "for inputs not in the domain" <|
            \_ ->
                interpolate (createMapping 0 0) domain range "d"
                    |> Expect.equal { value = 0, width = 0, originalValue = "d" }
        ]


uninterpolateTests : Test
uninterpolateTests =
    let
        domain =
            [ "a", "b", "c" ]

        range =
            Interval.createFromTuple ( 0, 120 )

        expected =
            expectedInterpolation domain
    in
    describe "uninterpolate"
        [ test "for inputs that match excatly to a domain value" <|
            \_ ->
                List.map (uninterpolate (createMapping 0 0) domain range) [ 0, 40, 80 ]
                    |> Expect.equal domain
        , test "for inputs that are close to a domain value" <|
            \_ ->
                List.map (uninterpolate (createMapping 0 0) domain range) [ -1, 45, 95 ]
                    |> Expect.equal domain
        , test "for inputs that are exactly in between two domain values" <|
            \_ ->
                uninterpolate (createMapping 0 0) domain range 20
                    |> Expect.equal "a"
        ]


ticksTests : Test
ticksTests =
    let
        domain =
            [ "a", "b", "c" ]

        range =
            Interval.createFromTuple ( 0, 120 )
    in
    describe "ticks"
        [ test "it creates ticks for the given mapping in the middle of the bands" <|
            \_ ->
                createTicks (createMapping 0 0) domain range
                    |> Expect.equal (expectedTicks [ 20, 60, 100 ] domain)
        ]


inDomainTests : Test
inDomainTests =
    describe "inDomain"
        [ test "for a value that is in the list of strings for the domain" <|
            \_ ->
                inDomain [ "a" ] "a"
                    |> Expect.equal True
        , test "for a value that is not in the list of strings for the domain" <|
            \_ ->
                inDomain [ "a" ] "b"
                    |> Expect.equal False
        ]
