@GoodsItems = new Mongo.Collection 'goodsItems'

GoodsItems.allow
  insert: -> true
  update: -> true
  remove: -> true
