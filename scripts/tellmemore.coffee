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

  robot.hear /tell me more/i, (msg) ->
    imageMe msg, "condescending wonka tell me more", false, false, (url) ->
      msg.send url;
      msg.send "Yes, please tell us more..."

  robot.hear /a trap/i, (msg) ->
    imageMe msg, "ackbar it's a trap", false, false, (url) ->
      msg.send url

  robot.hear /(ketchup|catsup|heinz)/i, (msg) ->
    imageMe msg, msg.match[1], false, false, (url) ->
      msg.send "Hey! @eric loves #{msg.match[1]}!"

  robot.hear /mock[\s\-]*up/i, (msg) ->
    messages = ['Mock up? More like mock down amiright?', 'I want to MOCK that mock up #uptop', 'Worst. Mock-up. Ever.', "I want to send that mock up UP into the sky because I kicked it the way you would kick something that you didn't like very much"]
    msg.send msg.random messages

  robot.hear /pretty (cool|kewl)/i, (msg) ->
    messages = ["I've seen cooler #justsayin", "Hmm maybe but maybe not, y'know?", "More like 'cool pretty' amiright?\n\n...\n\nGuys?", "No."]
    msg.reply msg.random messages

  robot.hear /^windor/i, (msg) ->
    msg.reply "Nope! #embracethes"

  robot.hear /jason/i, (msg) ->
    imageMe msg, "ben kenobi name i havent heard", false, false, (url) ->
      msg.send url
      msg.send "Now, that's a name I've not heard in a long time."

  robot.hear /rhodes/i, (msg) ->
    imageMe msg, "doc brown we dont need roads", false, false, (url) ->
      msg.send url
      msg.send "Rhodes? Where we're going, we don't need Rhodes."

  robot.hear /when/i, (msg) ->
    messages = ["Some time before the Wordpress migration, I'd say.", "That's definitely going to have to wait until after the Wordpress migration.", "When? Are you sure you didn't want who, what, where, why or how?", "The dentist's favorite time! Tooth hurty.\n\n...Tooth...\n\n...Hurty...", "Once upon a time..."]
    msg.reply msg.random messages

  robot.hear /not sure if/i, (msg) ->
    imageMe msg, "fry not sure if", false, false, (url) ->
      msg.send url

  robot.hear /college/i, (msg) ->
    imageMe msg, "napoleon dynamite your mom goes to college", true, false, (url) ->
      msg.send url

  robot.hear /(cant|can't) decide/i, (msg) ->
    imageMe msg, "curb your enthusiasm can't decide", true, false, (url) ->
      msg.send url

  robot.hear /neat/i, (msg) ->
    imageMe msg, "futurama bender neat", true, false, (url) ->
      msg.send url

  robot.hear /(good|great) news/i, (msg) ->
    imageMe msg, "futurama good news everyone", true, false, (url) ->
      msg.send url

  robot.hear /crush/i, (msg) ->
    imageMe msg, "chris davis home run", true, false, (url) ->
      msg.send url
      msg.send "Crush Davis?"

  robot.hear /what[^"^\n]*you[^"^\n]*doing/i, (msg) ->
    imageMe msg, "snl the californians ", true, false, (url) ->
      msg.send url

  robot.hear /sounds good/i, (msg) ->
    messages = ["Does it?", "If you say so.", "No it doesn't.", "You sound good", "Of all the sounds in all the languages of all the species on all the planets in all the galaxies in all the universe, that does sound the goodest"]
    msg.send msg.random messages

  robot.hear /windsor\s*(should|could|to|do)[^"^\n]*(do|say|give|return|that|this|be|act)/i, (msg) ->
    msg.send "Agreed. @eric get on it ^^"


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
