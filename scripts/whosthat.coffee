# Description:
#   Gives information about a person
#

cheerio = require('cheerio')
$ = cheerio.load

module.exports = (robot) ->

  # Recursive get request that follows Wikipedia redirects
  getinfo = (person, callback, url) ->
    url = url || "http://en.wikipedia.org/wiki/#{person}"
    robot.http(url)
      .get() (err, res, body) ->
        if res.headers.location
          getinfo(person, callback, res.headers.location)
        else
          callback(body, url, person)


  robot.respond /(\w+) doesn't know who ([\w\s]+) is/i, (msg) ->
    wiki = getinfo msg.match[2], (body, url, person) ->
      $ = cheerio.load(body)
      content = $("#mw-content-text")
      paras = content.find("p")
      msg.send $(paras[0]).text() + "\n" + $(paras[1]).text()
      msg.send "Source: " + url

      imageMe msg, "#{person}", false, false, (imageUrl) ->
        msg.send imageUrl


imageMe = (msg, query, animated, faces, cb) ->
  cb = animated if typeof animated == 'function'
  cb = faces if typeof faces == 'function'
  q = v: '1.0', rsz: '8', q: query, safe: 'active'
  q.imgtype = 'animated' if typeof animated is 'boolean' and animated is true
  q.imgtype = 'face' if typeof faces is 'boolean' and faces is true
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData?.results
      if images?.length > 0
        image  = msg.random images
        cb "#{image.unescapedUrl}#.png"
      else
        "No images found"