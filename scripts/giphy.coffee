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

  # robot.hear /\b(thats|that's)\s+awesome\b/i, (msg) ->
  #   giphy.search msg, "mean girls fetch"

  robot.hear /remember/i, (msg) ->
    giphy.search msg, "the north remembers"
    msg.send "The north remembers"

  robot.hear /\bdo\s+it\b/i, (msg) ->
    giphy.search msg, "shia labeouf do it motivation"

  robot.hear /whoa/i, (msg) ->
    msg.send "http://media.giphy.com/media/FRNQuq6FtiQHC/giphy.gif"
    msg.send "WHoOoOoOoA"

  robot.hear /\b(i\s*(((don\'*t)[^\n]*know)|dunno))|idk\b/i, (msg) ->
    giphy.search msg, "you know nothing jon snow"
    msg.send "You know nothing"

  robot.hear /(?<!:\/\/)(\s|^)(cat|cats|kitten|meow)(\s|$)/i, (msg) ->
    giphy.search msg, "cat"
    msg.send "*meow*"

  robot.hear /\bboop\b/i, (msg) ->
    giphy.search msg, "boop"
