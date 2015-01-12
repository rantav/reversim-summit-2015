class @ProposeController extends FastRender.RouteController
  waitOn: -> Meteor.subscribe('users', {_id: Meteor.userId()})
  template: 'propose'

  after: -> document.title = "Propose | Reversim Summit 2015"

  data: ->
    page: 'propose'


