module Private.Title exposing (..)

import Private.BoundingBox exposing (BoundingBox)
import Private.Extras.SvgAttributes exposing (x, y)
import Svg exposing (Svg, svg, text, text_)
import Svg.Attributes exposing (textAnchor)


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
    text_ titleAttrs
        [ text model.title ]
