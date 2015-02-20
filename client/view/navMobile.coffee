Template.navMobile.events
  'click a': (event, context)->
    if event.target.parentElement.getAttribute('id') != 'login-dropdown-list'
      LayoutManager.hideNav(context)

Template.navMobile.helpers

  activeClass:  (name) ->
    if @page == name then 'active' else ''

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
