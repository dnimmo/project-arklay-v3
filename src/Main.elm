module Main exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Nav
import Element exposing (Element, centerX, centerY, el, fill, layout, rgb255, width)
import Element.Background as Background
import Element.Font as Font
import Html exposing (text)
import Page.Intro as Intro
import Url exposing (Url)



-- MODEL


type alias Model =
    { key : Nav.Key
    , state : State
    }


type State
    = ViewIntro



-- VIEW


chooseTitle : State -> String
chooseTitle state =
    case state of
        ViewIntro ->
            "Project Arklay"


chooseBody : State -> Element msg
chooseBody state =
    case state of
        ViewIntro ->
            Intro.view


view : Model -> Document Msg
view model =
    { title = chooseTitle model.state
    , body =
        [ layout
            [ Background.color <| rgb255 20 20 24
            , Font.color <| rgb255 250 250 250
            , Font.center
            , width fill
            ]
          <|
            el
                [ centerX
                , centerY
                , width fill
                ]
            <|
                chooseBody model.state
        ]
    }



-- UPDATE


type Msg
    = ChangedUrl Url
    | ActivatedLink Browser.UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- INIT


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    update (ChangedUrl url) { key = navKey, state = ViewIntro }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ActivatedLink
        }
