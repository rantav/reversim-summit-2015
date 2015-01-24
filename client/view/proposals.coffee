Template.proposals.helpers

  proposals: -> @proposals

  photo: (user) -> user.photoUrl(120) if user

  canSeeNumLoaded: ->
    u = User.current()
    u and (u.admin() or u.moderator())

  numLoaded: -> @proposals.length if @proposals

  speakers: (proposal) -> proposal.speakers()

  hasMore: -> false # For now...
    # count = Counts.findOne('proposals')
    # count and count.count > Proposal.count()

  filterByTypeUrl: ->
    Router.path('proposals') + "?filterType=#{@type}"

  canTag: ->
    u = User.current()
    u and (u.admin() or u.moderator())

Template.proposals.rendered = ->
  @$('[data-toggle="tooltip"]').tooltip()

Template.proposals.destroyed = ->
  @$('[data-toggle="tooltip"]').tooltip('destroy')


Template.proposals.events
  'click #load-more': ->
    path = Router.path('proposals', {limit: @limit + 10})
    if @filterType
      path += "?filterType=#{@filterType}"
    Router.go(path)
