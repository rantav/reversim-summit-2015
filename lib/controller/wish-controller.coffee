class @WishController extends FastRender.RouteController

  waitOn: -> Meteor.subscribe('wishes', _id: @params.id)

  tempalte: 'wish'

  notFoundTemplate: 'notFound'

  data: ->
    wish = Wishes.findOne(_id: @params.id)
    if not wish then return null
    document.title = "#{wish.title} | Reversim Summit 2015"
    {page: 'wish', wish: wish}
