module Page.Game.DirectionControls exposing (view)

import Data.Room exposing (Room)
import Dict exposing (Dict)
import Element exposing (Element, centerX, centerY, column, fillPortion, padding, row, spacing, text, width)
import Element.Input as Input


enterKey =
    "Enter"


upstairsKey =
    "Upstairs"


downstairsKey =
    "Downstairs"


northKey =
    "North"


westKey =
    "West"


eastKey =
    "East"


southKey =
    "South"


view : Dict String Room -> (Room -> msg) -> Element msg
view directions msg =
    let
        enter =
            Dict.get enterKey directions

        upstairs =
            Dict.get upstairsKey directions

        downstairs =
            Dict.get downstairsKey directions

        north =
            Dict.get northKey directions

        west =
            Dict.get westKey directions

        east =
            Dict.get eastKey directions

        south =
            Dict.get southKey directions

        buttonAttributes =
            [ padding 20 ]
    in
    row
        [ centerX
        , spacing 20
        ]
        [ column
            [ centerY
            , width <| fillPortion 4
            ]
            [ case west of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text westKey
                        }

                Nothing ->
                    Element.none
            ]
        , column
            [ width <| fillPortion 4
            , spacing 20
            ]
            [ case enter of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text enterKey
                        }

                Nothing ->
                    Element.none
            , case upstairs of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text upstairsKey
                        }

                Nothing ->
                    Element.none
            , case north of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text northKey
                        }

                Nothing ->
                    Element.none
            , case south of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text southKey
                        }

                Nothing ->
                    Element.none
            , case downstairs of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text downstairsKey
                        }

                Nothing ->
                    Element.none
            ]
        , column
            [ centerY
            , width <| fillPortion 4
            ]
            [ case east of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text eastKey
                        }

                Nothing ->
                    Element.none
            ]
        ]
