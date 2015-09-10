Meteor.startup () ->
  Meteor.methods
    'calculateCost': (goods, goodsNumber, goodsWeight, goodsPrice, discount, delivery, name, email, mobile, address) ->
      totalCost = (goodsPrice - goodsPrice * discount) + delivery
      Orders.insert
        name: name
        mobile: mobile
        email: email
        address: address
        goods: goods
        goodsNumber: goodsNumber
        goodsWeight: goodsWeight
        discount: discount
        price: totalCost
      return
    'addToShoppingCard': (userId, goods) ->
      ShoppingCard.insert
        userId: userId
        goods: goods
    'deleteFromItemCard': (userId, goodsId) ->
      ShoppingCard.remove userId: userId, goods: goodsId
