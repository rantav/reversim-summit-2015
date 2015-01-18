Template.comments.events
  'click .sign-in': ->
    ShowLogin()

  'submit form': (event) ->
    event.preventDefault()
    content = $('#add-comment').val()
    if content
      @addComment(content)
      $('#add-comment').val('')

Template.comments.helpers
  photoSmall:  (userId) ->
    userId and User.find(userId).photoUrl(20)
