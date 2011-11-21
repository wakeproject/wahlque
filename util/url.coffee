###
  url.coffee

  util methods for url handling
###
define 'cs!url', ["exports"], (url) ->

    # get all params
    url.params = (url) ->
        ps = {}
        a = /\+/g
        r = /([^&=]+)=?([^&]*)/g
        d = (s) -> decodeURIComponent(s.replace(a, " "))
        q = url ? window.location.search.substring(1)
        while (e = r.exec(q))
            ps[d(e[1])] = d(e[2])
        ps

