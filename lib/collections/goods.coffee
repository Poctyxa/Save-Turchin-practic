@Goods = new Mongo.Collection 'goods'

Goods.allow
  insert: -> true
  update: -> true
  remove: -> true
