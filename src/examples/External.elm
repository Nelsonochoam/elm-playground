module External exposing (..)

import Browser
import Html exposing (Html, text, pre)
import Http


-- MODEL

main = 
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


type Model
  = Failure
  | Loading
  | Success String

init: () -> (Model, Cmd Msg)
init _ =
  ( Loading
  , Http.get
    { url = "https://elm-lang.org/assets/public-opinion.txt"
    , expect = Http.expectString  GoText
    }
  )


-- UPDATE

type Msg
  = GoText (Result Http.Error String)

update: Msg -> Model ->(Model, Cmd Msg)
update msg model =
  case msg of
    GoText result ->
      case result of
        Ok fullText ->
          (Success fullText, Cmd.none)

        Err _ ->
          (Failure, Cmd.none)
         


-- SUBSCRIPTIONS

subscriptions: Model -> Sub Msg
subscriptions model = Sub.none


-- VIEW

view: Model -> Html Msg
view model =
  case model of
    Failure ->
      text "I was unable to load your book"

    Loading ->
      text "Loading..."

    Success fullText ->
      pre [] [ text fullText ]





