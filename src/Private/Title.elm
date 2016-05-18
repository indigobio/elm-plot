module Private.Title exposing (..)

import Svg exposing (svg, Svg, text', text)
import Svg.Attributes exposing (textAnchor)
import Private.Extras.SvgAttributes exposing (x, y)
import Private.BoundingBox exposing (BoundingBox)
import List
import String


type alias Model msg =
    { title : String
    , attrs : List (Svg.Attribute msg)
    }


create : String -> List (Svg.Attribute msg) -> Model msg
create title attrs =
    { title = title
    , attrs = attrs
    }


init : Model msg
init =
    create "" []


isEmpty : Model msg -> Bool
isEmpty title =
    String.isEmpty title.title


toSvg : Model msg -> BoundingBox -> Svg msg
toSvg model bBox =
    let
        titleAttrs =
            if List.isEmpty model.attrs then
                [ textAnchor "middle"
                , x (((bBox.xEnd - bBox.xStart) / 2) + bBox.xStart)
                , y 30
                ]
            else
                model.attrs
    in
        text' titleAttrs
            [ text model.title ]
