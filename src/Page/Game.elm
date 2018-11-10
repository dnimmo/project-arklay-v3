module Page.Game exposing (Model, Msg, initialModel, update, view)

import Data.Room as Room exposing (Room)
import Element exposing (Element, fill, paragraph, text, width, wrappedRow)
import View.Layout exposing (mainLayout)



-- MODEL


type alias Model =
    { room : Room
    , inventory : List String
    , displayInventory : Bool
    }


initialModel : Model
initialModel =
    { room = Room.startingRoom
    , inventory = []
    , displayInventory = False
    }



-- UPDATE


type Msg
    = ToggleInventory
    | UseItem
    | ChangeRoom
    | ExamineRoom


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleInventory ->
            ( { model
                | displayInventory = not model.displayInventory
              }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Element Msg
view { room, inventory, displayInventory } =
    mainLayout
        [ wrappedRow
            [ width fill ]
            [ paragraph [] [ text room.intro ] ]
        ]
