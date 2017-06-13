module Test.TestUtils.Point exposing (..)

import Private.Point as Point exposing (Point)


createPoints : List ( Float, Float ) -> List (Point Float Float msg)
createPoints points =
    List.map createPoint points


createPoint : ( Float, Float ) -> Point Float Float msg
createPoint point =
    Point.create (Tuple.first point) (Tuple.second point) []
