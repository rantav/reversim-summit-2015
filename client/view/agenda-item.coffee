Template.agendaItem.helpers

  formatTime: (t) ->
    # moment(t).tz('Asia/Jerusalem').format('HH:mm')
    moment(t).format('HH:mm')

  editing: ->
    Session.get('editingAgenda')

  class1Colspan: ->
    if @class2 then 1 else 2

Template.agendaItem.events
  'keyup input': (event, context) ->
    if event.keyCode == 13
      time = context.find('input.time')
      class1 = context.find('input.class1')
      icon1 = context.find('input.icon1')
      class2 = context.find('input.class2')
      icon2 = context.find('input.icon2')
      time = new Date(time.value)
      @update
        time: time,
        class1: class1.value,
        icon1: icon1.value,
        class2: class2 and class2.value,
        icon2: icon2 and icon2.value,

  'click button.del': ->
    @destroy()
