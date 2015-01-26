statuses = ['submitted', 'accepted', 'maybe next time']

Template.vote.helpers

  speakers: -> @speakers

  shouldDisplay: (speaker) ->
    speaker.hasProposalInStatus(statuses)

  photo: (speaker) ->
    speaker.photoUrl(120)

  proposals: -> @proposals()

  filterByTypeUrl: ->
    Router.path('vote') + "?filterType=#{@type}"

  filterByTagUrl: ->
    Router.path('vote') + "?filterTag=#{@}"

  votersCount: ->
    _.keys(countVotes(@speakers)).length

  votersAverage: ->
    average(_.values(countVotes(@speakers)))

  totalVotes: -> sum(_.values(countVotes(@speakers)))

  name: (userId) ->
    User.find(userId)?.name?()

  topVoters: ->
    arr = []
    for voter, votes of countVotes(@speakers)
      arr.push({voter: voter, votes: votes})
    arr = _.sortBy(arr, (item) -> -item.votes)
    arr = arr.slice(0, 5)
    for v in arr
      user = User.find(v.voter)
      if user then v.name = user.name()
    arr

  canSeeResults: ->
    u = User.current()
    u and (u.admin() or u.moderator())

# Counts the votes for each voter. Returns a map of voters -> count
countVotes = (speakers) ->
  voters = {}
  for speaker in speakers
    for proposal in speaker.proposals()
      for voter, vote of proposal.votes
        if vote
          if voters[voter]
            voters[voter] += 1
          else
            voters[voter] =  1
  voters

sum = (arr) -> _.reduce(arr, ((sum, num) -> sum + num), 0)
average = (arr) -> if arr.length then sum(arr) / arr.length else 0

Template.vote.events
  'click .sign-in': ->
    ShowLogin()

  'click .accept': ->
    @update({status: 'accepted'})

  'click .reject': ->
    @update({status: 'maybe next time'})
