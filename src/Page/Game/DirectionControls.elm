module Page.Game.DirectionControls exposing (view)

import Data.Room exposing (Direction(..), Room)
import Element exposing (Element, centerX, centerY, column, fillPortion, padding, row, spacing, text, width)
import Element.Input as Input



-- TODO: Make this module less shit! :D


view : List Direction -> (Room -> msg) -> Element msg
view directions msg =
    let
        enter =
            directions
                |> List.filter
                    (\x ->
                        case x of
                            Enter _ ->
                                True

                            _ ->
                                False
                    )

        upstairs =
            directions
                |> List.filter
                    (\x ->
                        case x of
                            Upstairs _ ->
                                True

                            _ ->
                                False
                    )

        downstairs =
            directions
                |> List.filter
                    (\x ->
                        case x of
                            Downstairs _ ->
                                True

                            _ ->
                                False
                    )

        north =
            directions
                |> List.filter
                    (\x ->
                        case x of
                            North _ ->
                                True

                            _ ->
                                False
                    )

        west =
            directions
                |> List.filter
                    (\x ->
                        case x of
                            West _ ->
                                True

                            _ ->
                                False
                    )

        east =
            directions
                |> List.filter
                    (\x ->
                        case x of
                            East _ ->
                                True

                            _ ->
                                False
                    )

        south =
            directions
                |> List.filter
                    (\x ->
                        case x of
                            South _ ->
                                True

                            _ ->
                                False
                    )

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
            [ case List.head west of
                Just direction ->
                    Input.button buttonAttributes
                        { onPress =
                            case direction of
                                West room ->
                                    Just <| msg room

                                _ ->
                                    Nothing
                        , label = text "West"
                        }

                Nothing ->
                    Element.none
            ]
        , column
            [ width <| fillPortion 4
            , spacing 20
            ]
            [ case List.head enter of
                Just direction ->
                    Input.button buttonAttributes
                        { onPress =
                            case direction of
                                Enter room ->
                                    Just <| msg room

                                _ ->
                                    Nothing
                        , label = text "Enter"
                        }

                Nothing ->
                    Element.none
            , case List.head upstairs of
                Just direction ->
                    Input.button buttonAttributes
                        { onPress =
                            case direction of
                                Upstairs room ->
                                    Just <| msg room

                                _ ->
                                    Nothing
                        , label = text "Upstairs"
                        }

                Nothing ->
                    Element.none
            , case List.head north of
                Just direction ->
                    Input.button buttonAttributes
                        { onPress =
                            case direction of
                                North room ->
                                    Just <| msg room

                                _ ->
                                    Nothing
                        , label = text "North"
                        }

                Nothing ->
                    Element.none
            , case List.head south of
                Just direction ->
                    Input.button buttonAttributes
                        { onPress =
                            case direction of
                                South room ->
                                    Just <| msg room

                                _ ->
                                    Nothing
                        , label = text "South"
                        }

                Nothing ->
                    Element.none
            , case List.head downstairs of
                Just direction ->
                    Input.button buttonAttributes
                        { onPress =
                            case direction of
                                Downstairs room ->
                                    Just <| msg room

                                _ ->
                                    Nothing
                        , label = text "Downstairs"
                        }

                Nothing ->
                    Element.none
            ]
        , column
            [ centerY
            , width <| fillPortion 4
            ]
            [ case List.head east of
                Just direction ->
                    Input.button buttonAttributes
                        { onPress =
                            case direction of
                                East room ->
                                    Just <| msg room

                                _ ->
                                    Nothing
                        , label = text "East"
                        }

                Nothing ->
                    Element.none
            ]
        ]
