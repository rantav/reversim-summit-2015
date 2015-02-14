mid = new Date('03/12/2015 00:00:00')

Template.agenda.helpers
  day1:  ->
    _.sortBy(@items.filter((i) -> i.time < mid), (i) -> i.time)

  day2: ->
    _.sortBy(@items.filter((i) -> i.time > mid), (i) -> i.time)

  canSee:  ->
    u = User.current()
    u and (u.admin() or u.moderator())

  canEdit:  ->
    u = User.current()
    u and u.admin()

Template.agenda.events
  'submit #add-form': (event, context) ->
    event.preventDefault()
    time = context.find('#time').value
    class1 = context.find('#class1').value
    icon1 = context.find('#icon1').value
    class2 = context.find('#class2').value
    icon2 = context.find('#icon2').value
    if not time then return
    time = new Date(time)
    if not time
      console.error('bad time string')
      return
    AgendaItem.create
      time: time
      class1: class1
      icon1: icon1
      class2: class2
      icon2: icon2

  'click #edit': ->
    Session.set('editingAgenda', not Session.get('editingAgenda'))