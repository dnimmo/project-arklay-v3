module Data.Room exposing
    ( Room(..)
    , downstairsKey
    , eastKey
    , endGameKey
    , enterKey
    , fromRoomName
    , gameComplete
    , itemsThatCanBeUsed
    , northKey
    , roomInfo
    , southKey
    , startingRoom
    , unlockRequirements
    , upstairsKey
    , westKey
    )

import Data.Item exposing (Item(..))
import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder)


type Room
    = Start
    | Entrance
    | UpstairsFoyer
    | DiningHall
    | HallwayOne
    | HallwayTwo
    | HallwayThree
    | HallwayFour
    | HallwayFive
    | UpstairsHallwayOne
    | UpstairsHallwayTwo
    | UpstairsHallwayThree
    | UpstairsHallwayFour
    | UpstairsStudy
    | UpstairsSecretRoomThree
    | UpstairsStairwayThree
    | UpstairsMasterBedroom
    | StairwayTwo
    | StairwayThree
    | UpstairsMasterEnSuite
    | UpstairsStairwayTwo
    | UpstairsTrophyRoom
    | UpstairsArtGallery
    | UpstairsAquarium
    | UpstairsLibrary
    | UpstairsSecondBedroom
    | UpstairsThirdBedroom
    | UpstairsSecondBathroom
    | Kitchen
    | UtilityRoom
    | BasementStairway
    | WasteDisposal
    | Freezer
    | BasementWasteDisposal
    | MusicRoom
    | SecretRoomOne
    | SecretRoomTwo
    | Gym
    | SwimmingPool
    | Showers
    | StatueRoom
    | ServantsQuarters
    | Garage
    | ServantsBathroom
    | BasementStorage
    | BasementStorageTwo
    | BasementWineCellar
    | BasementItemRoom
    | BasementLabEntrance
    | End


type alias RoomInfo =
    { name : String
    , intro : String
    , surroundings : String
    , surroundingsWhenItemPickedUp : Maybe String
    , surroundingsWhenItemUsed : Maybe String
    , item : Maybe Item
    , availableDirections : Dict String Room
    , descriptionWhenExamined : String
    }


startingRoom : Room
startingRoom =
    Start


gameComplete : Room -> Bool
gameComplete room =
    case room of
        End ->
            True

        _ ->
            False


unlockRequirements : Room -> Maybe (List Item)
unlockRequirements room =
    case room of
        SecretRoomOne ->
            Just [ SheetMusic ]

        SecretRoomTwo ->
            Just [ StatueHead ]

        UpstairsSecretRoomThree ->
            Just [ Keycode ]

        UpstairsMasterBedroom ->
            Just [ LionCrest, EagleCrest, WolfCrest ]

        UpstairsAquarium ->
            Just [ Crowbar ]

        UtilityRoom ->
            Just [ UtilityKey ]

        BasementWasteDisposal ->
            Just [ Handle ]

        ServantsQuarters ->
            Just [ SmallKey ]

        BasementLabEntrance ->
            Just [ WineBottle ]

        _ ->
            Nothing


itemsThatCanBeUsed : Room -> Maybe (List Item)
itemsThatCanBeUsed room =
    case room of
        UpstairsStudy ->
            Just [ Keycode ]

        UpstairsStairwayThree ->
            Just [ LionCrest, EagleCrest, WolfCrest ]

        UpstairsHallwayThree ->
            Just [ Crowbar ]

        HallwayTwo ->
            Just [ UtilityKey ]

        UpstairsTrophyRoom ->
            Just [ MooseHead ]

        WasteDisposal ->
            Just [ Handle ]

        MusicRoom ->
            Just [ SheetMusic ]

        StatueRoom ->
            Just [ StatueHead ]

        HallwayThree ->
            Just [ SmallKey ]

        BasementWineCellar ->
            Just [ WineBottle ]

        _ ->
            Nothing


