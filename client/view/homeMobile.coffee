Template.homeMobile.events
  'click li': (event)->
    Router.go(event.target.className)

Template.homeMobile.helpers

  users: -> User.count()

  isSpeaker: ->
    cur = User.current()
    cur and cur.speaker()

  user: -> User.current()

  canSeeHidden: ->
    user = User.current()
    user and (user.admin() or user.moderator())

  hasCount: (col) -> Counts.findOne(col)

count = (col) ->
  data = Counts.findOne(col)
  if data then return data.count
