module Data.Room exposing (Room, startingRoom)


type alias Room =
    { name : String
    , intro : String
    , surroundings : String
    , surroundingsWhenItemPickedUp : Maybe String
    , surroundingsWhenItemUsed : Maybe String
    , item : Maybe String
    , availableDirections : List Direction
    }


type alias Direction =
    { text : String
    , destination : String
    , unlockedWith : Maybe (List String)
    }


startingRoom : Room
startingRoom =
    { name = "Start"
    , intro = "It's dark, and cold. You're soaked through. You struggle to remember where you are, let alone how you ended up here. What were you doing again?"
    , surroundings = "There's a large door in front of you."
    , surroundingsWhenItemPickedUp = Nothing
    , surroundingsWhenItemUsed = Nothing
    , item = Nothing
    , availableDirections =
        [ { text = "Enter"
          , destination = "Entrance"
          , unlockedWith = Nothing
          }
        ]
    }
