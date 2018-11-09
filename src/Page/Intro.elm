module Page.Intro exposing (view)

import Element exposing (Element, alignLeft, centerX, centerY, column, el, fill, fillPortion, padding, paragraph, px, row, text, width, wrappedRow)
import Element.Font as Font


emptyColumn : Int -> Element msg
emptyColumn portion =
    column [ width <| fillPortion portion ] [ Element.none ]


view : Element msg
view =
    row []
        [ emptyColumn 2
        , column
            [ width <| fillPortion 6
            , padding 60
            ]
          <|
            [ row
                [ Font.size 40
                , padding 20
                , width fill
                ]
                [ paragraph [] [ text "Project Arklay" ] ]
            , wrappedRow [ width fill ]
                [ paragraph [] [ text "Your head hurts. You're not sure where you are, and you definitely don't know how you got here. There's rain thrashing the ground all around you. You figure you might as well try and understand what the Hell is going on..." ]
                ]
            ]
        , emptyColumn 2
        ]
