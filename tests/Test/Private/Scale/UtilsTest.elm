module Test.Private.Scale.UtilsTest exposing (..)

import Expect
import Private.BoundingBox as BoundingBox
import Private.Extras.Interval as Interval
import Private.Scale.Utils exposing (..)
import Test exposing (..)
import Test.TestUtils.Intervals exposing (assertInterval)


tests : Test
tests =
    describe "Private.Scale.Utils"
        [ calculateExtentTests ]


calculateExtentTests : Test
calculateExtentTests =
    let
        boundingBox =
            BoundingBox.create 5 95 2 97

        interval =
            Interval.createFromTuple ( 10, 90 )

        descendingInterval =
            Interval.createFromTuple ( 90, 10 )

        largeInterval =
            Interval.createFromTuple ( 0, 100 )

        descendingLarge =
            Interval.createFromTuple ( 100, 0 )

        calculateExtent_ =
            calculateExtent boundingBox
    in
    describe "calculateAxisExtent"
        [ test "for the x axis and a range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 10, 90 ) <|
                    calculateExtent_ XScale interval
        , test "for the y axis and a range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 10, 90 ) <|
                    calculateExtent_ YScale interval
        , test "for the x axis and a descending range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 90, 10 ) <|
                    calculateExtent_ XScale descendingInterval
        , test "for the y axis and a descending range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 90, 10 ) <|
                    calculateExtent_ YScale descendingInterval
        , test "for the x axis and a range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 5, 95 ) <|
                    calculateExtent_ XScale largeInterval
        , test "for the y axis and a range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 2, 97 ) <|
                    calculateExtent_ YScale largeInterval
        , test "for the x axis and a descending range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 95, 5 ) <|
                    calculateExtent_ XScale descendingLarge
        , test "for the y axis and a descending range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 97, 2 ) <|
                    calculateExtent_ YScale descendingLarge
        ]
