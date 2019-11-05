module Item exposing (Item(..), fromString, itemInfo, itemsEncoder)


type Item
    = LionCrest
    | WineBottle
    | UtilityKey
    | SheetMusic
    | MooseHead
    | Keycode
    | EagleCrest
    | Crowbar
    | StatueHead
    | Handle
    | SmallKey
    | WolfCrest
    | ErrorItem


type alias ItemInfo =
    { name : String
    , description : String
    , messageWhenUsed : String
    , messageWhenNotUsed : String
    }


itemsEncoder : List Item -> List String
itemsEncoder items =
    List.map
        (\x -> itemInfo x |> .name)
        items


fromString : String -> Item
fromString itemString =
    case itemString of
        "Lion Crest" ->
            LionCrest

        "Wine Bottle" ->
            WineBottle

        "Utility Key" ->
            UtilityKey

        "Sheet Music" ->
            SheetMusic

        "Moose Head" ->
            MooseHead

        "Keycode" ->
            Keycode

        "Eagle Crest" ->
            EagleCrest

        "Crowbar" ->
            Crowbar

        "Statue Head" ->
            StatueHead

        "Handle" ->
            Handle

        "Small Key" ->
            SmallKey

        "Wolf Crest" ->
            WolfCrest

        _ ->
            ErrorItem


itemInfo : Item -> ItemInfo
itemInfo item =
    case item of
        LionCrest ->
            { name = "Lion Crest"
            , description = "A crest, with a lion's head on the front."
            , messageWhenUsed = "You place the crest into the door"
            , messageWhenNotUsed = "Cool lion, but what could this be for?"
            }

        WineBottle ->
            { name = "Wine Bottle"
            , description = "An expensive-looking bottle of wine."
            , messageWhenUsed = "You place the wine bottle back in the rack"
            , messageWhenNotUsed = "It's a shame this is empty. Some wine would be good right now."
            }

        UtilityKey ->
            { name = "Utility Key"
            , description = "A small key, with a tag that reads \"Utility\"."
            , messageWhenUsed = "You unlock the door to the utility room"
            , messageWhenNotUsed = "This key doesn't seem to fit any locks here."
            }

        SheetMusic ->
            { name = "Sheet Music"
            , description = "Sheet music for Beethoven's Piano Sonata No. 14."
            , messageWhenUsed = "You play the piano"
            , messageWhenNotUsed = "An excellent piece of music. Though I'm not sure why I decided to steal it"
            }

        MooseHead ->
            { name = "Moose Head"
            , description = "A moose's head. Its cold, dead eyes stare at you, looking lost and lonely."
            , messageWhenUsed = "Ah, that's better"
            , messageWhenNotUsed = "I will not rest until this is back where it belongs"
            }

        Keycode ->
            { name = "Keycode"
            , description = "A piece of paper with \"2407\" written on it."
            , messageWhenUsed = "You enter the keycode into the terminal"
            , messageWhenNotUsed = "What could these numbers mean?"
            }

        EagleCrest ->
            { name = "Eagle Crest"
            , description = "A crest, with an eagle's head on the front."
            , messageWhenUsed = "You place the crest into the door"
            , messageWhenNotUsed = "What is this for? What does the eagle signify?"
            }

        Crowbar ->
            { name = "Crowbar"
            , description = "A sturdy crowbar."
            , messageWhenUsed = "You prise off the wooden planks"
            , messageWhenNotUsed = "Nothing to use this on in here."
            }

        StatueHead ->
            { name = "Statue Head"
            , description = "The head of a small statue."
            , messageWhenUsed = "You place the head carefully back onto the statue"
            , messageWhenNotUsed = "What a strange thing to have found. I wonder who it's meant to be?"
            }

        Handle ->
            { name = "Handle"
            , description = "A metal handle. It looks like it's for some sort of trap door."
            , messageWhenUsed = "You have attached the handle"
            , messageWhenNotUsed = "I'm not sure where I could put this."
            }

        SmallKey ->
            { name = "Small Key"
            , description = "A small key, with a tag that reads \"S.Q.\""
            , messageWhenUsed = "You unlock the door"
            , messageWhenNotUsed = "It doesn't look like this can be used here"
            }

        WolfCrest ->
            { name = "Wolf Crest"
            , description = "A crest with a wolf on it. Very unusual."
            , messageWhenUsed = "You place the crest into the door"
            , messageWhenNotUsed = "What could this be for?"
            }

        ErrorItem ->
            { name = "Error Item"
            , description = "You shouldn't be seeing this - something has gone wrong!"
            , messageWhenUsed = ""
            , messageWhenNotUsed = "How embarassing"
            }
