module Private.Tick exposing (..)


type alias Tick =
    { position : Float
    , label : String
    }


create : Float -> String -> Tick
create position label =
    { position = position
    , label = label
    }
