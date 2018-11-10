module Page.Intro exposing (Model, Msg, initialModel, update, view)

import Browser.Navigation as Nav
import Element exposing (Element, alignLeft, centerX, centerY, column, el, fill, fillPortion, padding, paragraph, px, row, spacing, text, width, wrappedRow)
import Element.Font as Font
import Element.Input as Input
import Navigation exposing (gamePath)



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


emptyColumn : Int -> Element msg
emptyColumn portion =
    column [ width <| fillPortion portion ] [ Element.none ]


view : Nav.Key -> Model -> Element Msg
view navKey model =
    row [ spacing 20 ]
        [ emptyColumn 2
        , column
            [ width <| fillPortion 6
            , padding 60
            , spacing 20
            ]
          <|
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
                    [ centerX
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
        , emptyColumn 2
        ]