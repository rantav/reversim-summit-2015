class @Sponsor extends Minimongoid

  @_collection: new Mongo.Collection('sponsors')

  logo: (height) ->
    url = @logoUrl
    if url
      Cdn.cdnify(url)

@Sponsor._collection.allow
  insert: (userId, doc) ->
    User.find(userId).isAdmin()

  update: (userId, doc, fields, modifier) ->
    User.find(userId).isAdmin()

@Sponsors = Sponsor._collection

schema = new SimpleSchema
  logoUrl:
    type: String
  logoSmallUrl:
    type: String
  name:
    type: String
  logoLink:
    type: String
  description:
    type: String
    optional: true
  descriptionHeb:
    type: String
    optional: true
  more:
    type: String
    optional: true

Sponsors.attachSchema(schema)