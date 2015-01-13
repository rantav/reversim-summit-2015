Template.speakers.helpers
  speakers: -> @speakers

  photo: (speaker) -> speaker.photoUrl(120)

  proposals: -> @proposals()

  shouldDisplay: (speaker) ->
    speaker.hasProposalInStatus(statuses)

  canSeeEmail: (speaker)->
    cur = User.current()
    (speaker and speaker.me()) or (cur and (cur.moderator() or cur.admin()))

  proposalCountStr: (speaker) ->
    count = speaker.proposalsInStatus(statuses).length
    if count == 1
      "One proposal"
    else
      "#{count} proposals"

statuses = ['submitted', 'accepted']
