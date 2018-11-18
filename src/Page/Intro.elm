module Page.Intro exposing (Model, Msg, initialModel, update, view)

import Browser.Navigation as Nav
import Element exposing (Element, centerX, fill, htmlAttribute, padding, paragraph, row, text, width, wrappedRow)
import Element.Font as Font
import Element.Input as Input
import Html.Attributes exposing (id)
import Navigation exposing (gamePath)
import View.Layout as Layout



-- MODEL


type Model
    = Started
    | NotStarted


initialModel : Model
initialModel =
    NotStarted



-- UPDATE


type Msg
    = StartGame Nav.Key


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartGame navKey ->
            ( Started, Nav.pushUrl navKey gamePath )



-- VIEW


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
        , wrappedRow [ width fill ]
            [ paragraph []
                [ text "Your head hurts. You're not sure where you are, and you definitely don't know how you got here. There's rain thrashing the ground all around you. You figure you might as well try and understand what the Hell is going on..." ]
            ]
        , row [ width fill ]
            [ Input.button
                [ htmlAttribute <| id "button:Start"
                , centerX
                , padding 20
                ]
                { onPress =
                    case model of
                        NotStarted ->
                            Just <| StartGame navKey

                        Started ->
                            Nothing
                , label = text "Start"
                }
            ]
        ]
