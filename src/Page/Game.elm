module Page.Game exposing (Model, Msg, initialModel, update, view)

import Data.Item exposing (Item, itemInfo)
import Data.Room as Room exposing (Room(..), roomInfo)
import Element exposing (Element, centerX, centerY, column, fill, fillPortion, padding, paragraph, rgb255, row, spacing, text, width, wrappedRow)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Page.Game.DirectionControls as DirectionControls
import View.Layout exposing (mainLayout)



-- MODEL


type alias Model =
    { room : Room
    , inventory : List Item
    , displayInventory : Bool
    }


initialModel : Model
initialModel =
    { room = Room.startingRoom
    , inventory = []
    , displayInventory = False
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
              }
            , Cmd.none
            )

        ChangeRoom room ->
            ( { model
                | room = room
              }
            , Cmd.none
            )

        ExamineRoom item ->
            ( { model
                | inventory =
                    case item of
                        Just x ->
                            x :: model.inventory

                        Nothing ->
                            model.inventory
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
view { room, inventory, displayInventory } =
    let
        { intro, surroundings, item, availableDirections } =
            roomInfo room

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
            [ paragraph [] [ text surroundings ] ]
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
                , Font.color <|
                    case playerHasItems of
                        True ->
                            rgb255 250 250 250

                        False ->
                            rgb255 100 100 100
                ]
                [ case displayInventory of
                    True ->
                        column [] <|
                            inventoryView inventory

                    False ->
                        column []
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
                        Input.button [ Font.color <| rgb255 250 250 250 ]
                            { onPress =
                                Just <| ExamineRoom item
                            , label = text "Examine room"
                            }
                ]
        ]
