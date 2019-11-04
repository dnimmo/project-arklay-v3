port module Ports exposing (deleteSaveData, gameLoaded, loadGame, saveGame)

import Data.SaveData as SaveData
import Json.Decode exposing (Value)



-- OUTGOING


port saveGame : SaveData.Model -> Cmd msg


port deleteSaveData : () -> Cmd msg


port loadGame : SaveData.Model -> Cmd msg



-- INCOMING


port gameLoaded : (Value -> msg) -> Sub msg
