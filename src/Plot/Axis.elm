module Plot.Axis exposing (Axis, Orient(..), axisAttributes, create, innerTickAttributes, innerTickSize, labelRotation, outerTickSize, tickPadding, title, titleAttributes, titleOffset)

import Private.BoundingBox as BoundingBox exposing (BoundingBox)
import Private.Scale exposing (Scale)
import Svg
import Svg.Attributes exposing (fill, shapeRendering, stroke)


type Orient
    = Top
    | Bottom
    | Left
    | Right


type alias Axis a b msg =
    { scale : Scale a b
    , orient : Orient
    , boundingBox : BoundingBox
    , innerTickSize : Int
    , outerTickSize : Int
    , tickPadding : Int
    , labelRotation : Int
    , axisAttributes : List (Svg.Attribute msg)
    , innerTickAttributes : List (Svg.Attribute msg)
    , title : Maybe String
    , titleOffset : Maybe Int
    , titleAttributes : List (Svg.Attribute msg)
    }


create : Scale a b -> Orient -> Axis a b msg
create scale orient =
    let
        defaultLineAttrs =
            [ fill "none"
            , stroke "#000"
            ]
    in
    { scale = scale
    , orient = orient
    , boundingBox = BoundingBox.init
    , innerTickSize = 6
    , outerTickSize = 6
    , tickPadding = 3
    , labelRotation = 0
    , axisAttributes = defaultLineAttrs
    , innerTickAttributes = defaultLineAttrs
    , title = Nothing
    , titleOffset = Nothing
    , titleAttributes = []
    }


innerTickSize : Int -> Axis a b msg -> Axis a b msg
innerTickSize size axis =
    { axis | innerTickSize = size }


outerTickSize : Int -> Axis a b msg -> Axis a b msg
outerTickSize size axis =
    { axis | outerTickSize = size }


tickPadding : Int -> Axis a b msg -> Axis a b msg
tickPadding padding axis =
    { axis | tickPadding = padding }


labelRotation : Int -> Axis a b msg -> Axis a b msg
labelRotation rotation axis =
    { axis | labelRotation = rotation }


axisAttributes : List (Svg.Attribute msg) -> Axis a b msg -> Axis a b msg
axisAttributes attrs axis =
    { axis | axisAttributes = attrs }


innerTickAttributes : List (Svg.Attribute msg) -> Axis a b msg -> Axis a b msg
innerTickAttributes attrs axis =
    { axis | innerTickAttributes = attrs }


title : String -> Axis a b msg -> Axis a b msg
title t axis =
    { axis | title = Just t }


titleOffset : Int -> Axis a b msg -> Axis a b msg
titleOffset offset axis =
    { axis | titleOffset = Just offset }


titleAttributes : List (Svg.Attribute msg) -> Axis a b msg -> Axis a b msg
titleAttributes attrs axis =
    { axis | titleAttributes = attrs }
