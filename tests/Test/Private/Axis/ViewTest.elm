module Test.Private.Axis.ViewTest exposing (..)

import Expect
import Plot.Axis as Axis
import Plot.Scale as Scale exposing (LinearScale)
import Private.Axis.View exposing (..)
import Private.BoundingBox as BoundingBox exposing (BoundingBox)
import Private.Extras.Interval as Interval
import Svg.Attributes exposing (transform)
import Test exposing (..)
import Test.TestUtils.Intervals exposing (assertInterval)


tests : Test
tests =
    describe "Private.Axis.View"
        [ calculateAxisExtentTests
        , axisTranslationTests
        , pathStringTests
        ]


calculateAxisExtentTests : Test
calculateAxisExtentTests =
    let
        boundingBox =
            BoundingBox.create 5 95 2 97

        range =
            Interval.createFromTuple ( 10, 90 )

        descendingRange =
            Interval.createFromTuple ( 90, 10 )

        largeRange =
            Interval.createFromTuple ( 0, 100 )

        largeDescending =
            Interval.createFromTuple ( 100, 0 )

        calculateExtent_ =
            calculateAxisExtent boundingBox
    in
    describe "calculateAxisExtent"
        [ test "for the x axis and a range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 10, 90 ) <|
                    calculateExtent_ Axis.Top range
        , test "for bottom orient and a range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 10, 90 ) <|
                    calculateExtent_ Axis.Bottom range
        , test "for left orient and a range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 10, 90 ) <|
                    calculateExtent_ Axis.Left range
        , test "for right orient and a range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 10, 90 ) <|
                    calculateExtent_ Axis.Right range
        , test "for the x axis and a descending range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 10, 90 ) <|
                    calculateExtent_ Axis.Top descendingRange
        , test "for bottom orient and a descending range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 10, 90 ) <|
                    calculateExtent_ Axis.Bottom descendingRange
        , test "for left orient and a descending range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 10, 90 ) <|
                    calculateExtent_ Axis.Left descendingRange
        , test "for right orient and a descending range fits inside the bounding box" <|
            \_ ->
                assertInterval ( 10, 90 ) <|
                    calculateExtent_ Axis.Right descendingRange
        , test "for the x axis and a range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 5, 95 ) <|
                    calculateExtent_ Axis.Top largeRange
        , test "for bottom orient and a range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 5, 95 ) <|
                    calculateExtent_ Axis.Bottom largeRange
        , test "for left orient and a range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 2, 97 ) <|
                    calculateExtent_ Axis.Left largeRange
        , test "for right orient and a range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 2, 97 ) <|
                    calculateExtent_ Axis.Right largeRange
        , test "for the x axis and a descending range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 5, 95 ) <|
                    calculateExtent_ Axis.Top largeDescending
        , test "for bottom orient and a descending range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 5, 95 ) <|
                    calculateExtent_ Axis.Bottom largeDescending
        , test "for left orient and a descending range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 2, 97 ) <|
                    calculateExtent_ Axis.Left largeDescending
        , test "for right orient and a descending range that does not inside the bounding box" <|
            \_ ->
                assertInterval ( 2, 97 ) <|
                    calculateExtent_ Axis.Right largeDescending
        ]


axisTranslationTests : Test
axisTranslationTests =
    describe "axisTranslation"
        [ test "for top orient" <|
            \_ ->
                axisTranslation boundingBox Axis.Top
                    |> Expect.equal (transform "translate(0,2)")
        , test "for bottom orient" <|
            \_ ->
                axisTranslation boundingBox Axis.Bottom
                    |> Expect.equal (transform "translate(0,100)")
        , test "for left orient" <|
            \_ ->
                axisTranslation boundingBox Axis.Left
                    |> Expect.equal (transform "translate(5,0)")
        , test "for right orient" <|
            \_ ->
                axisTranslation boundingBox Axis.Right
                    |> Expect.equal (transform "translate(95,0)")
        ]


pathStringTests : Test
pathStringTests =
    describe "pathString"
        [ test "for top orient" <|
            \_ ->
                pathString boundingBox scale Axis.Top 6
                    |> Expect.equal "M10,-6V0H90V-6"
        , test "for bottom orient" <|
            \_ ->
                pathString boundingBox scale Axis.Bottom 6
                    |> Expect.equal "M10,6V0H90V6"
        , test "for left orient" <|
            \_ ->
                pathString boundingBox scale Axis.Left 6
                    |> Expect.equal "M-6,10H0V90H-6"
        , test "for right orient" <|
            \_ ->
                pathString boundingBox scale Axis.Right 6
                    |> Expect.equal "M6,10H0V90H6"
        , test "for a scale that does not fit inside the x boundings" <|
            \_ ->
                pathString boundingBox (Scale.linear ( 0, 105 ) ( 0, 105 ) 1) Axis.Top 6
                    |> Expect.equal "M5,-6V0H95V-6"
        , test "for a scale that does not fit inside the y boundings" <|
            \_ ->
                pathString boundingBox (Scale.linear ( 0, 105 ) ( 0, 105 ) 1) Axis.Left 6
                    |> Expect.equal "M-6,2H0V100H-6"
        , test "for x axis with a descending scale that does not fit inside the x boundings" <|
            \_ ->
                pathString boundingBox (Scale.linear ( 0, 105 ) ( 105, 0 ) 1) Axis.Top 6
                    |> Expect.equal "M5,-6V0H95V-6"
        , test "for y axis with a descending scale that does not fit inside the y boundings" <|
            \_ ->
                pathString boundingBox (Scale.linear ( 0, 105 ) ( 105, 0 ) 1) Axis.Left 6
                    |> Expect.equal "M-6,2H0V100H-6"
        , test "for a non-default tick size" <|
            \_ ->
                pathString boundingBox scale Axis.Top 8
                    |> Expect.equal "M10,-8V0H90V-8"
        ]


scale : LinearScale
scale =
    Scale.linear ( 10, 90 ) ( 10, 90 ) 1


boundingBox : BoundingBox
boundingBox =
    BoundingBox.create 5 95 2 100
