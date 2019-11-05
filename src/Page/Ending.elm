module Page.Ending exposing (view)

import Element exposing (Element, fill, padding, paragraph, row, text, width, wrappedRow)
import Element.Font as Font
import Layout


view : Element msg
view =
    Layout.mainLayout
        [ row
            [ Font.size 40
            , padding 20
            , width fill
            ]
            [ paragraph []
                [ text "Congratulations!" ]
            ]
        , wrappedRow [ width fill ]
            [ paragraph []
                [ text "Thanks for playing; I'm sorry if this is a bit of an anti-climax, but I'm not really expecting anyone to ever see this message to be honest. If you did, then send me a tweet! @_dnimmo" ]
            ]
        ]
