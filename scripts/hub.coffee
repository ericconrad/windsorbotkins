# Description:
#   Interacts with the JHU Hub API.
#
# Commands:
#   hoppy grab 3 hub articles - Returns recent Hub articles for now.

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