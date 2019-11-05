module Page.Game.DirectionControls exposing (view)

import Browser.Navigation as Nav
import Dict exposing (Dict)
import Element exposing (Element, centerX, centerY, column, fill, fillPortion, height, htmlAttribute, minimum, padding, paragraph, rgb255, row, spacing, text, width)
import Element.Font as Font
import Element.Input as Input
import Html.Attributes exposing (id)
import Item exposing (Item)
import Room exposing (Room, downstairsKey, eastKey, endGameKey, enterKey, northKey, southKey, unlockRequirements, upstairsKey, westKey)


buttonAttributes : Bool -> String -> List (Element.Attribute msg)
buttonAttributes isUnlocked buttonLabel =
    [ padding 20
    , centerY
    , width fill
    , height (fill |> minimum 35)
    , htmlAttribute <| id <| "button:" ++ buttonLabel
    , Font.color <|
        if isUnlocked then
            rgb255 250 250 250

        else
            rgb255 100 100 100
    ]


columnAttributes : List (Element.Attribute msg)
columnAttributes =
    [ centerY
    , width <| fillPortion 3
    , height (fill |> minimum 100)
    ]


roomButton : Maybe Room -> (Room -> Nav.Key -> msg) -> String -> List Item -> Nav.Key -> Element msg
roomButton maybeRoom msg buttonLabel itemsUsed navKey =
    case maybeRoom of
        Just room ->
            let
                roomIsUnlocked =
                    case unlockRequirements room of
                        Just itemsNeededToUnlockRoom ->
                            List.length itemsUsed
                                > 0
                                && List.all (\x -> List.member x itemsUsed) itemsNeededToUnlockRoom

                        Nothing ->
                            True
            in
            Input.button
                (buttonAttributes roomIsUnlocked buttonLabel)
                { onPress =
                    if roomIsUnlocked then
                        Just <| msg room navKey

                    else
                        Nothing
                , label = text buttonLabel
                }

        Nothing ->
            paragraph [ height (fill |> minimum 50) ] [ Element.none ]


view : Dict String Room -> (Room -> Nav.Key -> msg) -> List Item -> Nav.Key -> Element msg
view directions msg itemsUsed navKey =
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

        end =
            Dict.get endGameKey directions
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
                navKey
            ]
        , column
            columnAttributes
            [ roomButton
                upstairs
                msg
                upstairsKey
                itemsUsed
                navKey
            , roomButton
                north
                msg
                northKey
                itemsUsed
                navKey
            , roomButton
                enter
                msg
                enterKey
                itemsUsed
                navKey
            , roomButton
                south
                msg
                southKey
                itemsUsed
                navKey
            , roomButton
                downstairs
                msg
                downstairsKey
                itemsUsed
                navKey
            , roomButton
                end
                msg
                endGameKey
                itemsUsed
                navKey
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
                navKey
            ]
        ]
