class @RegisterController extends FastRender.RouteController

  after: -> document.title = "Register | Reversim Summit 2015"

  tempalte: 'register'

  data: ->
    page: 'register'