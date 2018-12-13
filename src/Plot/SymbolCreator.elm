module Plot.SymbolCreator exposing (SymbolCreator)

import Svg exposing (Svg)


type alias SymbolCreator a b msg =
    Float -> Float -> a -> b -> List (Svg.Attribute msg) -> Svg msg
