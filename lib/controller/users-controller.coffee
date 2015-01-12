class @UsersController extends FastRender.RouteController

  waitOn: -> Meteor.subscribe('users')

  after: -> document.title = "Users | Reversim Summit 2015"

  tempalte: 'users'

  data: ->
    page: 'users'

