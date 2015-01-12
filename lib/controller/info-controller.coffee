class @InfoController extends FastRender.RouteController
  tempalte: 'info'

  after: -> document.title = "Info | Reversim Summit 2015"

  data: ->
    page: 'info'