module Page.Game.Surroundings exposing (view)

import Data.Item exposing (Item)
import Data.Room exposing (Room, roomInfo)
import Element exposing (Element, paragraph, text)


type alias SurroundingsRequirements =
    { room : Room
    , inventory : List Item
    , itemsUsed : List Item
    }


itemHasBeenPickedUp : Maybe Item -> List Item -> List Item -> Bool
itemHasBeenPickedUp item inventory itemsUsed =
    case item of
        Just x ->
            if List.member x inventory || List.member x itemsUsed then
                True

            else
                False

        Nothing ->
            False


view : Bool -> SurroundingsRequirements -> Element msg
view roomHasItem { room, inventory, itemsUsed } =
    let
        { surroundings, surroundingsWhenItemPickedUp, item } =
            roomInfo room
    in
    paragraph []
        [ text <|
            if roomHasItem && itemHasBeenPickedUp item inventory itemsUsed then
                case surroundingsWhenItemPickedUp of
                    Just updatedSurroundings ->
                        updatedSurroundings

                    Nothing ->
                        surroundings

            else
                surroundings
        ]
