require('./index.html');

var flags = {
  apiKey: process.env.ELM_APP_OPEN_WEATHER_KEY,
}

var Elm = require('./Main.elm').Elm;

var app = Elm.Main.init({
  node: document.getElementById('main'),
  flags: flags,
})
