filters =

  resetScroll: ->
    scrollTo = window.currentScroll || 0;
    $('body').scrollTop(scrollTo);
    $('body').css("min-height", 0);

Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  templateNameConverter: 'upperCamelCase'
  routeControllerNameConverter: 'upperCamelCase'
  # trackPageView: true

# Router.onAfterAction(filters.resetScroll,
#   {except:['wishes', 'proposals', 'speakers', 'vote']});

Router.map ->
  # @route 'home', path: '/', action: -> @redirect('agenda')
  @route 'home',
    path: '/'
    fastRender: true
    tempalte: 'home'
    data: -> page: 'home'
    onAfterAction: ->
      document.title = "Reversim Summit 2015"

  @route 'about',
    path: '/about'
    fastRender: true
    waitOn: -> Meteor.subscribe('moderators')
    tempalte: 'about'
    data: -> page: 'about'
    onAfterAction: ->
      document.title = "About Reversim Summit 2015"

  # @route 'infographics', path: '/infographics' # TODO later

  @route 'register',
    path: '/register'
    tempalte: 'register'
    fastRender: true
    data: -> page: 'register'
    onAfterAction: ->
      document.title = "Register | Reversim Summit 2015"

  @route 'propose',
    path: '/propose'
    waitOn: -> Meteor.subscribe('users', {_id: Meteor.userId()})
    template: 'propose'
    fastRender: true
    data: -> page: 'propose'
    onAfterAction: -> document.title = "Propose | Reversim Summit 2015"

  @route 'wishes',
    path: '/wishes'
    tempalte: 'wishes'
    fastRender: true
    data: -> page: 'wishes'
    waitOn: -> Meteor.subscribe('wishes')
    onAfterAction: -> document.title = "Wishes | Reversim Summit 2015"

  @route 'agenda',
    path: '/agenda'
    waitOn: -> Meteor.subscribe('agenda')
    tempalte: 'agenda'
    fastRender: true
    data: ->
      page: 'agenda'
      items: AgendaItem.all()
    onAfterAction: -> document.title = "Agenda | Reversim Summit 2015"

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
      document.title = "#{proposal.title} | Reversim Summit 2015"
      {page: 'proposal', proposal: proposal}


  @route 'proposals',
    path: '/proposals/:limit?'
    waitOn: ->
      limit = @params.limit || 1000 # TODO: Limit
      q = {}
      if filterType = @params.filterType
        q.type = filterType
      if filterTag = @params.filterTag
        q.tags = filterTag
      Meteor.subscribe('proposals', q, {limit: limit, createdAt: -1})
    tempalte: 'proposals'
    fastRender: true
    data: ->
      page: 'proposals'
      proposals: Proposal.all(createdAt: -1)
      limit: parseInt(@params.limit || 10)
      filterType: @params.filterType
      filterTag: @params.filterTag
    onAfterAction: ->
      document.title = "Proposals | Reversim Summit 2015"

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
    onAfterAction: -> document.title = "Vote | Reversim Summit 2015"


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
      document.title = "#{speaker.name()} | Reversim Summit 2015"
      {page: 'speaker', speaker: speaker}

  @route 'speakers',
    waitOn: -> Meteor.subscribe('proposals')
    tempalte: 'speakers'
    fastRender: true
    data: ->
      page: 'speakers'
      speakers: User.allSpeakers()
    onAfterAction: -> document.title = "Speakers | Reversim Summit 2015"

  @route 'users',
    waitOn: -> Meteor.subscribe('users')
    tempalte: 'users'
    fastRender: true
    data: -> page: 'users'
    onAfterAction: -> document.title = "Users | Reversim Summit 2015"

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
      document.title = "#{speaker.name()} | Reversim Summit 2015"
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
      document.title = "#{wish.title} | Reversim Summit 2015"
      {page: 'wish', wish: wish}

  @route 's2013',
    path: '/s2013'
    tempalte: 's2013'
    fastRender: true
    data: -> page: 's2013'
    onAfterAction: -> document.title = "2013 | Reversim Summit"

  @route 's2014',
    path: '/s2014'
    tempalte: 's2014'
    fastRender: true
    data: -> page: 's2014'
    onAfterAction: -> document.title = "2014 | Reversim Summit"

  @route 'info',
    path: '/info'
    tempalte: 'info'
    fastRender: true
    data: -> page: 'info'
    onAfterAction: -> document.title = "Info | Reversim Summit 2015"

  @route 'coc',
    path: '/coc'
    tempalte: 'coc'
    fastRender: true
    data: -> page: 'coc'
    onAfterAction: -> document.title = "Code of Conduct | Reversim Summit 2015"

  @route 'sponsors',
    waitOn: -> Meteor.subscribe('sponsors')
    tempalte: 'sponsors'
    fastRender: true
    data: ->
      page: 'sponsors'
      sponsors: _.shuffle(Sponsor.all())
    onAfterAction: -> document.title = "Sponsors | Reversim Summit 2015"

  @route 'community',
    path: '/community'
    tempalte: 'community'
    data: -> page: 'community'
    fastRender: true
    onAfterAction: -> document.title = "Community | Reversim Summit 2015"

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
