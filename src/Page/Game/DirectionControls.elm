module Page.Game.DirectionControls exposing (view)

import Data.Item exposing (Item)
import Data.Room exposing (Room, downstairsKey, eastKey, enterKey, northKey, roomInfo, southKey, upstairsKey, westKey)
import Dict exposing (Dict)
import Element exposing (Element, centerX, centerY, column, fill, fillPortion, height, minimum, padding, paragraph, rgb255, row, spacing, text, width)
import Element.Font as Font
import Element.Input as Input


buttonAttributes : Bool -> List (Element.Attribute msg)
buttonAttributes isUnlocked =
    [ padding 20
    , centerY
    , width fill
    , Font.color <|
        case isUnlocked of
            True ->
                rgb255 250 250 250

            False ->
                rgb255 100 100 100
    ]


columnAttributes =
    [ centerY
    , width <| fillPortion 3
    , height (fill |> minimum 200)
    ]


roomButton : Maybe Room -> (Room -> msg) -> String -> List Item -> Element msg
roomButton maybeRoom msg buttonLabel itemsUsed =
    case maybeRoom of
        Just room ->
            let
                roomIsUnlocked =
                    case roomInfo room |> .unlockRequirements of
                        Just itemsNeededToUnlockRoom ->
                            List.length itemsUsed
                                > 0
                                && List.all (\x -> List.member x itemsUsed) itemsNeededToUnlockRoom

                        Nothing ->
                            True
            in
            Input.button
                (buttonAttributes roomIsUnlocked)
                { onPress =
                    case roomIsUnlocked of
                        True ->
                            Just <| msg room

                        False ->
                            Nothing
                , label = text buttonLabel
                }

        Nothing ->
            Element.none


view : Dict String Room -> (Room -> msg) -> List Item -> Element msg
view directions msg itemsUsed =
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
            (Font.alignRight :: columnAttributes)
          <|
            [ roomButton
                west
                msg
                westKey
                itemsUsed
            ]
        , column
            columnAttributes
            [ roomButton
                enter
                msg
                enterKey
                itemsUsed
            , roomButton
                upstairs
                msg
                upstairsKey
                itemsUsed
            , roomButton
                north
                msg
                northKey
                itemsUsed
            , roomButton
                south
                msg
                southKey
                itemsUsed
            , roomButton
                downstairs
                msg
                downstairsKey
                itemsUsed
            ]
        , column
            (Font.alignLeft
                :: columnAttributes
            )
            [ roomButton
                east
                msg
                eastKey
                itemsUsed
            ]
        ]
