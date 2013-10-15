Handlebars.registerHelper 'loggedIn', ->
  !!Meteor.userId()

Handlebars.registerHelper 'userName', (userId)->
  u = User.findOne(userId)
  u and u.name()

Handlebars.registerHelper 'userVotedWishStr', (wish)->
  u = Meteor.userId()
  if u and wish.votes[u] then 'true' else 'false'

Handlebars.registerHelper 'twitterShareWishUrl', (wish)->
  if wish
    url = "#{document.location.protocol}//#{document.location.host}#{Router.path('wish', {id: wish._id})}"
    shareText = "I wish there was a talk about \"#{wish.title}\" at #reversim summit. Help by voting!"
    "https://twitter.com/share?url=#{encodeURIComponent(url)}&text=#{encodeURIComponent(shareText)}&via=reversim"

Handlebars.registerHelper 'twitterShareProposalUrl', (proposal)->
  if proposal
    url = "#{document.location.protocol}//#{document.location.host}#{Router.path('proposal', {id: proposal.id})}"
    shareText = "Submitted to reversim conf: \"#{proposal.title}\""
    "https://twitter.com/share?url=#{encodeURIComponent(url)}&text=#{encodeURIComponent(shareText)}&via=reversim"


Handlebars.registerHelper 'staticImg', (path)->
  Cdn.cdnify(path)

Handlebars.registerHelper 'wishVoteTooltip', (wish) ->
  u = Meteor.userId()
  if not u then return "Login to vote"
  if wish.votes[u] then 'Unvote' else 'Vote'

Handlebars.registerHelper 'marked', (text)->
  marked(text)
