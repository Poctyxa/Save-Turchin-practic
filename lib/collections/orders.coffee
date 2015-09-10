@Orders = new Mongo.Collection 'orders'

Orders.allow
  insert: -> true
  update: -> true
  remove: -> true
