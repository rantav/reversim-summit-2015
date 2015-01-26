
Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  templateNameConverter: 'upperCamelCase'
  routeControllerNameConverter: 'upperCamelCase'
  # trackPageView: true

seo = (title, description) ->
  t = []
  if title
    t.push(title)
  t.push('Reversim Summit 2015')
  t = t.join(' | ')
  document.title = t
  url = document.location.href
  ogImage = 'http://dpk7qq034rxx8.cloudfront.net/img/ogImage.jpg'
  if not description
    description = title
  SEO.set
    title: title
    meta:
      description: description
    og:
      title: title,
      description: description
      url: url
      image: ogImage
    fb:
      app_id: '163492177191737'
    twitter:
      url: url

Router.map ->
  @route 'home',
    path: '/'
    fastRender: true
    tempalte: 'home'
    data: -> page: 'home'
    onAfterAction: ->
      seo('')

  @route 'about',
    path: '/about'
    fastRender: true
    waitOn: -> Meteor.subscribe('moderators')
    tempalte: 'about'
    data: -> page: 'about'
    onAfterAction: ->
      seo('About')

  # @route 'infographics', path: '/infographics' # TODO later

  @route 'register',
    path: '/register'
    tempalte: 'register'
    fastRender: true
    data: -> page: 'register'
    onAfterAction: -> seo('Register')

  @route 'propose',
    path: '/propose'
    waitOn: -> Meteor.subscribe('users', {_id: Meteor.userId()})
    template: 'propose'
    fastRender: true
    data: -> page: 'propose'
    onAfterAction: -> seo('Propose')

  @route 'wishes',
    path: '/wishes'
    tempalte: 'wishes'
    fastRender: true
    data: -> page: 'wishes'
    waitOn: -> Meteor.subscribe('wishes')
    onAfterAction: -> seo('Wishes')

  @route 'agenda',
    path: '/agenda'
    waitOn: -> Meteor.subscribe('agenda')
    tempalte: 'agenda'
    fastRender: true
    data: ->
      page: 'agenda'
      items: AgendaItem.all()
    onAfterAction: -> seo('Agenda')

