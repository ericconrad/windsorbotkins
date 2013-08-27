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

module.exports = (robot) ->

  robot.respond /(grab|show me|get|find) (the last )?([\d]+) hub articles/i, (msg) ->

    n = msg.match[3]
    apiKey = process.env.HUBOT_HUB_API_KEY

    msg.send "grabbing #{n} hub articles brb";
    
    robot.http("http://api.hub.jhu.edu/articles?v=0&key=#{apiKey}&per_page=#{n}")
      .get() (err, res, body) -> 

        payload = JSON.parse(body);
        articles = [];

        articles.push article.headline + ": " + article.url for article in payload._embedded.articles;

        msg.send articles.join "\n"