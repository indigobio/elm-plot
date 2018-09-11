module Test.Private.BoundingBoxTest exposing (..)

import Expect
import Private.BoundingBox as BoundingBox
import Private.Dimensions as Dimensions
import Test exposing (..)


tests : Test
tests =
    describe "Private.BoundingBox"
        [ fromTests ]


fromTests : Test
fromTests =
    let
        dims =
            Dimensions.create 100 50
    in
    describe "from"
        [ test "with margins that are not too large" <|
            \_ ->
                BoundingBox.from dims { left = 30, right = 40, top = 10, bottom = 20 }
                    |> Expect.equal (BoundingBox.create 30 60 10 30)
        , test "horizontal margins that are too large" <|
            \_ ->
                BoundingBox.from dims { left = 60, right = 45, top = 10, bottom = 20 }
                    |> Expect.equal (BoundingBox.create 0 0 0 0)
        , test "vertical margins that are too large" <|
            \_ ->
                BoundingBox.from dims { left = 30, right = 40, top = 30, bottom = 40 }
                    |> Expect.equal (BoundingBox.create 0 0 0 0)
        ]
