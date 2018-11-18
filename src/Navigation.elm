module Navigation exposing (Route(..), endingPath, gamePath, introPath, routeUrlRequest)

import Url exposing (Url)


type Route
    = Intro
    | Game
    | Ending


introPath =
    "intro"


gamePath =
    "game"


endingPath =
    "ending"


routeUrlRequest : Url -> Route
routeUrlRequest url =
    if url.path == "/" ++ introPath then
        Intro

    else if url.path == "/" ++ gamePath then
        Game

    else if url.path == "/" ++ endingPath then
        Ending

    else
        Intro
