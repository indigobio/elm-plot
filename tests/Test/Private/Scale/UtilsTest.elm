module Test.Private.Scale.UtilsTest where

import Private.Scale.Utils exposing (..)
import ElmTest exposing (..)
import Test.TestUtils.Intervals exposing (assertInterval)
import Private.BoundingBox as BoundingBox
import Private.Extras.Interval as Interval

tests : Test
tests =
  suite "Private.Scale.Utils"
    [ calculateExtentTests ]

calculateExtentTests : Test
calculateExtentTests =
  let
    boundingBox  = BoundingBox.create 5 95 2 97
    interval = Interval.createFromTuple (10, 90)
    descendingInterval = Interval.createFromTuple (90, 10)
    largeInterval = Interval.createFromTuple (0, 100)
    descendingLarge = Interval.createFromTuple (100, 0)
    calculateExtent' = calculateExtent boundingBox
  in
    suite "calculateAxisExtent"
      [ test "for the x axis and a range fits inside the bounding box"
          <| assertInterval (10, 90)
          <| calculateExtent' XScale interval
      , test "for the y axis and a range fits inside the bounding box"
          <| assertInterval (10, 90)
          <| calculateExtent' YScale interval
      , test "for the x axis and a descending range fits inside the bounding box"
          <| assertInterval (90, 10)
          <| calculateExtent' XScale descendingInterval
      , test "for the y axis and a descending range fits inside the bounding box"
          <| assertInterval (90, 10)
          <| calculateExtent' YScale descendingInterval
      , test "for the x axis and a range that does not inside the bounding box"
          <| assertInterval (5, 95)
          <| calculateExtent' XScale largeInterval
      , test "for the y axis and a range that does not inside the bounding box"
          <| assertInterval (2, 97)
          <| calculateExtent' YScale largeInterval
      , test "for the x axis and a descending range that does not inside the bounding box"
          <| assertInterval (95, 5)
          <| calculateExtent' XScale descendingLarge
      , test "for the y axis and a descending range that does not inside the bounding box"
          <| assertInterval (97, 2)
          <| calculateExtent' YScale descendingLarge
      ]
