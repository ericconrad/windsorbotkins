# Description:
#   Interacts with the JHU Hub API.
#
# Commands:
#   hubot hub me - Returns recent Hub articles for now.

module.exports = (robot) ->

  # robot.respond /hub me/i, (msg) ->

  #   msg.http("http://api.hub.jhu.edu/articles?v=0&key=billcosby&per_page=3") (err, res, body) -> 

  #     payload = JSON.parse(body);

  #     msg.send article.url for article in payload._embedded.articles

  robot.respond /test test/i, (msg) ->

    msg.send "you tested it"
