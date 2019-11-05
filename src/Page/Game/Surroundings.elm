module Page.Game.Surroundings exposing (view)

import Element exposing (Element, paragraph, text)
import Item exposing (Item)
import Room exposing (Room, itemsThatCanBeUsed, roomInfo)


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
        { surroundings, surroundingsWhenItemPickedUp, surroundingsWhenItemUsed, item } =
            roomInfo room
    in
    paragraph []
        [ text <|
            case itemsThatCanBeUsed room of
                Just items ->
                    case surroundingsWhenItemUsed of
                        Just itemUsedSurroundings ->
                            if List.any (\x -> List.member x itemsUsed) items then
                                itemUsedSurroundings

                            else
                                surroundings

                        Nothing ->
                            surroundings

                Nothing ->
                    if roomHasItem && itemHasBeenPickedUp item inventory itemsUsed then
                        case surroundingsWhenItemPickedUp of
                            Just itemPickedUpSurroundings ->
                                itemPickedUpSurroundings

                            Nothing ->
                                surroundings

                    else
                        surroundings
        ]
