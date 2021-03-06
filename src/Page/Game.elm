module Page.Game exposing (Model, Msg, gameStateFromString, initialModel, stateEncoder, update, view)

import Browser.Navigation as Nav
import Element exposing (Element, column, fill, height, htmlAttribute, minimum, padding, paragraph, rgb255, row, text, width)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes exposing (id)
import Item exposing (Item, itemInfo)
import Layout exposing (mainLayout)
import Navigation exposing (endingPath)
import Page.Game.DirectionControls as DirectionControls
import Page.Game.Surroundings as Surroundings
import Ports
import Room exposing (Room, gameComplete, itemsThatCanBeUsed, roomInfo, startingRoom)



-- MODEL


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
    , room = startingRoom
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

        _ ->
            DisplayingDirections



-- UPDATE


type Msg
    = ToggleInventory
    | UseItem Item Room
    | ChangeRoom Room Nav.Key
    | ExamineRoom (Maybe Item)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeRoom room navKey ->
            let
                updatedModel =
                    { model
                        | room = room
                        , messageDisplayed = Nothing
                    }
            in
            ( updatedModel
            , if gameComplete room then
                Cmd.batch
                    [ Ports.deleteSaveData ()
                    , Nav.pushUrl navKey endingPath
                    ]

              else
                Cmd.none
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
                            let
                                description =
                                    roomInfo model.room |> .descriptionWhenExamined
                            in
                            Just <|
                                if description /= "" then
                                    description

                                else
                                    "Hm, nothing interesting here"
              }
            , Cmd.none
            )

        ToggleInventory ->
            ( { model
                | state =
                    case model.state of
                        DisplayingDirections ->
                            DisplayingInventory

                        DisplayingInventory ->
                            DisplayingDirections
                , messageDisplayed = Nothing
              }
            , Cmd.none
            )

        UseItem item room ->
            let
                itemCanBeUsed =
                    case itemsThatCanBeUsed room of
                        Just items ->
                            items |> List.member item

                        Nothing ->
                            False
            in
            ( if itemCanBeUsed then
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
            , Cmd.none
            )



-- VIEW


inventoryView : List Item -> Room -> List (Element Msg)
inventoryView inventory room =
    List.map
        (\x ->
            let
                itemName =
                    itemInfo x |> .name
            in
            Input.button
                [ width fill
                , Font.center
                , padding 20
                , htmlAttribute <| id <| "button:" ++ itemName
                ]
                { onPress =
                    Just <| UseItem x room
                , label = text itemName
                }
        )
        inventory


view : Nav.Key -> Model -> Element Msg
view navKey model =
    let
        { room, inventory, itemsUsed, state, messageDisplayed } =
            model

        { intro, item, availableDirections } =
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
                DirectionControls.view availableDirections ChangeRoom itemsUsed navKey

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
                                if playerHasItems then
                                    rgb255 250 250 250

                                else
                                    rgb255 100 100 100
                            , width fill
                            ]
                            [ Input.button
                                [ width fill
                                , htmlAttribute <| id "button:Inventory"
                                ]
                                { onPress =
                                    if playerHasItems then
                                        Just ToggleInventory

                                    else
                                        Nothing
                                , label = paragraph [] [ text "Inventory" ]
                                }
                            ]
                , case state of
                    DisplayingInventory ->
                        Input.button
                            [ width fill
                            , htmlAttribute <| id "button:CloseInventory"
                            ]
                            { onPress = Just ToggleInventory
                            , label = text "Close inventory"
                            }

                    DisplayingDirections ->
                        Input.button
                            [ width fill
                            , htmlAttribute <| id "button:ExamineRoom"
                            ]
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
