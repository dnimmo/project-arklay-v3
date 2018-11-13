module Page.Game.DirectionControls exposing (view)

import Data.Room exposing (Room, downstairsKey, eastKey, enterKey, northKey, southKey, upstairsKey, westKey)
import Dict exposing (Dict)
import Element exposing (Element, centerX, centerY, column, fill, fillPortion, height, minimum, padding, paragraph, row, spacing, text, width)
import Element.Input as Input


buttonAttributes =
    [ padding 20
    , centerY
    , width fill
    ]


columnAttributes =
    [ centerY
    , width <| fillPortion 3
    , height (fill |> minimum 200)
    ]


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
    in
    row
        [ centerX
        , spacing 20
        , width fill
        ]
        [ column
            columnAttributes
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
            columnAttributes
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
            columnAttributes
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
