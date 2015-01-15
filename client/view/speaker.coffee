
uploadedImage = null
uploadedImageDep = new Deps.Dependency()
Template.speaker.events
  'click .edit': ->
    @speaker.toggleEdit()

  'click .save': (event, context) ->
    name = context.find("#name").value
    bio = context.find("#bio").value
    trackRecord = context.find("#trackRecord").value
    updates =
      'profile.editing': false
      'profile.name': name
      'profile.bio': bio
      'profile.trackRecord': trackRecord
    if uploadedImage then updates['profile.uploadedImage'] = uploadedImage
    uploadedImage = null
    @speaker.update(updates)

  'click #upload-image': ->
    filepicker.setKey('AdBaAI7evS5yvsIsRlKPRz')
    filepicker.pick
      mimetype: 'image/*'
      service: 'COMPUTER'
      ,(inkBlob) ->
        uploadedImage = inkBlob.url
        uploadedImageDep.changed()

  'click #remove-image': ->
    uploadedImage = null
    uploadedImageDep.changed()
    @speaker.update('profile.uploadedImage': null)

Template.speaker.helpers
  speaker: -> @speaker

  uploadedImage: ->
    uploadedImageDep.depend()
    img = if uploadedImage then uploadedImage else @speaker.uploadedImage()
    if img
      "#{img}/convert?h=120&w=120"

  canEdit: -> canEdit.call(@)

  photo: -> @speaker?.photoUrl(120)

  photoFromService:  -> @speaker?.photoUrlFromService(120)

  editMode: ->
    canEdit.call(@) and ((not @speaker?.hasBio()) or @speaker?.editing())

  twitterShareNotMeUrl: ->
    url = Router.fullPath('speaker', id: @speaker.id)
    shareText = "#{@speaker.name()} will be speaking at reversim conf!"
    "https://twitter.com/share?url=#{encodeURIComponent(url)}&text=#{encodeURIComponent(shareText)}&via=reversim"

  twitterShareMeUrl: ->
    url = Router.fullPath('speaker', id: @speaker.id)
    shareText = "I'll be speaking at reversim conf!"
    "https://twitter.com/share?url=#{encodeURIComponent(url)}&text=#{encodeURIComponent(shareText)}&via=reversim"

  canSeeTrackRecord: ->
    cur = User.current()
    @speaker?.me() or (cur and (cur?.moderator() or cur?.admin()))

  canSeeEmail: ->
    cur = User.current()
    @speaker?.me() or (cur and (cur?.moderator() or cur?.admin()))

  hasProposals: -> @speaker?.proposals()?.length > 0

  proposals: -> @speaker?.proposals()

canEdit = ->
  cur = User.current()
  @speaker?.me() or (cur and cur?.admin())


Template.speaker.rendered = ->
  $('[data-toggle="tooltip"]').tooltip()

Template.speaker.destroyed = ->
  $('[data-toggle="tooltip"]').tooltip('destroy')
