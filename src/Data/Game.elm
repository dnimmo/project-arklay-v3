module Data.Game exposing (GameState(..), Model, initialModel, processSaveData, stateEncoder)

import Data.Item as Item exposing (Item)
import Data.Room as Room exposing (Room)
import Data.SaveData as SaveData
import Json.Decode as Decode exposing (Decoder, list, maybe, string)
import Json.Decode.Pipeline exposing (required)


type alias Model =
    { inventory : List Item
    , itemsUsed : List Item
    , messageDisplayed : Maybe String
    , room : Room
    , state : GameState
    }


initialModel : Model
initialModel =
    { inventory = []
    , itemsUsed = []
    , messageDisplayed = Nothing
    , state = DisplayingDirections
    , room = Room.startingRoom
    }


type GameState
    = DisplayingDirections
    | DisplayingInventory


stateEncoder : GameState -> String
stateEncoder state =
    case state of
        DisplayingDirections ->
            "Displaying directions"

        DisplayingInventory ->
            "Displaying inventory"


gameStateFromString : String -> GameState
gameStateFromString stateString =
    case stateString of
        "Displaying directions" ->
            DisplayingDirections

        "Displaying inventory" ->
            DisplayingInventory

        unknownState ->
            DisplayingDirections


processSaveData : SaveData.Model -> Model
processSaveData saveData =
    { inventory = saveData.inventory |> List.map Item.fromString
    , itemsUsed = saveData.itemsUsed |> List.map Item.fromString
    , messageDisplayed = saveData.messageDisplayed
    , room = Room.fromRoomName saveData.room
    , state = gameStateFromString saveData.state
    }
