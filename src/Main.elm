module Main exposing (..)

import Browser

import Http
import Json.Decode exposing (Decoder, field, float)

import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- Model


type alias Flags =
  { apiKey : String }

type Weather
  = Loading
  | Failure
  | Success Float

type alias Model = 
  {
    location: String
  , weather:  Weather
  , flags:    Flags
  }


init: (Flags) -> (Model, Cmd Msg)
init flags = 
  let
      model = Model "Calgary" Loading flags
  in
    (model, syncWeather model )



--- Http



syncWeather: Model -> Cmd Msg
syncWeather model = Http.get
  { url = String.concat ["https://api.openweathermap.org/data/2.5/weather?q=", model.location, "&appid=", model.flags.apiKey]
  , expect = Http.expectJson GotWeather weatherDecoder
  }

weatherDecoder: Decoder Float
weatherDecoder =
  field "main" (field "temp" float)



--- Update


type Msg 
 = Location String 
 | GotWeather (Result Http.Error Float)


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    Location location ->
      ({ model | location = location }, Cmd.none)

    GotWeather result ->

      case result of

        Ok temp ->
          ({ model | weather = Success temp }, Cmd.none)

        Err _ ->
          ({ model | weather = Failure }, Cmd.none)
  


--- Subscriptions


subscriptions: Model -> Sub Msg
subscriptions model = Sub.none



--- View



view: Model -> Html Msg
view model =
  case model.weather of

    Loading ->
      text "Loading"

    Failure ->
      text "Oops something went wrong"

    Success temp ->
       div []
        [ input [ placeholder "City location", value model.location, onInput Location ] []
        , div [] [ text (String.fromFloat temp) ]
        ]



--- Main

main: Program Flags Model Msg
main = Browser.element
  { init = init
  , update = update
  , view = view
  , subscriptions = subscriptions
  }


