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

imageMe = require('hubot-google-images').imageMe

module.exports = (robot) ->

  robot.hear /tell me more/i, (msg) ->
    imageMe msg, "condescending wonka tell me more", false, false, (url) ->
      msg.send url;
      msg.send "Yes, please tell us more..."

  robot.hear /a trap/i, (msg) ->
    imageMe msg, "ackbar it's a trap", false, false, (url) ->
      msg.send url

  # robot.hear /(ketchup|catsup|heinz)/i, (msg) ->
  #   imageMe msg, msg.match[1], false, false, (url) ->
  #     msg.send "Hey! @eric loves #{msg.match[1]}!"

  robot.hear /mock[\s\-]*up/i, (msg) ->
    messages = ['Mock up? More like mock down amiright?', 'I want to MOCK that mock up #uptop', 'Worst. Mock-up. Ever.', "I want to send that mock up UP into the sky because I kicked it the way you would kick something that you didn't like very much"]
    msg.send msg.random messages

  robot.hear /pretty\s+(cool|kewl)/i, (msg) ->
    messages = ["I've seen cooler #justsayin", "Hmm maybe but maybe not, y'know?", "More like 'cool pretty' amiright?\n\n...\n\nGuys?", "No."]
    msg.reply msg.random messages

  # robot.hear /^windor/i, (msg) ->
  #   msg.reply "Nope! #embracethes"

  # robot.hear /jason/i, (msg) ->
  #   imageMe msg, "ben kenobi name i havent heard", false, false, (url) ->
  #     msg.send url
  #     msg.send "Jason? Now, that's a name I've not heard in a long time."
  #
  # robot.hear /rhodes/i, (msg) ->
  #   imageMe msg, "doc brown we dont need roads", false, false, (url) ->
  #     msg.send url
  #     msg.send "Rhodes? Where we're going, we don't need Rhodes."

  # robot.hear /\b((when\s+(do|should|shouldnt|shouldn't|could|couldnt|couldn't|is|are|arent|aren't)\b)|(when\?|when(\n|$)))/i, (msg) ->
  #   messages = ["Some time before the Wordpress migration.", "That's definitely going to have to wait until after the Wordpress migration.", "Now", "Later", "Now & Later"]
  #   msg.reply msg.random messages

  robot.hear /\bnot\s+sure\s+if\b/i, (msg) ->
    imageMe msg, "fry not sure if", false, false, (url) ->
      msg.send url

  robot.hear /college/i, (msg) ->
    imageMe msg, "napoleon dynamite your mom goes to college", true, false, (url) ->
      msg.send url

  robot.hear /\b(cant|can't)\s+decide\b/i, (msg) ->
    imageMe msg, "curb your enthusiasm can't decide", true, false, (url) ->
      msg.send url

  robot.hear /(neat|neato)/i, (msg) ->
    imageMe msg, "futurama bender neat", true, false, (url) ->
      msg.send url

  robot.hear /\b(good|great)\s+news\b/i, (msg) ->
    imageMe msg, "futurama good news everyone", true, false, (url) ->
      msg.send url

  # robot.hear /@dave/i, (msg) ->
  #   imageMe msg, "chris davis home run", true, false, (url) ->
  #     msg.send url
  #     msg.reply "Did you mean @crush?"

  # robot.hear /\b(what[^\n]+you[^\n]+doing)|(califnorian[s]*)\b/i, (msg) ->
  #   imageMe msg, "snl the californians ", true, false, (url) ->
  #     msg.send url

  robot.hear /\bsounds\s+good\b/i, (msg) ->
    messages = ["Does it?", "If you say so.", "No it doesn't.", "You sound good", "Of all the sounds in all the languages of all the species on all the planets in all the galaxies in all the universe, that sounds the least good."]
    msg.reply msg.random messages

  robot.hear /\bbeans\s+(should|could|to|do)[^\n]+(do|say|give|return|that|this|be|act)\b/i, (msg) ->
    messages = ["Agreed. @eric get on it ^^", "Totes", "You know it", "Actually I shouldn't, but thanks anyway", "How about, no?", "Nah"]
    msg.send msg.random messages

  robot.hear /(moist|panties|slacks|ladies)/i, (msg) ->
    messages = ["Could you not", "plz no", "http://media.giphy.com/media/11w0l0hDWECDJK/giphy.gif", "http://media.giphy.com/media/js6YTUxKVjH3y/giphy.gif", "http://media.giphy.com/media/KLMmqAB5UbEHK/giphy.gif"]
    msg.reply msg.random messages

  # robot.hear /(\b|\@)wo\b/i, (msg) ->
  #   msg.reply "Yes Grubb?"
  #
  # robot.hear /(\b|\@)grubb\b/i, (msg) ->
  #   msg.reply "Yo, Wo!"

  robot.hear /the best/i, (msg) ->
    msg.send "It's the best, @#{msg.message.user.mention_name}. The best!"
    msg.send "https://localtvwiti.files.wordpress.com/2014/01/bania.jpg"

  robot.hear /hjesus/i, (msg) ->
    msg.send "I bring you salvation and salvation accessories."
    msg.send "https://c1.staticflickr.com/1/590/22678847867_6d26301634_o.png"


# imageMe = (msg, query, animated, faces, cb) ->
#   cb = animated if typeof animated == 'function'
#   cb = faces if typeof faces == 'function'
#   q = v: '1.0', rsz: '8', q: query, safe: 'active'
#   q.imgtype = 'animated' if typeof animated is 'boolean' and animated is true
#   q.imgtype = 'face' if typeof faces is 'boolean' and faces is true
#   msg.http('http://ajax.googleapis.com/ajax/services/search/images')
#     .query(q)
#     .get() (err, res, body) ->
#       images = JSON.parse(body)
#       images = images.responseData?.results
#       if images?.length > 0
#         image  = msg.random images
#         cb "#{image.unescapedUrl}#.png"
#       else
#         msg.send "No no image no findy but I wanted to but no :("
