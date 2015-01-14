Template.wish.events
  'click .delete':  ->
    Wish.delete(@wish)
    Router.go 'wishes'
    alertify.success('OK, Deleted')

  'click .edit':  ->
    Wishes.update(@wish._id, $set: editing: (not @wish.editing))

  'click .save': (event, context) ->
    title = context.find("#title-#{@wish._id}").value
    description = context.find("#description-#{@wish._id}").value
    Wishes.update(@wish._id, $set: {editing: false, title: title, description: description})

  'click .vote-up': ->
    u = Meteor.userId()
    if not u
      alertify.log('Please login to vote')
      return

    updateObj  = {}
    schemaPath = "votes.#{u}"
    updateObj[schemaPath] = not @wish.votes[u]

    Wishes.update(@wish._id, $set: updateObj)

wish = null

Template.wish.helpers
  wish: ->
    wish = @wish
    @wish

  wishObj: -> new Wish(@wish)

  positiveVotes: ->
    user for user, vote of @wish.votes when vote

  photo: (userId) ->
    userId and User.find(userId).photoUrl(40)

  photoSmall: (userId) ->
    userId and User.find(userId).photoUrl(20)

  owns: (wish) -> owns(wish)

  editMode: ->
    owns(@wish) and @wish.editing

# Does the current user own the wish?
owns = (wish) ->
  u = Meteor.userId()
  wish and u and wish.owner == u

Template.wish.rendered = ->
  window.disqus_url = Router.fullPath('wish', id: wish._id)
  $('[data-toggle="tooltip"]').tooltip()

Template.wish.destroyed = ->
  $('[data-toggle="tooltip"]').tooltip('destroy')

