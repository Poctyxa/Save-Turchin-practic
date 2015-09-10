@Delivery = new Mongo.Collection 'delivery'

Delivery.allow
  insert: -> true
  update: -> true
  remove: -> true
