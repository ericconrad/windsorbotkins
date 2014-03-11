# Description:
#   Interacts with the JHU Hub API.
#
# Dependencies:
#   "cheerio": "~0.12.1"
#
# Configuration:
#   HUBOT_HUB_API_KEY
#
# Commands:
#   hubot grab <n> hub articles
#
# Notes:
#   Grabs the latest articles only for now
#
# Author:
#   jasonrhodes

apiKey = process.env.HUBOT_HUB_API_KEY
cheerio = require('cheerio')

module.exports = (robot) ->

  robot.respond /(grab|show me|get|find) (the last )?([\d]+) hub articles/i, (msg) ->

    n = msg.match[3]

    msg.send "grabbing #{n} hub articles brb";
    
    robot.http("http://api.hub.jhu.edu/articles?v=0&key=#{apiKey}&per_page=#{n}")
      .get() (err, res, body) -> 

        payload = JSON.parse(body);
        articles = [];

        articles.push article.headline + ": " + article.url for article in payload._embedded.articles;

        msg.send articles.join "\n"

  robot.respond /hub search (.*)$/, (msg) ->

    robot.http("http://hub.jhu.edu/search?q=" + encodeURIComponent(msg.match[1]))
      .get() (err, res, body) ->

        $ = cheerio.load(body)
        results = $(".search-results .result .title a").slice(0, 3)

        msg.send results.join "\n"
