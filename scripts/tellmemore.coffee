# Description:
#   Interacts with the JHU Hub API.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   shh it's a secret (try saying 'tell me more' or mentioning something is 'a trap')
#
# Notes:
#   gifs may not be safe for work
#
# Author:
#   jasonrhodes


module.exports = (robot) ->

  robot.hear /tell me more(.*)/i, (msg) ->
    imageMe msg, "condescending wonka tell me more #{msg.match[1]}", false, false, (url) ->
        msg.send "Yes, please tell us more...";
        msg.send url

  robot.hear /a trap/i, (msg) ->
    imageMe msg, "ackbar it's a trap", false, false, (url) ->
      msg.send url

  robot.hear /(ketchup|catsup|heinz)/i, (msg) ->
    imageMe msg, msg.match[1], false, false, (url) ->
      msg.send "Hey, Eric loves #{msg.match[1]}!\n#{url}"



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
        msg.send "No no image no findy but I wanted to but no :("