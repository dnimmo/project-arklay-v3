module Page.Game exposing (Model, Msg, initialModel, update, view)

import Data.Item exposing (Item, itemInfo)
import Data.Room as Room exposing (Room(..), roomInfo)
import Element exposing (Element, centerX, centerY, column, fill, fillPortion, padding, paragraph, rgb255, row, spacing, text, width, wrappedRow)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Page.Game.DirectionControls as DirectionControls
import Page.Game.Surroundings as Surroundings
import View.Layout exposing (mainLayout)



-- MODEL


type alias Model =
    { room : Room
    , inventory : List Item
    , itemsUsed : List Item
    , displayInventory : Bool
    , messageDisplayed : Maybe String
    }


initialModel : Model
initialModel =
    { room = Room.startingRoom
    , inventory = []
    , itemsUsed = []
    , displayInventory = False
    , messageDisplayed = Nothing
    }



-- UPDATE


type Msg
    = ToggleInventory
    | UseItem
    | ChangeRoom Room
    | ExamineRoom (Maybe Item)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleInventory ->
            ( { model
                | displayInventory = not model.displayInventory
                , messageDisplayed = Nothing
              }
            , Cmd.none
            )

        ChangeRoom room ->
            ( { model
                | room = room
                , messageDisplayed = Nothing
              }
            , Cmd.none
            )

        ExamineRoom item ->
            ( { model
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
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )



-- VIEW


inventoryView : List Item -> List (Element Msg)
inventoryView inventory =
    List.map (\x -> itemInfo x |> .name |> text) inventory


view : Model -> Element Msg
view model =
    let
        { room, inventory, itemsUsed, displayInventory, messageDisplayed } =
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
        [ row
            [ width fill ]
            [ paragraph [] [ text intro ] ]
        , row
            [ width fill ]
            [ Surroundings.view roomHasItem { inventory = inventory, itemsUsed = itemsUsed, room = room }
            ]
        , row
            [ Border.solid
            , Border.width 1
            , Border.color <| rgb255 250 250 250
            , width fill
            ]
            [ Element.none ]
        , DirectionControls.view availableDirections ChangeRoom
        , if (roomInfo room).name == "Start" then
            Element.none

          else
            column
                [ centerX
                , Font.color <| rgb255 250 250 250
                ]
                [ case displayInventory of
                    True ->
                        column [] <|
                            inventoryView inventory

                    False ->
                        column
                            [ Font.color <|
                                case playerHasItems of
                                    True ->
                                        rgb255 250 250 250

                                    False ->
                                        rgb255 100 100 100
                            ]
                            [ Input.button [ width fill ]
                                { onPress =
                                    case playerHasItems of
                                        True ->
                                            Just ToggleInventory

                                        False ->
                                            Nothing
                                , label = text "Inventory"
                                }
                            ]
                , case displayInventory of
                    True ->
                        Input.button []
                            { onPress = Just ToggleInventory
                            , label = text "Close inventory"
                            }

                    False ->
                        Input.button []
                            { onPress =
                                Just <| ExamineRoom item
                            , label = text "Examine room"
                            }
                , case messageDisplayed of
                    Just message ->
                        paragraph [] [ text message ]

                    Nothing ->
                        Element.none
                ]
        ]
