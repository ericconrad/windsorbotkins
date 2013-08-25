# Description:
#   Grabs a gif from bukk.it
#
# Dependencies:
#   "cheerio": "~0.12.1"
#
# Configuration:
#   None
#
# Commands:
#   windsor gif me
#
# Notes:
#   gifs may not be safe for work
#
# Author:
#   jasonrhodes

cheerio = require('cheerio')

module.exports = (robot) ->

    robot.respond /gif me/i, (msg) ->
        robot.http("http://bukk.it")
            .get() (err, res, body) ->
                $ = cheerio.load body
                images = $("td > a")
                msg.send "http://bukk.it/" + $(msg.random images).attr("href")