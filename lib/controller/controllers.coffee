class @HomeController extends FastRender.RouteController
  tempalte: 'home'
  after: -> document.title = "Reversim Summit 2015"
  data: -> page: 'home'

class @CommunityController extends FastRender.RouteController
  tempalte: 'community'
  after: -> document.title = "Community | Reversim Summit 2015"
  data: -> page: 'community'

class @InfographicsController extends FastRender.RouteController
  tempalte: 'infographics'
  after: -> document.title = "Infographics | Reversim Summit 2015"
  data: -> page: 'infographics'