Router.configure
  layoutTemplate: 'Layout'
  loadingTemplate: 'Loading'
  notFoundTemplate: 'NotFound'
  waitOn: () ->
    [
      Meteor.subscribe 'GetGoodsTypes'
      Meteor.subscribe 'GetGoods'
      Meteor.subscribe 'usersPublish'
      Meteor.subscribe 'deliveryList'
      Meteor.subscribe 'ordersList'
      Meteor.subscribe 'shoppingCardList'
      Meteor.subscribe 'discountsList'
    ]

Router.route '/',
  name: 'home'
  action: () ->
    @render 'Home'

Router.route '/goods',
  name: 'goods'
  action: () ->
    @render 'Goods'

Router.route '/about',
  name: 'about'
  action: () ->
    @render 'About'
