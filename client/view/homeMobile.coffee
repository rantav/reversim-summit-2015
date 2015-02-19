Template.homeMobile.events
  'click a': (event, context)->
    LayoutManager.hideNav(context)

Template.homeMobile.helpers

  activeClass:  (name) ->
    if @page == name then 'active' else ''

  wishes: -> count('wishes')

  proposals: -> count('proposals')

  speakers: -> count('speakers')

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
