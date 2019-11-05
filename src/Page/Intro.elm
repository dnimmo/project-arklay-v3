module Page.Intro exposing (Model, Msg, initialModel, update, view)

import Browser.Navigation as Nav
import Element exposing (Element, centerX, column, fill, htmlAttribute, padding, paragraph, row, text, width, wrappedRow)
import Element.Font as Font
import Element.Input as Input
import Html.Attributes exposing (id)
import Navigation exposing (gamePath)
import Page.Intro.SaveData as SaveData
import Ports exposing (loadGame)
import View.Layout as Layout



-- MODEL


type Model
    = Started
    | NotStarted (Maybe SaveData.Model)


initialModel : Maybe SaveData.Model -> Model
initialModel saveData =
    NotStarted saveData



-- UPDATE


type Msg
    = StartGame Nav.Key
    | LoadGame SaveData.Model


update : Msg -> ( Model, Cmd Msg )
update msg =
    case msg of
        StartGame navKey ->
            ( Started, Nav.pushUrl navKey gamePath )

        LoadGame saveData ->
            ( Started, loadGame saveData )



-- VIEW


startGameView : Nav.Key -> Element Msg
startGameView navKey =
    column
        [ width fill
        ]
        [ wrappedRow []
            [ paragraph []
                [ text "Your head hurts. You're not sure where you are, and you definitely don't know how you got here. There's rain thrashing the ground all around you. You figure you might as well try and understand what the Hell is going on..." ]
            ]
        , row [ width fill ]
            [ Input.button
                [ htmlAttribute <| id "button:Start"
                , centerX
                , padding 20
                ]
                { onPress = Just <| StartGame navKey
                , label = text "Start"
                }
            ]
        ]


loadGameView : SaveData.Model -> Nav.Key -> Element Msg
loadGameView saveData navKey =
    column
        [ width fill ]
        [ row
            [ width fill
            , centerX
            ]
            [ paragraph
                []
                [ text "Would you like to load your previous save data?" ]
            ]
        , row [ width fill ]
            [ Input.button
                [ htmlAttribute <| id "button:LoadGame"
                , centerX
                , padding 40
                ]
                { onPress = Just <| LoadGame saveData
                , label = text "Continue"
                }
            , Input.button
                [ htmlAttribute <| id "button:StartANewGame"
                , centerX
                , padding 40
                ]
                { onPress = Just <| StartGame navKey
                , label = text "Start a new game"
                }
            ]
        ]


view : Nav.Key -> Model -> Element Msg
view navKey model =
    Layout.mainLayout
        [ row
            [ Font.size 40
            , padding 20
            , width fill
            ]
            [ paragraph []
                [ text "Project Arklay" ]
            ]
        , case model of
            NotStarted Nothing ->
                startGameView navKey

            NotStarted (Just saveData) ->
                loadGameView saveData navKey

            Started ->
                paragraph
                    [ width fill
                    , centerX
                    ]
                    [ text "Loading..." ]
        ]
