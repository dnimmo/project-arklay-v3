module Data.Room exposing (Direction(..), Room, roomInfo, startingRoom)


type Room
    = Start
    | Entrance


type alias RoomInfo =
    { name : String
    , intro : String
    , surroundings : String
    , surroundingsWhenItemPickedUp : Maybe String
    , surroundingsWhenItemUsed : Maybe String
    , item : Maybe String
    , availableDirections : List Direction
    }


type Direction
    = Enter Room
    | North Room
    | East Room
    | West Room
    | South Room
    | Upstairs Room
    | Downstairs Room


startingRoom : Room
startingRoom =
    Start


roomInfo : Room -> RoomInfo
roomInfo room =
    case room of
        Start ->
            { name = "Start"
            , intro = "It's dark, and cold. You're soaked through. You struggle to remember where you are, let alone how you ended up here. What were you doing again?"
            , surroundings = "There's a large door in front of you."
            , surroundingsWhenItemPickedUp = Nothing
            , surroundingsWhenItemUsed = Nothing
            , item = Nothing
            , availableDirections =
                [ Enter Entrance
                ]
            }

        Entrance ->
            { name = "Entrance"
            , intro = "You are in the dim foyer of what appears to be a mansion."
            , surroundings = "There is a grand staircase here, as well as a couple of doors."
            , surroundingsWhenItemPickedUp = Nothing
            , surroundingsWhenItemUsed = Nothing
            , item = Nothing
            , availableDirections =
                [ Upstairs Start -- "Upstairs Foyer"
                , West Start -- "Dining Hall"
                , East Start -- "Hallway One"
                ]
            }
