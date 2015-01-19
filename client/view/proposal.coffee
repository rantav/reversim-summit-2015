Template.proposal.events
  'click .delete':  ->
    @proposal.delete()
    Router.go 'proposals'
    alertify.success('OK, Deleted')

  'click .edit':  -> @proposal.toggleEdit()

  'click .save': (event, context) ->
    title = context.find("#title-#{@proposal.id}").value
    abstract = context.find("#abstract-#{@proposal.id}").value
    abstract = Markdown.removeHeadings(abstract)
    type = context.$('select.proposal-type').val()
    speakerIds = context.find('#speakers').value
    speakerIds = _.uniq(_.compact(speakerIds.split(',').map((s)->s.trim())))
    speakersUpdated = (speakerIds.join(',') != @proposal.speaker_ids.join(','))
    if not (Meteor.userId() in speakerIds) and not User.current().admin()
      alertify.error("You cannot remove yourself as a speaker!")
      return
    @proposal.update(editing: false, title: title, abstract: abstract, type: type, speaker_ids: speakerIds)
    if speakersUpdated
      document.location = document.location

Template.proposal.helpers
  proposal: -> @proposal
  speakers: -> @proposal?.speakers()
  speakerIds: -> @proposal?.speakers().map((s) -> s.id)

  canEdit: -> canEdit(@proposal)

  photo: (user) -> user.photoUrl(40)

  editMode: -> @proposal?.editing and canEdit(@proposal)

canEdit = (proposal) ->
  Meteor.userId() and (proposal.mine() or User.current().admin())

Template.proposal.rendered = ->
  $('[data-toggle="tooltip"]').tooltip()

Template.proposal.destroyed = ->
  $('[data-toggle="tooltip"]').tooltip('destroy')
