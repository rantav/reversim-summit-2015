Template.propose.events
  'submit form': (event, c) ->
    event.preventDefault()
    title = c.find('#title').value
    abstract = c.find('#abstract').value
    type = c.$('select.proposal-type').val()
    name = c.find('#name')
    if name then name = name.value
    bio = c.find('#bio')
    if bio then bio = bio.value
    trackRecord = c.find('#trackRecord')
    if trackRecord then trackRecord = trackRecord.value
    if name then @update('profile.name': name)
    if bio then @update('profile.bio': bio)
    if trackRecord then @update('profile.trackRecord': trackRecord)
    if title and abstract and type
      abstract = Markdown.removeHeadings(abstract)
      p = Proposal.propose(title: title, abstract: abstract, type: type)
      User.current().update('profile.submitted': true)
      Router.go('proposal', {id: p.id})
      alertify.success('Thank you!')
      Meteor.call('sendSubmitEmail', p)
    else
      alertify.error("Title is missing", 1000) unless title
      alertify.error("Abstract is missing", 1000) unless abstract
      alertify.error("Type is missing", 1000) unless type

  'click .sign-in': ->
    ShowLogin()

Template.propose.helpers
  hasBio: (speaker) -> speaker and speaker.hasBio()

  speaker: -> User.current()
