# Hack the login service, tell it that there's no user-pass login, even
# though the package is loaded (b/c of yogiben:admin)
Meteor.startup ->
  Accounts._loginButtons.hasPasswordService = -> false
