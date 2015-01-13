Template.users.events
  'click input[name=admin]': (event, context)->
    val = event.srcElement.checked
    @update('roles.admin': val)

  'click input[name=moderator]': ->
    val = event.srcElement.checked
    @update('roles.moderator': val)

  'click .delete':  ->
    @destroy()
    alertify.success('OK, Deleted')

Template.users.helpers

  allowed: ->
    user = User.current()
    user and (user.admin() or user.moderator())

  users: -> User.all()

  photo: (user) -> user.photoUrl(40)

  disabledStr: ->
    user = User.current()
    if not (user and user.admin())
      'disabled'

  adminCheckedStr: (user) ->
    if user.admin() then 'checked' else ''

  moderatorCheckedStr: (user) ->
    if user.moderator() then 'checked' else ''
