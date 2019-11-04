module Data.SaveData exposing (Model, decoder, initialModel)

import Data.Room as Room exposing (roomInfo)
import Json.Decode as Decode exposing (Decoder, list, maybe, string)
import Json.Decode.Pipeline exposing (optional, required)


type alias Model =
    { inventory : List String
    , itemsUsed : List String
    , messageDisplayed : Maybe String
    , room : String
    , state : String
    }


initialModel : Model
initialModel =
    { inventory = []
    , itemsUsed = []
    , messageDisplayed = Nothing
    , room = roomInfo Room.startingRoom |> .name
    , state = "Displaying directions"
    }


decoder : Decoder Model
decoder =
    Decode.succeed Model
        |> required "inventory" (list string)
        |> required "itemsUsed" (list string)
        |> optional "messageDisplayed" (maybe string) Nothing
        |> required "room" string
        |> required "state" string
