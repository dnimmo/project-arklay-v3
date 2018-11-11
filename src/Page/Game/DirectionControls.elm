module Page.Game.DirectionControls exposing (view)

import Data.Room exposing (Room)
import Dict exposing (Dict)
import Element exposing (Element, centerX, centerY, column, fillPortion, padding, row, spacing, text, width)
import Element.Input as Input


view : Dict String Room -> (Room -> msg) -> Element msg
view directions msg =
    let
        enter =
            Dict.get "Enter" directions

        upstairs =
            Dict.get "Upstairs" directions

        downstairs =
            Dict.get "Downstairs" directions

        north =
            Dict.get "North" directions

        west =
            Dict.get "West" directions

        east =
            Dict.get "East" directions

        south =
            Dict.get "South" directions

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
                        , label = text "West"
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
                        , label = text "Enter"
                        }

                Nothing ->
                    Element.none
            , case upstairs of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text "Upstairs"
                        }

                Nothing ->
                    Element.none
            , case north of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text "North"
                        }

                Nothing ->
                    Element.none
            , case south of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text "South"
                        }

                Nothing ->
                    Element.none
            , case downstairs of
                Just room ->
                    Input.button buttonAttributes
                        { onPress =
                            Just <| msg room
                        , label = text "Downstairs"
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
                        , label = text "East"
                        }

                Nothing ->
                    Element.none
            ]
        ]
