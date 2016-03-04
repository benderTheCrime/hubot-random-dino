# Description
#   A hubot script that does the things
#
# Configuration:
#   NONE
#
# Commands:
#   hubot emergency compliment <username> - Responds to the user with a compliment
#
# Notes:
#   If <username> is "me" the script will respond to the user who sent the message
#   Added an easter egg for our good friend Tom Blair
#
# Author:
#   Joe Groseclose <@benderTheCrime>

request = require 'request'

module.exports = (robot) ->
  robot.respond /emergency (compliment )?(.*)/i, (res) ->
    username = res.match[ 2 ]
    username = msg.message.user.name if username == 'me'
    compliment = "I like the cut of your jib, @#{username}"

    request.get 'http://emergencycompliment.com/index.html', (e, r, body) ->
      complimentMatch = body.match /\<p class="compliment">(.*)<\/p>/g

      if !e && r.statusCode == 200
        compliment = "@#{username}, #{complimentMatch[ 0 ]}"

        if /tj|tom\sblair/.test username
          compliment += ' :millenial: #appreciatetjday'

      res.send compliment