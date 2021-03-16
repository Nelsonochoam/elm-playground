var path = require('path');
var webpack = require('webpack');

require('dotenv').config();


module.exports = {
  // If your entry-point is at "src/index.js" and
  // your output is in "/dist", you can ommit
  // these parts of the config
  module: {
    rules: [{
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file-loader'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: {
        loader: 'elm-webpack-loader',
        options: {}
      }
      }
    ],
  },

  devServer: {
    contentBase: path.join(__dirname, "src"),
    stats: 'errors-only'
  },


  // Plugins to handle injecting environment variables
  plugins: [
    new webpack.EnvironmentPlugin(["ELM_APP_OPEN_WEATHER_KEY"]),
  ],

};