#  @route 'proposal1', _.extend(path: '/proposal/:id/:title*', proposalRouteConfig)
#  @route 'proposal2', _.extend(path: '/proposal/:id', proposalRouteConfig)

  @route 'proposal',
    path: '/proposal/:id'
    waitOn: ->
      Meteor.subscribe('proposals', {_id: @params.id})
    template: 'proposal'
    notFoundTemplate: 'notFound'
    data: ->
      proposal = Proposal.find(@params.id)
      if not proposal then return null
      seo(proposal.title, proposal.abstract)
      {page: 'proposal', proposal: proposal}


  @route 'proposals',
    path: '/proposals'
    waitOn: ->
      q = {}
      q.type = @params.query?.filterType if @params.query?.filterType
      q.tags = @params.query?.filterTag if @params.query?.filterTag
      Meteor.subscribe('proposals', q, {createdAt: -1})
    tempalte: 'proposals'
    fastRender: true
    data: ->
      page: 'proposals'
      q = {}
      q.type = @params.query?.filterType if @params.query?.filterType
      q.tags = @params.query?.filterTag if @params.query?.filterTag
      proposals: Proposal.where(q, {createdAt: -1})
      filterType: @params.query?.filterType
      filterTag: @params.query?.filterTag
    onAfterAction: -> seo('Proposals')

  @route 'vote',
    path: '/vote'
    fastRender: true
    waitOn: ->
      q = {}
      if filterType = @params.filterType
        q.type = filterType
      if filterTag = @params.filterTag
        q.tags = filterTag
      Meteor.subscribe('proposals-min', q)
    tempalte: 'vote'
    data: ->
      sum = (arr) -> if arr.length then _.reduce(arr, ((sum, num) -> sum + num), 0) / arr.length else 0
      sort = (speakers) ->
        _.sortBy(speakers, (speaker) ->
          - sum(speaker.proposals().map((p) -> p.voteCount()))
        )
      speakers = User.allSpeakers()
      if speakers and speakers.length > 0
        user = User.current()
        speakers = if user and (user.admin() or user.moderator()) then sort(speakers) else _.shuffle(speakers)
      return {
        page: 'vote'
        speakers: speakers
        filterType: @params.filterType
        filterTag: @params.filterTag
      }
    onAfterAction: -> seo('Vote')


  @route 'speaker',
    path: '/speaker/:id/:name?'
    fastRender: true
    waitOn: ->
      Meteor.subscribe('speakers', {_id: @params.id})
    tempalte: 'speaker'
    notFoundTemplate: 'notFound'
    data: ->
      speaker = User.find(@params.id)
      if not speaker then return null
      seo(speaker.name(), speaker.bio)
      {page: 'speaker', speaker: speaker}

  @route 'speakers',
    waitOn: -> Meteor.subscribe('proposals')
    tempalte: 'speakers'
    fastRender: true
    data: ->
      page: 'speakers'
      speakers: User.allSpeakers()
    onAfterAction: -> seo('Speakers')

  @route 'users',
    waitOn: -> Meteor.subscribe('users')
    tempalte: 'users'
    fastRender: true
    data: -> page: 'users'
    onAfterAction: -> seo('Users')

  @route 'user',
    path: '/user/:id/:name?'
    fastRender: true
    tempalte: 'user'
    waitOn: ->
      Meteor.subscribe('users', {_id: @params.id})
    notFoundTemplate: 'notFound'
    data: ->
      speaker = User.find(@params.id)
      if not speaker then return null
      seo(speaker.name())
      {page: 'speaker', speaker: speaker}

  @route 'wish',
    path: '/wish/:id/:title?'
    waitOn: -> Meteor.subscribe('wishes', _id: @params.id)
    tempalte: 'wish'
    fastRender: true
    notFoundTemplate: 'notFound'
    data: ->
      wish = Wishes.findOne(_id: @params.id)
      if not wish then return null
      seo(wish.title, wish.description)
      {page: 'wish', wish: wish}

  @route 's2013',
    path: '/s2013'
    tempalte: 's2013'
    fastRender: true
    data: -> page: 's2013'
    onAfterAction: -> seo('2013')

  @route 's2014',
    path: '/s2014'
    tempalte: 's2014'
    fastRender: true
    data: -> page: 's2014'
    onAfterAction: -> seo('2014')

  @route 'info',
    path: '/info'
    tempalte: 'info'
    fastRender: true
    data: -> page: 'info'
    onAfterAction: -> seo('Info')

  @route 'coc',
    path: '/coc'
    tempalte: 'coc'
    fastRender: true
    data: -> page: 'coc'
    onAfterAction: -> seo('Code of Conduct')

  @route 'sponsors',
    waitOn: -> Meteor.subscribe('sponsors')
    tempalte: 'sponsors'
    fastRender: true
    data: ->
      page: 'sponsors'
      sponsors: _.shuffle(Sponsor.all())
    onAfterAction: -> seo('Sponsors')

  @route 'community',
    path: '/community'
    tempalte: 'community'
    data: -> page: 'community'
    fastRender: true
    onAfterAction: -> seo('Community')

Router.fullPath = (routeName, params) ->
  Meteor.absoluteUrl().slice(0, -1) + Router.path(routeName, params)

proposalRouteConfig =
  waitOn: ->
    Meteor.subscribe('proposals', {_id: @params.id})
  template: 'proposal'
  notFoundTemplate: 'notFound'
  data: ->
    proposal = Proposal.find(@params.id)
    if not proposal then return null
    document.title = "#{proposal.title} | Reversim Summit 2015"
    {page: 'proposal', proposal: proposal}
