class @S2013Controller extends FastRender.RouteController
  tempalte: 's2013'

  after: -> document.title = "2013 | Reversim Summit 2015"

  data: ->
    page: 's2013'