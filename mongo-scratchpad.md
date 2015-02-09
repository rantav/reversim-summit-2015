# Submitters emails:
db.users.find({"profile.submitted": true}, {"services.google.email": 1, "services.facebook.email": 1}).forEach(
  function(u) {
    if (u.services.google) {
      print(u.services.google.email);
    } else if (u.services.facebook) {
      print(u.services.facebook.email);
    }
  })


# Mark a user as submitter:
db.users.update({_id: "BDDJgqvaALSoyyrpR"}, {$set: {"profile.submitted": true}})

# Add comments to wishes
```
db.wishes.find().forEach(function(w){
  w.comments = [];
  db.wishes.save(w);
})
```

# export talks to tsv
```
print('id proposal status title type tags submitter email submitter-link votes'.split(' ').join('\t'))
db.proposals.find().sort({_id: 1}).forEach(function(p) {
  votes = p.votes;
  voteCount = 0;
  for (v in votes) {
    if (votes[v]) voteCount++;
  }
  abstract = p.abstract;
  abstract = abstract.split('"').join("'");
  abstract = abstract.split('\n').join(" ");
  users = db.users.find({_id: {$in: p.speaker_ids}}, {
    "services.google.email": 1,
    "services.facebook.email": 1
  });
  emails = [];
  users.forEach(function(user){
    emails.push(
          (user.services.google && user.services.google.email) ||
          (user.services.facebook && user.services.facebook.email));

  });
  speakerPages = p.speaker_ids.map(function(id){return "http://summit2014.reversim.com/speaker/" + id});
  users = db.users.find({_id: {$in: p.speaker_ids}}, {
    "profile.name": 1
  });
  speakerNames = users.map(function(u){return u.profile.name});
  print([p._id,
         "http://summit2014.reversim.com/proposal/" + p._id,
         p.status,
         p.title,
         p.type,
         p.tags,
         speakerNames,
         emails,
         speakerPages,
         voteCount].join('\t'))
})

```


Votes:

```
db.proposals.find().forEach(function(p){
  voters = [];
  for(v in p.votes){
    if(p.votes[v]){
      voters.push(v)
    }
  }
  print(p._id + " - " + voters);
})
```

Vote counts:
```
db.proposals.find({$or: [{deleted: {$exists: false}}, {deleted: false}]}).sort({_id: 1}).forEach(function(p) {
  votes = p.votes;
  voteCount = 0;
  for (v in votes) {
    if (votes[v]) voteCount++;
  }
  print([p._id, voteCount].join('\t'))
})

```