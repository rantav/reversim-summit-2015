class @AgendaController extends FastRender.RouteController

  after: -> document.title = "Agenda | Reversim Summit 2015"

  waitOn: -> Meteor.subscribe('agenda')

  tempalte: 'agenda'

  data: ->
    page: 'agenda'
    items: AgendaItem.all()