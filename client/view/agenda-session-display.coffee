Template.agendaSessionDisplay.helpers
  splits:  ->
    if @ then @split(',')

  isSession:  -> !!Proposal.find(String(@))

  session: -> Proposal.find(String(@))

  speakers: -> @speakers()

  photo:  (user) -> user.photoUrl(40) if user

  hallOfShame:  -> @toString() == 'The Hall of Shame'

Template.agendaSessionDisplay.rendered = ->
    @$('[data-toggle="tooltip"]').tooltip()

Template.agendaSessionDisplay.destroyed = ->
  @$('[data-toggle="tooltip"]').tooltip('destroy')