fromRoomName : String -> Room
fromRoomName roomName =
    case roomName of
        "Start" ->
            Start

        "Entrance" ->
            Entrance

        "Upstairs Foyer" ->
            UpstairsFoyer

        "Dining Hall" ->
            DiningHall

        "Hallway One" ->
            HallwayOne

        "Hallway Two" ->
            HallwayTwo

        "Hallway Three" ->
            HallwayThree

        "Hallway Four" ->
            HallwayFour

        "Hallway Five" ->
            HallwayFive

        "Upstairs Hallway One" ->
            UpstairsHallwayOne

        "Upstairs Hallway Two" ->
            UpstairsHallwayTwo

        "Upstairs Hallway Three" ->
            UpstairsHallwayThree

        "Upstairs Hallway Four" ->
            UpstairsHallwayFour

        "Upstairs Study" ->
            UpstairsStudy

        "Upstairs Secret Room Three" ->
            UpstairsSecretRoomThree

        "Upstairs Stairway Three" ->
            UpstairsStairwayThree

        "Upstairs Master Bedroom" ->
            UpstairsMasterBedroom

        "Stairway Two" ->
            StairwayTwo

        "Stairway Three" ->
            StairwayThree

        "Upstairs Master En Suite" ->
            UpstairsMasterEnSuite

        "Upstairs Stairway Two" ->
            UpstairsStairwayTwo

        "Upstairs Trophy Room" ->
            UpstairsTrophyRoom

        "Upstairs Art Gallery" ->
            UpstairsArtGallery

        "Upstairs Aquarium" ->
            UpstairsAquarium

        "Upstairs Library" ->
            UpstairsLibrary

        "Upstairs Second Bedroom" ->
            UpstairsSecondBedroom

        "Upstairs Third Bedroom" ->
            UpstairsThirdBedroom

        "Upstairs Second Bathroom" ->
            UpstairsSecondBathroom

        "Kitchen" ->
            Kitchen

        "Utility Room" ->
            UtilityRoom

        "Basement Stairway" ->
            BasementStairway

        "Waste Disposal" ->
            WasteDisposal

        "Freezer" ->
            Freezer

        "Basement Waste Disposal" ->
            BasementWasteDisposal

        "Music Room" ->
            MusicRoom

        "Secret Room One" ->
            SecretRoomOne

        "Secret Room Two" ->
            SecretRoomTwo

        "Gym" ->
            Gym

        "Swimming Pool" ->
            SwimmingPool

        "Showers" ->
            Showers

        "Statue Room" ->
            StatueRoom

        "Servants' Quarters" ->
            ServantsQuarters

        "Garage" ->
            Garage

        "Sevants' Bathroom" ->
            ServantsBathroom

        "Basement Storage" ->
            BasementStorage

        "Basement Storage Two" ->
            BasementStorageTwo

        "Basement Wine Cellar" ->
            BasementWineCellar

        "Basement Item Room" ->
            BasementItemRoom

        "Basmenet Lab Entrance" ->
            BasementLabEntrance

        "End" ->
            End

        unknownRoom ->
            Start


enterKey =
    "Enter"


upstairsKey =
    "Upstairs"


downstairsKey =
    "Downstairs"


northKey =
    "North"


westKey =
    "West"


eastKey =
    "East"


southKey =
    "South"


