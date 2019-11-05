port module Ports exposing (deleteSaveData, gameLoaded, loadGame, saveGame)

import Json.Decode exposing (Value)


type alias SaveData =
    { inventory : List String
    , itemsUsed : List String
    , messageDisplayed : Maybe String
    , room : String
    , state : String
    }



-- OUTGOING


port saveGame : SaveData -> Cmd msg


port deleteSaveData : () -> Cmd msg


port loadGame : SaveData -> Cmd msg



-- INCOMING


port gameLoaded : (Value -> msg) -> Sub msg
