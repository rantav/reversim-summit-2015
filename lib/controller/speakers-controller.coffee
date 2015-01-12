class @SpeakersController extends FastRender.RouteController

  waitOn: -> Meteor.subscribe('proposals')

  after: -> document.title = "Speakers | Reversim Summit 2015"

  tempalte: 'speakers'

  data: ->
    page: 'speakers'
    speakers: User.allSpeakers()