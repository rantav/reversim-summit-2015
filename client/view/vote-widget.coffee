Template.voteWidget.rendered = ->
  @$('[data-toggle="tooltip"]').tooltip()

Template.voteWidget.destroyed = ->
  @$('[data-toggle="tooltip"]').tooltip('destroy')

Template.voteWidget.helpers
  votingEnabled: -> false

Template.voteWidget.events
  'click .vote-up': ->
    u = Meteor.userId()
    if not u
      alertify.log('Please login to vote')
      return
    @toggleVote()
