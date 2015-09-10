Meteor.publish 'GetGoodsTypes', ->
  Goods.find()

Meteor.publish 'GetGoods', ->
  GoodsItems.find()

Meteor.publish 'usersPublish', () ->
  Meteor.users.find()

Meteor.publish 'deliveryList', () ->
  Delivery.find()

Meteor.publish 'ordersList', () ->
  Orders.find()

Meteor.publish 'shoppingCardList', () ->
  ShoppingCard.find()

Meteor.publish 'discountsList', () ->
  Discounts.find()
