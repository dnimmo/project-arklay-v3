module Main exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Nav
import Data.Game exposing (processSaveData, stateEncoder)
import Data.Item exposing (itemsEncoder)
import Data.Room exposing (roomInfo)
import Data.SaveData as SaveData
import Element exposing (Element, centerX, centerY, el, fill, layout, rgb255, width)
import Element.Background as Background
import Element.Font as Font
import Json.Decode exposing (Error, decodeValue)
import Navigation exposing (Route(..), routeUrlRequest)
import Page.Ending as Ending
import Page.Game as Game
import Page.Intro as Intro
import Ports
import Url exposing (Url)



-- MODEL


type alias Model =
    { key : Nav.Key
    , saveData : Maybe SaveData.Model
    , state : State
    }


type State
    = ViewIntro Intro.Model
    | ViewGame Data.Game.Model
    | ViewEnding



-- UPDATE


type Msg
    = ChangedUrl Url
    | ActivatedLink Browser.UrlRequest
    | IntroMsg Intro.Msg
    | GameMsg Game.Msg
    | GameLoaded (Result Error SaveData.Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- HANDLE LINKS
        ActivatedLink urlContainer ->
            case urlContainer of
                Internal url ->
                    ( model, Nav.pushUrl model.key url.path )

                External _ ->
                    ( model, Cmd.none )

        ChangedUrl url ->
            case routeUrlRequest url of
                Intro ->
                    ( { model
                        | state = ViewIntro <| Intro.initialModel model.saveData
                      }
                    , Cmd.none
                    )

                Game ->
                    ( { model
                        | state = ViewGame Data.Game.initialModel
                      }
                    , Cmd.none
                    )

                Ending ->
                    ( { model
                        | state = ViewEnding
                      }
                    , Cmd.none
                    )

        -- HANDLE EVERYTHING ELSE
        IntroMsg msgReceived ->
            case model.state of
                ViewIntro _ ->
                    let
                        ( updatedIntroModel, command ) =
                            Intro.update msgReceived

                        mappedCommand =
                            Cmd.map IntroMsg command
                    in
                    ( { model
                        | state =
                            ViewIntro updatedIntroModel
                      }
                    , mappedCommand
                    )

                _ ->
                    ( model, Cmd.none )

        GameMsg msgReceived ->
            case model.state of
                ViewGame gameModel ->
                    let
                        ( updatedGameModel, command ) =
                            Game.update msgReceived gameModel

                        mappedCommand =
                            Cmd.map GameMsg command
                    in
                    ( { model
                        | state =
                            ViewGame updatedGameModel
                      }
                    , Cmd.batch
                        [ mappedCommand
                        , Ports.saveGame
                            { inventory = itemsEncoder updatedGameModel.inventory
                            , itemsUsed = itemsEncoder updatedGameModel.itemsUsed
                            , messageDisplayed = updatedGameModel.messageDisplayed
                            , room = roomInfo updatedGameModel.room |> .name
                            , state = stateEncoder updatedGameModel.state
                            }
                        ]
                    )

                _ ->
                    ( model, Cmd.none )

        GameLoaded (Ok saveData) ->
            ( { model
                | state = ViewGame <| processSaveData saveData
              }
            , Cmd.none
            )

        GameLoaded (Err _) ->
            ( { model
                | state = ViewGame Data.Game.initialModel
              }
            , Cmd.none
            )



-- VIEW


chooseTitle : State -> String
chooseTitle state =
    case state of
        ViewIntro _ ->
            "Project Arklay | Intro"

        ViewGame { room } ->
            let
                { name } =
                    roomInfo room
            in
            "Project Arklay | " ++ name

        ViewEnding ->
            "Project Arklay | Thanks for playing!"


chooseBody : Model -> Element Msg
chooseBody { key, state } =
    let
        body =
            case state of
                ViewIntro hasStarted ->
                    Element.map (\msg -> IntroMsg msg) <| Intro.view key hasStarted

                ViewGame gameModel ->
                    Element.map (\msg -> GameMsg msg) <| Game.view key gameModel

                ViewEnding ->
                    Ending.view
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



-- INIT


init : Maybe SaveData.Model -> Url -> Nav.Key -> ( Model, Cmd Msg )
init saveData url navKey =
    update (ChangedUrl url)
        { key = navKey
        , saveData = saveData
        , state = ViewIntro <| Intro.initialModel saveData
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch [ Ports.gameLoaded <| GameLoaded << decodeValue SaveData.decoder ]



-- MAIN


main : Program (Maybe SaveData.Model) Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ActivatedLink
        }
