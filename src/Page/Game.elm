module Page.Game exposing (Model, Msg, initialModel, update, view)

import Data.Item exposing (Item, itemInfo)
import Data.Room as Room exposing (Room, itemsThatCanBeUsed, roomInfo)
import Element exposing (Element, centerX, centerY, column, fill, fillPortion, height, minimum, padding, paragraph, rgb255, row, text, width)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Page.Game.DirectionControls as DirectionControls
import Page.Game.Surroundings as Surroundings
import View.Layout exposing (mainLayout)



-- MODEL


type alias Model =
    { state : State
    , room : Room
    , inventory : List Item
    , itemsUsed : List Item
    , messageDisplayed : Maybe String
    }


type State
    = DisplayingDirections
    | DisplayingInventory


initialModel : Model
initialModel =
    { state = DisplayingDirections
    , room = Room.startingRoom
    , inventory = []
    , itemsUsed = []
    , messageDisplayed = Nothing
    }



-- UPDATE


type Msg
    = ToggleInventory
    | UseItem Item Room
    | ChangeRoom Room
    | ExamineRoom (Maybe Item)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeRoom room ->
            { model
                | room = room
                , messageDisplayed = Nothing
            }

        ExamineRoom item ->
            { model
                | inventory =
                    case item of
                        Just x ->
                            if
                                List.member x model.inventory
                                    || List.member x model.itemsUsed
                            then
                                model.inventory

                            else
                                List.reverse <| x :: model.inventory

                        Nothing ->
                            model.inventory
                , messageDisplayed =
                    case item of
                        Just x ->
                            if
                                List.member x model.inventory
                                    || List.member x model.itemsUsed
                            then
                                Just <| "This is where I found the " ++ (itemInfo x).name

                            else
                                Just <| (itemInfo x).name ++ " has been added to your inventory"

                        Nothing ->
                            Just "Hm, nothing interesting here"
            }

        ToggleInventory ->
            { model
                | state =
                    case model.state of
                        DisplayingDirections ->
                            DisplayingInventory

                        DisplayingInventory ->
                            DisplayingDirections
                , messageDisplayed = Nothing
            }

        UseItem item room ->
            let
                itemCanBeUsed =
                    case itemsThatCanBeUsed room of
                        Just items ->
                            items |> List.member item

                        Nothing ->
                            False

                updatedModel =
                    if itemCanBeUsed then
                        { model
                            | inventory =
                                model.inventory
                                    |> List.filter (\x -> x /= item)
                            , itemsUsed = item :: model.itemsUsed
                            , messageDisplayed = Just (itemInfo item |> .messageWhenUsed)
                            , state = DisplayingDirections
                        }

                    else
                        { model
                            | messageDisplayed = Just (itemInfo item |> .messageWhenNotUsed)
                        }
            in
            updatedModel



-- VIEW


inventoryView : List Item -> Room -> List (Element Msg)
inventoryView inventory room =
    List.map
        (\x ->
            Input.button
                [ width fill
                , Font.center
                , padding 20
                ]
                { onPress =
                    Just <| UseItem x room
                , label = text <| (itemInfo x).name
                }
        )
        inventory


view : Model -> Element Msg
view model =
    let
        { room, inventory, itemsUsed, state, messageDisplayed } =
            model

        { intro, surroundings, item, availableDirections, surroundingsWhenItemPickedUp } =
            roomInfo room

        roomHasItem =
            case item of
                Just _ ->
                    True

                Nothing ->
                    False

        playerHasItems =
            case List.head inventory of
                Just _ ->
                    True

                Nothing ->
                    False
    in
    mainLayout
        [ column
            [ height (fill |> minimum 100)
            , width fill
            ]
            [ row
                [ width fill ]
                [ paragraph [] [ text intro ] ]
            , row
                [ width fill ]
                [ Surroundings.view roomHasItem { inventory = inventory, itemsUsed = itemsUsed, room = room }
                ]
            ]
        , row
            [ Border.solid
            , Border.width 1
            , Border.color <| rgb255 250 250 250
            , width fill
            ]
            [ Element.none ]
        , case state of
            DisplayingDirections ->
                DirectionControls.view availableDirections ChangeRoom itemsUsed

            DisplayingInventory ->
                column
                    [ width fill
                    , height (fill |> minimum 100)
                    ]
                <|
                    inventoryView inventory room
        , if (roomInfo room).name == "Start" then
            Element.none

          else
            column
                [ Font.color <| rgb255 250 250 250
                , padding 50
                , width fill
                , height (fill |> minimum 100)
                ]
                [ case state of
                    DisplayingInventory ->
                        Element.none

                    DisplayingDirections ->
                        column
                            [ Font.color <|
                                case playerHasItems of
                                    True ->
                                        rgb255 250 250 250

                                    False ->
                                        rgb255 100 100 100
                            , width fill
                            ]
                            [ Input.button [ width fill ]
                                { onPress =
                                    case playerHasItems of
                                        True ->
                                            Just ToggleInventory

                                        False ->
                                            Nothing
                                , label = paragraph [] [ text "Inventory" ]
                                }
                            ]
                , case state of
                    DisplayingInventory ->
                        Input.button [ width fill ]
                            { onPress = Just ToggleInventory
                            , label = text "Close inventory"
                            }

                    DisplayingDirections ->
                        Input.button [ width fill ]
                            { onPress =
                                Just <| ExamineRoom item
                            , label = text "Examine room"
                            }
                , paragraph
                    [ height (fill |> minimum 50)
                    ]
                    [ case messageDisplayed of
                        Just message ->
                            text message

                        Nothing ->
                            Element.none
                    ]
                ]
        ]
