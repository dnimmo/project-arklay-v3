module Main exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Nav
import Element exposing (Element, centerX, centerY, el, fill, layout, rgb255, width)
import Element.Background as Background
import Element.Font as Font
import Html exposing (text)
import Navigation exposing (Route(..), routeUrlRequest)
import Page.Intro as Intro
import Url exposing (Url)



-- MODEL


type alias Model =
    { key : Nav.Key
    , state : State
    }


type State
    = ViewIntro Intro.Model



-- VIEW


chooseTitle : State -> String
chooseTitle state =
    case state of
        ViewIntro _ ->
            "Project Arklay | Intro"


chooseBody : Model -> Element Msg
chooseBody { key, state } =
    let
        body =
            case state of
                ViewIntro hasStarted ->
                    Element.map (\x -> IntroMsg x) <| Intro.view key hasStarted
    in
    body


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
                chooseBody model
        ]
    }



-- UPDATE


type Msg
    = ChangedUrl Url
    | ActivatedLink Browser.UrlRequest
    | IntroMsg Intro.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- HANDLE LINKS
        ActivatedLink urlContainer ->
            case urlContainer of
                Internal url ->
                    ( model, Nav.pushUrl model.key url.path )

                External path ->
                    ( model, Cmd.none )

        ChangedUrl url ->
            case routeUrlRequest url of
                Intro ->
                    ( { model
                        | state = ViewIntro Intro.initialModel
                      }
                    , Cmd.none
                    )

                Game ->
                    ( { model
                        | state = ViewIntro Intro.initialModel
                      }
                    , Cmd.none
                    )

        -- HANDLE EVERYTHING ELSE
        IntroMsg msgReceived ->
            case model.state of
                ViewIntro hasStarted ->
                    let
                        ( updatedIntroModel, command ) =
                            Intro.update msgReceived hasStarted

                        mappedCommand =
                            Cmd.map IntroMsg command
                    in
                    ( { model
                        | state =
                            ViewIntro updatedIntroModel
                      }
                    , mappedCommand
                    )



-- INIT


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    update (ChangedUrl url) { key = navKey, state = ViewIntro Intro.initialModel }



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
