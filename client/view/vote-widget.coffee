Template.voteWidget.rendered = ->
  @$('[data-toggle="tooltip"]').tooltip()

Template.voteWidget.destroyed = ->
  @$('[data-toggle="tooltip"]').tooltip('destroy')

Template.voteWidget.helpers
  votingEnabled: -> true

Template.voteWidget.events
  'click .vote-up': ->
    if Meteor.userId()
      @toggleVote()
    else
      alertify.log('Please login to vote')
      ShowLogin()
