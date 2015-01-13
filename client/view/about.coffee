Template.about.helpers
  moderators:  -> User.allModerators()
  photo: (user) -> user.photoUrl(120)