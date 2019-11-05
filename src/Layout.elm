module Layout exposing (mainLayout)

import Element exposing (Element, column, fill, fillPortion, none, row, spacing, width)
import Element.Font as Font


emptyColumn : Int -> Element msg
emptyColumn portion =
    column [ width <| fillPortion portion ] [ none ]


mainLayout : List (Element msg) -> Element msg
mainLayout children =
    row
        [ spacing 20
        , width fill
        , Font.family
            [ Font.external
                { name = "Special Elite"
                , url = "https://fonts.googleapis.com/css?family=Special+Elite"
                }
            , Font.sansSerif
            ]
        ]
        [ emptyColumn 1
        , column
            [ width <| fillPortion 8
            , spacing 20
            ]
          <|
            children
        , emptyColumn 1
        ]
