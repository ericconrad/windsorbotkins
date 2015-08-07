# Commands:
#   giphy <term> - Returns a randomly selected gif from a search of the giphy api for <term>

giphy =
  api_key: process.env.HUBOT_GIPHY_API_KEY
  api_url: 'http://api.giphy.com/v1'


  search: (msg, q, callback) ->
    endpoint = '/gifs/search'
    url = "#{giphy.api_url}#{endpoint}"
    msg.http(url)
      .query
        api_key: giphy.api_key
        q: q
      .get() (err, res, body) ->
        res = JSON.parse(body)
        data = res?.data || []
        if data.length
          img_obj = msg.random data
          msg.send(img_obj.images.original.url)
        else
          msg.send "No results found for #{q}"

module.exports = (robot) ->
  robot.hear /^giphy (.*)$/i, (msg) ->
    giphy.search msg, msg.match[1]

  robot.hear /^gif( )?me (.*)$/i, (msg) ->
    giphy.search msg, msg.match[2]

  robot.respond /gif( me| this)? (.*)$/i, (msg) ->
    giphy.search msg, msg.match[2]

  robot.hear /(cant|can't) decide/i, (msg) ->
    giphy.search msg, "curb your enthusiasm can't decide"

  robot.hear /college/i, (msg) ->
    giphy.search msg, "napoleon dynamite your mom goes to college"

  robot.hear /(thats|that's) awesome/i, (msg) ->
    giphy.search msg, "mean girls fetch"

  robot.hear /remember/i, (msg) ->
    giphy.search msg, "the north remembers"
    msg.send "The north remembers"

  robot.hear /do it/i, (msg) ->
    giphy.search msg, "shia labeouf do it"
