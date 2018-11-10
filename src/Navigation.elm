module Navigation exposing (Route(..), gamePath, introPath, routeUrlRequest)

import Url exposing (Url)


type Route
    = Intro
    | Game


introPath =
    "intro"


gamePath =
    "game"


routeUrlRequest : Url -> Route
routeUrlRequest url =
    if url.path == "/" ++ introPath then
        Intro

    else if url.path == "/" ++ gamePath then
        Game

    else
        Intro
