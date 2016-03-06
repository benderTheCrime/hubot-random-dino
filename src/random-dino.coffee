# Description
#   Post a random dino!
#
# Configuration:
#   NONE
#
# Commands:
#   hubot dino me
#   hubot raptor me
#
# Notes:
#   None
#
# Author:
#   Joe Groseclose <@benderTheCrime>

request = require 'request'

url = 'http://api.giphy.com/v1/gifs/search?api_key=dc6zaTOxFJmzC&q='
dinoUrl = "#{url}dinosaur"
raptorUrl = "#{url}raptor"

module.exports = (robot) ->
  robot.respond /dino me/i, (res) -> getGiphy dinoUrl, res
  robot.respond /raptor me/i, (res) -> getGiphy raptorUrl, res

getGiphy = (url, res = { send: (url) -> console.log url }) ->
  request.get (url || dinoUrl), (e, r, body) ->
    dinos = JSON.parse(body).data

    if !e && r.statusCode == 200
      dino = dinos[ random dinos ]

    res.send dino.images[ 'downsized_medium' ].url

random = (arr) -> Math.floor (Math.random() * arr.length)
