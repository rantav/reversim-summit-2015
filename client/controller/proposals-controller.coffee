class @ProposalsController extends RouteController

  waitOn: ->
    [Meteor.subscribe('proposals'), subscriptionHandles['users']]

  tempalte: 'proposals'
  renderTemplates:
    'nav': to: 'nav'

  data: ->
    page: 'proposals'