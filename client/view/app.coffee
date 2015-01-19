@ShowLogin = ->
  Meteor.setTimeout((->Template._loginButtons.toggleDropdown()), 200)