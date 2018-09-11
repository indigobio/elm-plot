module Test.Private.Axis.TitleTest exposing (..)

import Expect
import Plot.Axis as Axis
import Private.Axis.Title exposing (..)
import Private.Extras.Interval as Interval
import Svg.Attributes exposing (stroke, textAnchor, transform, x, y)
import Test exposing (..)


tests : Test
tests =
    describe "Private.Axis.Title"
        [ createTitleTests
        , titleAttrsTests
        ]


createTitleTests : Test
createTitleTests =
    let
        createTitle_ =
            createTitle (Interval.createFromTuple ( 0, 100 )) Axis.Top 0 0 [] Nothing
    in
    describe "createTitle"
        [ test "when a title string is given an svg is created for it" <|
            \_ ->
                List.length (createTitle_ (Just "title"))
                    |> Expect.equal 1
        , test "when no title string is given then nothing is created " <|
            \_ ->
                List.length (createTitle_ Nothing)
                    |> Expect.equal 0
        ]


titleAttrsTests : Test
titleAttrsTests =
    let
        titleAttrs_ =
            titleAttrs (Interval.createFromTuple ( 0, 100 ))
    in
    describe "titleAttrs"
        [ test "for a top orient it places it above the axis" <|
            \_ ->
                titleAttrs_ Axis.Top 1 1 [] Nothing
                    |> Expect.equal [ textAnchor "middle", x "50", y "-32" ]
        , test "for a bottom orient it places it bellow the axis" <|
            \_ ->
                titleAttrs_ Axis.Bottom 1 1 [] Nothing
                    |> Expect.equal [ textAnchor "middle", x "50", y "32" ]
        , test "for a left orient it places it to the left of the axis" <|
            \_ ->
                titleAttrs_ Axis.Left 1 1 [] Nothing
                    |> Expect.equal [ textAnchor "middle", x "-32", y "50", transform "rotate(-90,-32,50)" ]
        , test "for a right orient it places it to the right of the axis" <|
            \_ ->
                titleAttrs_ Axis.Right 1 1 [] Nothing
                    |> Expect.equal [ textAnchor "middle", x "32", y "50", transform "rotate(90,32,50)" ]
        , test "when an offset is given then it is used instead" <|
            \_ ->
                titleAttrs_ Axis.Top 1 1 [] (Just 21)
                    |> Expect.equal [ textAnchor "middle", x "50", y "-21" ]
        , test "it is placed in the middle of the axis" <|
            \_ ->
                titleAttrs (Interval.createFromTuple ( 100, 200 )) Axis.Top 1 1 [] (Just 21)
                    |> Expect.equal [ textAnchor "middle", x "150", y "-21" ]
        , test "additional attrs are appended to the end" <|
            \_ ->
                titleAttrs_ Axis.Top 1 1 [ stroke "red" ] Nothing
                    |> Expect.equal [ textAnchor "middle", x "50", y "-32", stroke "red" ]
        ]
