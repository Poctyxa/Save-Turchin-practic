@Discounts = new Mongo.Collection 'discounts'

Discounts.allow
  insert: -> true
  update: -> true
  remove: -> true
