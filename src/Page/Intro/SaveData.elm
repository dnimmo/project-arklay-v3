module Page.Intro.SaveData exposing (Model, decoder, initialModel, processSaveData)

import Item
import Json.Decode as Decode exposing (Decoder, list, maybe, string)
import Json.Decode.Pipeline exposing (optional, required)
import Page.Game exposing (gameStateFromString)
import Room exposing (roomInfo)


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


processSaveData : Model -> Page.Game.Model
processSaveData saveData =
    { inventory = saveData.inventory |> List.map Item.fromString
    , itemsUsed = saveData.itemsUsed |> List.map Item.fromString
    , messageDisplayed = saveData.messageDisplayed
    , room = Room.fromRoomName saveData.room
    , state = gameStateFromString saveData.state
    }
