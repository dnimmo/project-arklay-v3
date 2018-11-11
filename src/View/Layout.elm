module View.Layout exposing (mainLayout)

import Element exposing (Element, column, fill, fillPortion, none, padding, row, spacing, width)


emptyColumn : Int -> Element msg
emptyColumn portion =
    column [ width <| fillPortion portion ] [ none ]


mainLayout : List (Element msg) -> Element msg
mainLayout children =
    row
        [ spacing 20
        , width fill
        ]
        [ emptyColumn 2
        , column
            [ width <| fillPortion 6
            , padding 60
            , spacing 20
            ]
          <|
            children
        , emptyColumn 2
        ]
