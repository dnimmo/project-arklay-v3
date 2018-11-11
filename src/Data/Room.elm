module Data.Room exposing (Room, roomInfo, startingRoom)

import Dict exposing (Dict)


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
    , availableDirections : Dict String Room
    }


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
                Dict.fromList [ ( "Enter", Entrance ) ]
            }

        Entrance ->
            { name = "Entrance"
            , intro = "You are in the dim foyer of what appears to be a mansion."
            , surroundings = "There is a grand staircase here, as well as a couple of doors."
            , surroundingsWhenItemPickedUp = Nothing
            , surroundingsWhenItemUsed = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( "Upstairs", Start ) -- "Upstairs Foyer"
                    , ( "West", Start ) -- "Dining Hall"
                    , ( "East", Start ) -- "Hallway One"
                    ]
            }
