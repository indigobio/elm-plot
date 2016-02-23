module Test.Scale.OrdinalPointsTests where

import Scale.OrdinalPoints exposing (..)
import ElmTest exposing (..)

tests : Test
tests =
  suite "Scale.OrdinalPoints"
        [ transformTests
        , ticksTests
        ]

transformTests : Test
transformTests =
  let
    domain = ["a", "b", "c"]
    range = (0, 120)
  in
    suite "transform"
      [ test "for inputs inside the domain"
          <| assertEqual [0, 60, 120] <| List.map (transform (createMapping domain 0) range) domain
      , test "for inputs not in the domain"
          <| assertEqual 0 <| transform (createMapping domain 0) range "d"
      ]

ticksTests : Test
ticksTests =
  let
    domain = ["a", "b", "c"]
    range = (0, 120)
  in
    suite "ticks"
      [ test "without padding"
          <| assertEqual [0, 60, 120] <| List.map .position <| createTicks (createMapping domain 0) range 1
      , test "with a padding"
          <| assertEqual [30, 60, 90] <| List.map .position <| createTicks (createMapping domain 2) range 1
      , test "no ticks are returned for an empty domain"
          <| assertEqual [] <| List.map .position <| createTicks (createMapping [] 0) range 1
      , test "a single item in the input domain is correctly handled"
          <| assertEqual [60] <| List.map .position <| createTicks (createMapping ["a"] 0) range 0
      , test "descending range without padding"
          <| assertEqual [120, 60, 0] <| List.map .position <| createTicks (createMapping domain 0) (120, 0) 1
      , test "descending range with padding"
          <| assertEqual [90, 60, 30] <| List.map .position <| createTicks (createMapping domain 2) (120, 0) 1
      ]
