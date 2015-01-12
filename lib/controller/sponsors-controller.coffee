class @SponsorsController extends FastRender.RouteController

  waitOn: ->
    Meteor.subscribe('sponsors')

  after: -> document.title = "Sponsors | Reversim Summit 2015"

  tempalte: 'sponsors'

  data: ->
    page: 'sponsors'
    sponsors: _.shuffle(Sponsor.all())
