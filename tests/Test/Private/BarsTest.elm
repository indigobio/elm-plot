module Test.Private.BarsTest exposing (..)

import Expect
import Private.Bars exposing (..)
import Private.BoundingBox as BoundingBox
import Svg.Attributes exposing (height, stroke, width, x, y)
import Test exposing (..)


tests : Test
tests =
    describe "Private.Bars"
        [ barAttrsTests ]


barAttrsTests : Test
barAttrsTests =
    let
        point attrs =
            { x = { value = 50, width = 20, originalValue = 5 }
            , y = { value = 40, width = 10, originalValue = 4 }
            , attrs = attrs
            }

        boundingBox =
            BoundingBox.create 10 90 20 100
    in
    describe "barAttrs"
        [ test "for a top orient" <|
            \_ ->
                barAttrs boundingBox Vertical (point [])
                    |> Expect.equal [ x "50", y "40", width "20", height "60" ]
        , test "for a vertical orient" <|
            \_ ->
                barAttrs boundingBox Horizontal (point [])
                    |> Expect.equal [ x "10", y "40", width "40", height "10" ]
        , test "additional svg attributes can be added to the position attributes" <|
            \_ ->
                barAttrs boundingBox Horizontal (point [ stroke "red" ])
                    |> Expect.equal [ x "10", y "40", width "40", height "10", stroke "red" ]
        ]
