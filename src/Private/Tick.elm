module Private.Tick exposing (Tick, create)


type alias Tick =
    { position : Float
    , label : String
    }


create : Float -> String -> Tick
create position label =
    { position = position
    , label = label
    }
