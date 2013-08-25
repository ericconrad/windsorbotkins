# Description:
#   Gives information about a query from a list of sources
#

cheerio = require('cheerio')

module.exports = (robot) ->

  # Recursive get request that follows Wikipedia redirects
  getwiki = (person, callback, url) ->
    url = url || "http://en.wikipedia.org/wiki/#{person}"
    robot.http(url)
      .get() (err, res, body) ->
        if res.headers.location
          getwiki person, callback, res.headers.location

        else
          $ = cheerio.load body
          content = $ "#mw-content-text"
          noarticle = $ "#mw-content-text > .noarticletext a[title^='Special:Search']"
          searchresults = $ "#mw-content-text > .searchresults"

          if noarticle.length > 0
            href = "http://en.wikipedia.org" + $(noarticle).attr "href"
            getwiki person, callback, href

          else if searchresults.length > 0
            searchresults.find(".mw-search-createlink").remove()
            headings = searchresults.find(".mw-search-result-heading")

            if headings.length > 0
              links = headings.map((i, el) -> 
                link = $(el).find("a")
                $(link).text() + " - http://en.wikipedia.org" + $(link).attr("href")
              ).slice(0,5)
              callback "Try these?\n" + links.join "\n"

            else
              callback noresults.text()

          else 
            canonical = $("head link[rel='canonical']");
            callback $, $(canonical).attr('href'), person


  robot.respond /tell (\w+) about (.*)/i, (msg) ->
    wiki = getwiki msg.match[2], ($, url, person) ->
      if !url && !person
        msg.send "No Wikipedia results found for '#{msg.match[2]}'"
        msg.send $
      else
        content = $("#mw-content-text")
        paras = content.find("p")
        msg.send $(paras[0]).text() + "\n" + $(paras[1]).text()
        msg.send url

      imageMe msg, "#{msg.match[2]}", false, false, (url) ->
        msg.send url


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