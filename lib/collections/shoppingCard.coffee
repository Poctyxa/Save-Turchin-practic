@ShoppingCard = new Mongo.Collection 'shoppingCard'

ShoppingCard.allow
  insert: -> true
  update: -> true
  remove: -> true
