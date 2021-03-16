# elm-playground
Just me testing out elm. The examples folder contains some basic examples of doing basic things
described on the elm guide  https://guide.elm-lang.org/

What I am trying to build starting from Main.elm is a tiny weather dashboard using the
https://openweathermap.org/ api.


# Setup 
1) Create a .env file and add 

ELM_APP_OPEN_WEATHER_KEY=<YOUR_WEATHER_API_KEY>

2) Run 

`elm make src/Main.elm --output=elm.js`


3) Run the app

`open index.html`


# Other

To test the exampled run `elm reactor` and navigate to the files that contain the
examples