endGameKey =
    "End Game"


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
                Dict.fromList [ ( enterKey, Entrance ) ]
            , descriptionWhenExamined = ""
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
                    [ ( upstairsKey, UpstairsFoyer )
                    , ( westKey, DiningHall )
                    , ( eastKey, HallwayOne )
                    ]
            , descriptionWhenExamined = "This room is enormous. There are a number of large paintings on the walls."
            }

        UpstairsFoyer ->
            { name = "Upstairs Foyer"
            , intro = "You're at the top of a staircase."
            , surroundings = "The foyer looks huge from up here. You can't imagine anyone actually living here."
            , surroundingsWhenItemPickedUp = Nothing
            , surroundingsWhenItemUsed = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, UpstairsHallwayOne )
                    , ( downstairsKey, Entrance )
                    ]
            , descriptionWhenExamined = "There's a soft breeze coming in from a crack in one of the windows."
            }

        UpstairsHallwayOne ->
            { name = "Upstairs Hallway One"
            , intro = "A hallway stretches out ahead. It's too dark to make out what the artwork lining the walls is depicting."
            , surroundings = "You can see three doors from here, though not especially well."
            , surroundingsWhenItemPickedUp = Nothing
            , surroundingsWhenItemUsed = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( westKey, UpstairsStudy )
                    , ( eastKey, UpstairsThirdBedroom )
                    , ( southKey, UpstairsFoyer )
                    ]
            , descriptionWhenExamined = "There really isn't a lot to see here."
            }

        UpstairsStudy ->
            { name = "Upstairs Study"
            , intro = "A study. There are huge bookcases, that seem to be filled mostly with scientific journals, although there appear to be a few religious texts in here too."
            , surroundings = "An old computer terminal is on in the corner. Has someone been here recently?"
            , surroundingsWhenItemPickedUp = Nothing
            , surroundingsWhenItemUsed = Just "A bookshelf has moved to one side, revealing a door to the West"
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, UpstairsHallwayTwo )
                    , ( westKey, UpstairsSecretRoomThree )
                    , ( eastKey, UpstairsHallwayOne )
                    ]
            , descriptionWhenExamined = "The room is bathed in a soft glow from the terminal."
            }

        UpstairsSecretRoomThree ->
            { name = "Upstairs Secret Room Three"
            , intro = "A small room with a podium in the center."
            , surroundings = "A crest depicting a Lion sits neatly on the podium. It looks important."
            , surroundingsWhenItemPickedUp = Just "The room is completely empty. The podium stands bare."
            , surroundingsWhenItemUsed = Nothing
            , item = Just LionCrest
            , availableDirections =
                Dict.fromList [ ( eastKey, UpstairsStudy ) ]
            , descriptionWhenExamined = ""
            }

        UpstairsStairwayThree ->
            { name = "Upstairs Stairway Three"
            , intro = "The top of a stairway. To the North is a fancy door with three indentations, and there is a much more plain door to the East"
            , surroundings = "What could be behind the door?"
            , surroundingsWhenItemPickedUp = Nothing
            , surroundingsWhenItemUsed = Just "Looks like it needs three crests to open"
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, UpstairsMasterBedroom )
                    , ( eastKey, UpstairsHallwayTwo )
                    , ( downstairsKey, StairwayThree )
                    ]
            , descriptionWhenExamined = "This door is something else. Where do you even get something like this?"
            }

        UpstairsMasterBedroom ->
            { name = "Upstairs Master Bedroom"
            , intro = "A fantastically ostentatious master bedroom, with a roaring fireplace and a huge four-poster bed"
            , surroundings = "There are two doors here."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( westKey, UpstairsMasterEnSuite )
                    , ( southKey, UpstairsStairwayThree )
                    ]
            , descriptionWhenExamined = "It's so much hotter in here than anywhere else. The fire must have been burning for a while now."
            }

        UpstairsMasterEnSuite ->
            { name = "Upstairs Master En Suite"
            , intro = "A large en-suite."
            , surroundings = "There's a very expensive, but sadly empty, bottle of wine sitting by the sink."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "Empty wine glasses stand on the floor by the bath."
            , item = Just WineBottle
            , availableDirections =
                Dict.fromList
                    [ ( eastKey, UpstairsMasterBedroom )
                    ]
            , descriptionWhenExamined = ""
            }

        UpstairsStairwayTwo ->
            { name = "Upstairs Stairway Two"
            , intro = "The top of a small staircase. It's eerily quiet here."
            , surroundings = "There's a single door to the West."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( westKey, UpstairsHallwayFour )
                    , ( downstairsKey, StairwayTwo )
                    ]
            , descriptionWhenExamined = "This staircase doesn't seem to fit with the rest of the house, as if it was built much later."
            }

        UpstairsHallwayTwo ->
            { name = "Upstairs Hallway Two"
            , intro = "A hallway. How big is this place?"
            , surroundings = "There are rooms in every direction here. No wonder everything's thick with dust."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, UpstairsTrophyRoom )
                    , ( westKey, UpstairsStairwayThree )
                    , ( eastKey, UpstairsArtGallery )
                    , ( southKey, UpstairsStudy )
                    ]
            , descriptionWhenExamined = "It's easy to feel lost here. Every door in this room looks the same."
            }

        UpstairsArtGallery ->
            { name = "Upstairs Art Gallery"
            , intro = "An art gallery."
            , surroundings = "This entire building is full of paintings, but the ones in this room are crazy. They all seem to depict demons and people being tortured. Guess they wanted to stick with a theme."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( westKey, UpstairsHallwayTwo )
                    , ( eastKey, UpstairsHallwayThree )
                    ]
            , descriptionWhenExamined = "It feels like there are a hundred pairs of eyes. Watching."
            }

        UpstairsHallwayThree ->
            { name = "Upstairs Hallway Three"
            , intro = "A cavernous hallway"
            , surroundings = "There are doors in every direction, but the door to the North is boarded shut."
            , surroundingsWhenItemUsed = Just "There are doors in every direction."
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, UpstairsAquarium )
                    , ( westKey, UpstairsArtGallery )
                    , ( eastKey, UpstairsHallwayFour )
                    , ( southKey, UpstairsLibrary )
                    ]
            , descriptionWhenExamined = "Why board a room shut? This is all a bit weird."
            }

        UpstairsAquarium ->
            { name = "Upstairs Aquarium"
            , intro = "A softly-lit aquarium"
            , surroundings = "There are a number of exotic fish here. Unfortunately, they look like they've all been dead for a while. But there is a small key in the bottom of one of the tanks."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "The air in here is crisp, and salty. How long have the fish been dead though? What happened in this house?"
            , item = Just UtilityKey
            , availableDirections =
                Dict.fromList
                    [ ( southKey, UpstairsHallwayThree )
                    ]
            , descriptionWhenExamined = ""
            }

        UpstairsLibrary ->
            { name = "Upstairs Library"
            , intro = "A library."
            , surroundings = "There are many, many books in here. There isn't time to look through them all. However, some sheet music appears to be sticking out from one of the shelves."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "There are many, many books in here. There isn't time to look through them all."
            , item = Just SheetMusic
            , availableDirections =
                Dict.fromList
                    [ ( northKey, UpstairsHallwayThree )
                    ]
            , descriptionWhenExamined = ""
            }

        UpstairsHallwayFour ->
            { name = "Upstairs Hallway Four"
            , intro = "A hallway."
            , surroundings = "It's amazing that all of these hallways look so different from one another."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( westKey, UpstairsHallwayThree )
                    , ( eastKey, UpstairsStairwayTwo )
                    , ( southKey, UpstairsSecondBedroom )
                    ]
            , descriptionWhenExamined = "It feels as if you're being watched...but by whom?"
            }

        UpstairsSecondBedroom ->
            { name = "Upstairs Second Bedroom"
            , intro = "A well-furnished bedroom."
            , surroundings = "It looks like this room has never been used. There's an en-suite to the South, and a door leading to a hallway to the North."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, UpstairsHallwayFour )
                    , ( southKey, UpstairsSecondBathroom )
                    ]
            , descriptionWhenExamined = "I guess they don't have many guests here."
            }

        UpstairsSecondBathroom ->
            { name = "Upstairs Second Bathroom"
            , intro = "A \"Jack and Jill\" bathroom, connecting two bedrooms."
            , surroundings = "You don't see these very often. It looks very fancy, but the water isn't running."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, UpstairsSecondBedroom )
                    , ( westKey, UpstairsThirdBedroom )
                    ]
            , descriptionWhenExamined = ""
            }

        UpstairsThirdBedroom ->
            { name = "Upstairs Third Bedroom"
            , intro = "A bedroom."
            , surroundings = "It's surprisingly messy. It looks like something terrible happened in here."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( westKey, UpstairsHallwayOne )
                    , ( eastKey, UpstairsSecondBathroom )
                    ]
            , descriptionWhenExamined = "Why board a room shut? This is all a bit weird."
            }

        UpstairsTrophyRoom ->
            { name = "Upstairs Trophy Room"
            , intro = "A trophy room."
            , surroundings = "There are various stuffed beasts adorning the walls. It's very chilling."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( southKey, UpstairsHallwayTwo )
                    ]
            , descriptionWhenExamined = ""
            }

        DiningHall ->
            { name = "Dining Hall"
            , intro = "A large dining hall."
            , surroundings = "A grandfather clock is steadily ticking, its sound echoing through the room."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, HallwayTwo )
                    , ( eastKey, Entrance )
                    ]
            , descriptionWhenExamined = "There's a pool of blood on the floor..."
            }

        HallwayOne ->
            { name = "Hallway One"
            , intro = "A short hallway."
            , surroundings = "You get a strange feeling. Are you alone? It's quiet, but this place is so big, it's hard to be sure."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, StatueRoom )
                    , ( westKey, Entrance )
                    ]
            , descriptionWhenExamined = "There's nothing to see here, somehow that doesn't feel reassuring."
            }

        HallwayTwo ->
            { name = "Hallway Two"
            , intro = "A hallway"
            , surroundings = "The stench in here is pretty bad. Like rotten food. There are doors in every direction, but the door to the East is locked"
            , surroundingsWhenItemUsed = Just "The stench in here is almost overwhelming now."
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, Kitchen )
                    , ( westKey, HallwayFour )
                    , ( eastKey, UtilityRoom )
                    , ( southKey, DiningHall )
                    ]
            , descriptionWhenExamined = "Everything is covered in cobwebs. Still, at least the flies are being dealt with."
            }

        UtilityRoom ->
            { name = "Utility Room"
            , intro = "A small, grey, utility room. It feels very cold in here."
            , surroundings = "There's a staircase that goes down a long way. There's a faint light from the bottom."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( westKey, HallwayTwo )
                    , ( downstairsKey, BasementStairway )
                    ]
            , descriptionWhenExamined = ""
            }

        Kitchen ->
            { name = "Kitchen"
            , intro = "The kitchen."
            , surroundings = "Flies buzz around piles of black, rotten, fruit and meat. It looks like this has been here for a long time. And it smells like it's been here even longer."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, WasteDisposal )
                    , ( eastKey, Freezer )
                    , ( southKey, HallwayTwo )
                    ]
            , descriptionWhenExamined = ""
            }

        Freezer ->
            { name = "Freezer"
            , intro = "A large walk-in freezer."
            , surroundings = "It's full of mountains of meat. And...there's a moose head on the floor."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "It's full of mountains of meat. Why was there a moose head in here?"
            , item = Just MooseHead
            , availableDirections =
                Dict.fromList
                    [ ( westKey, Kitchen )
                    ]
            , descriptionWhenExamined = ""
            }

        WasteDisposal ->
            { name = "Waste Disposal"
            , intro = "A room that is completely empty, except for a hatch at the back, that appears to be a waste disposal chute."
            , surroundings = "Unfortunately it doesn't have a handle, and can't be opened."
            , surroundingsWhenItemUsed = Just "What could be at the bottom?"
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( enterKey, BasementWasteDisposal )
                    , ( southKey, Kitchen )
                    ]
            , descriptionWhenExamined = ""
            }

        HallwayFour ->
            { name = "Hallway Four"
            , intro = "A long hallway."
            , surroundings = "There are a few doors leading from this hallway. The carpet appears to have been torn up in a number of places."
            , surroundingsWhenItemUsed = Just "What could be at the bottom?"
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, StairwayThree )
                    , ( westKey, MusicRoom )
                    , ( eastKey, HallwayTwo )
                    ]
            , descriptionWhenExamined = ""
            }

        StairwayThree ->
            { name = "Stairway Three"
            , intro = "A large, wooden stairway"
            , surroundings = "You can't see all the way to the top in this darkness"
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( upstairsKey, UpstairsStairwayThree )
                    , ( southKey, HallwayFour )
                    ]
            , descriptionWhenExamined = ""
            }

        MusicRoom ->
            { name = "Music Room"
            , intro = "A music room"
            , surroundings = "A very pleasant-looking music room, with a grand piano in the center."
            , surroundingsWhenItemUsed = Just "A wall has moved, revealing a hidden room behind it."
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, HallwayFive )
                    , ( eastKey, HallwayFour )
                    , ( southKey, SecretRoomOne )
                    ]
            , descriptionWhenExamined = ""
            }

        HallwayFive ->
            { name = "Hallway Five"
            , intro = "A small hallway"
            , surroundings = "There seem to be a lot of hallways in this place."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, Gym )
                    , ( southKey, MusicRoom )
                    ]
            , descriptionWhenExamined = ""
            }

        Gym ->
            { name = "Gym"
            , intro = "A home gym"
            , surroundings = "There is a piece of paper on the floor."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "This is nicer than any gym I've ever been to."
            , item = Just Keycode
            , availableDirections =
                Dict.fromList
                    [ ( eastKey, SwimmingPool )
                    , ( southKey, HallwayFive )
                    ]
            , descriptionWhenExamined = ""
            }

        SwimmingPool ->
            { name = "Swimming Pool"
            , intro = "An olympic-sized swimming pool"
            , surroundings = "This really is incredible. The smell of chlorine fills the air, and the warmth of the pool can be felt against your skin."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( westKey, Gym )
                    , ( eastKey, Showers )
                    ]
            , descriptionWhenExamined = ""
            }

        Showers ->
            { name = "Showers"
            , intro = "A row of showers"
            , surroundings = "There are a row of showers here, as you'd find in a public simming pool. I wonder how many people live here?"
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( westKey, SwimmingPool )
                    ]
            , descriptionWhenExamined = ""
            }

        SecretRoomOne ->
            { name = "Secret Room One"
            , intro = "A well-hidden room."
            , surroundings = "A room that is completely empty, save for a stone podium with a crest on top of it."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "The room is completely empty, except for the podium in the middle, where you found a crest."
            , item = Just EagleCrest
            , availableDirections =
                Dict.fromList
                    [ ( northKey, MusicRoom )
                    ]
            , descriptionWhenExamined = ""
            }

        StatueRoom ->
            { name = "Statue Room"
            , intro = "A room full of statues."
            , surroundings = "One of them appears to have been beheaded."
            , surroundingsWhenItemUsed = Just "At least they aren't mannequins, but statues aren't much better. One of them has moved aside, revealing a hidden doorway."
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, SecretRoomTwo )
                    , ( eastKey, HallwayThree )
                    , ( southKey, HallwayOne )
                    ]
            , descriptionWhenExamined = ""
            }

        SecretRoomTwo ->
            { name = "Secret Room Two"
            , intro = "A hidden room."
            , surroundings = "The room is cold, and empty, except for a podium in the middle. On it, sits a crest."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "An empty room, except for a lonely looking concrete podium in the middle."
            , item = Just WolfCrest
            , availableDirections =
                Dict.fromList
                    [ ( southKey, StatueRoom )
                    ]
            , descriptionWhenExamined = ""
            }

        HallwayThree ->
            { name = "Hallway Three"
            , intro = "A hallway."
            , surroundings = "This hallway is quite large. There's a locked door to the North with a plaque that reads \"Servants' Quarters\"."
            , surroundingsWhenItemUsed = Just "This hallway is quite large. The door to the servants' quarters is unlocked."
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, ServantsQuarters )
                    , ( westKey, StatueRoom )
                    , ( eastKey, StairwayTwo )
                    , ( southKey, Garage )
                    ]
            , descriptionWhenExamined = ""
            }

        Garage ->
            { name = "Garage"
            , intro = "A large garage."
            , surroundings = "The garage is empty, apart from a few tools. Perhaps one of them could be of some use."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "The garage is empty, apart from a few tools."
            , item = Just Crowbar
            , availableDirections =
                Dict.fromList
                    [ ( northKey, HallwayThree )
                    ]
            , descriptionWhenExamined = ""
            }

        ServantsQuarters ->
            { name = "Servants' Quarters"
            , intro = "The servants' quarters"
            , surroundings = "It's actually pretty nice in here. For some reason, the head of a statue is sitting on a table in the corner."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "It's actaully pretty nice in here. But who were these people serving?"
            , item = Just StatueHead
            , availableDirections =
                Dict.fromList
                    [ ( westKey, ServantsBathroom )
                    , ( southKey, HallwayThree )
                    ]
            , descriptionWhenExamined = ""
            }

        ServantsBathroom ->
            { name = "Servants' Bathroom"
            , intro = "The servants' bathroom"
            , surroundings = "There's not a lot to see in here."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( eastKey, ServantsQuarters )
                    ]
            , descriptionWhenExamined = ""
            }

        StairwayTwo ->
            { name = "Stairway Two"
            , intro = "A stairway."
            , surroundings = "A sturdy-looking staircase sits in a dimly-lit room."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( upstairsKey, UpstairsStairwayTwo )
                    , ( westKey, HallwayThree )
                    ]
            , descriptionWhenExamined = ""
            }

        BasementStairway ->
            { name = "Basement Stairway"
            , intro = "The basement."
            , surroundings = "It's cold. And dark."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( upstairsKey, UtilityRoom )
                    , ( westKey, BasementStorage )
                    , ( eastKey, BasementStorageTwo )
                    , ( southKey, BasementWineCellar )
                    ]
            , descriptionWhenExamined = ""
            }

        BasementStorage ->
            { name = "Basement Storage"
            , intro = "A storage room."
            , surroundings = "There are a few crates down here. Probably nothing too important in them though. There's a door to the North, but it doesn't seem to open from this side."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( eastKey, BasementStairway )
                    ]
            , descriptionWhenExamined = ""
            }

        BasementStorageTwo ->
            { name = "Basement Storage Two"
            , intro = "A small storage room."
            , surroundings = "There's a metal handle on the ground"
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "There's nothing to see here."
            , item = Just Handle
            , availableDirections =
                Dict.fromList
                    [ ( westKey, BasementStairway )
                    ]
            , descriptionWhenExamined = ""
            }

        BasementItemRoom ->
            { name = "Basement Item Room"
            , intro = "A room full of boxes."
            , surroundings = "Amongst the boxes lies a small key."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Just "There's nothing interesting in here any more."
            , item = Just SmallKey
            , availableDirections =
                Dict.fromList
                    [ ( southKey, BasementStorage )
                    ]
            , descriptionWhenExamined = ""
            }

        BasementWasteDisposal ->
            { name = "Basement Waste Disposal"
            , intro = "Ugh, it stinks down here!"
            , surroundings = "The ground is covered in a slimy, horrible, sludge. There is a door to the East."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( eastKey, BasementItemRoom )
                    ]
            , descriptionWhenExamined = ""
            }

        BasementWineCellar ->
            { name = "Basement Wine Cellar"
            , intro = "A gigantic wine cellar."
            , surroundings = "Amazingly, every space is filled, except for one."
            , surroundingsWhenItemUsed = Just "One of the racks has moved, revealing a hidden doorway."
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( northKey, BasementStairway )
                    , ( westKey, BasementLabEntrance )
                    ]
            , descriptionWhenExamined = ""
            }

        BasementLabEntrance ->
            { name = "Basement Lab Entrance"
            , intro = "An entrance...to a laboratory? This is very unusual. There appears to be an entrance to a laboratory here! Unfortunately, as you enter, you succumb to a strange feeling. You're losing conciousness. As you fall to your knees, you can almost make out a voice nearby..."
            , surroundings = "To be continued."
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList
                    [ ( endGameKey, End )
                    ]
            , descriptionWhenExamined = ""
            }

        End ->
            { name = "End"
            , intro = "Congratulations!"
            , surroundings = "Thanks for playing; I'm sorry if this is a bit of an anti-climax, but I'm not really expecting anyone to ever see this message to be honest. If you did, then send me a tweet! @_dnimmo"
            , surroundingsWhenItemUsed = Nothing
            , surroundingsWhenItemPickedUp = Nothing
            , item = Nothing
            , availableDirections =
                Dict.fromList []
            , descriptionWhenExamined = ""
            }
