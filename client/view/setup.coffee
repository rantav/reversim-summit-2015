Template.setup.rendered = ->
  setupGa()

setupGa = ->
  if !window.ga?
    (
      (i, s, o, g, r, a, m) ->
        i['GoogleAnalyticsObject'] = r
        i[r] = i[r] || -> (i[r].q = i[r].q || []).push(arguments)
        i[r].l = 1 * new Date()
        a = s.createElement(o)
        m = s.getElementsByTagName(o)[0]
        a.async = 1
        a.src = g
        m.parentNode.insertBefore(a, m)
    )(window, document, 'script', '//www.google-analytics.com/analytics.js','ga')
    ga('create', 'UA-36904731-3', 'reversim.com')

  ga('send', 'pageview',
    'page': document.location.pathname,
    'location': document.location.href)

Meteor.startup ->
  marked.setOptions
    gfm: true,
    tables: true,
    breaks: true,
    pedantic: false,
    sanitize: true,
    smartLists: true,
    smartypants: false,