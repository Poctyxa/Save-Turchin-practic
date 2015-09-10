Template.InfoPanel.helpers
  getInfo: () ->
    tmp = Template.instance()
    if (Session.get 'infoBlock')
      item = GoodsItems.findOne _id: Session.get 'infoBlock'
    else
      {
        name: '-Назва випічки-'
        pic: 'http://lorempixel.com/g/510/300'
        description: 'Description'
      }
  noInfo: () ->
    if (Session.get 'infoBlock')
      true
    else
      false

Template.InfoPanel.events
  'mouseenter .shopping-cart': (e) ->
    e.preventDefault()
    tmp = Template.instance()
    tmp.$('.shopping-cart').popover('show')
  'mouseleave .shopping-cart': (e) ->
    e.preventDefault()
    tmp = Template.instance()
    tmp.$('.shopping-cart').popover('hide')
  'click .show-modal': (e) ->
    e.preventDefault()
    $('#myModal').find('.counter').val('1')
    $('.totalPrice').html(GoodsItems.findOne({ _id: Session.get 'infoBlock'}).price)
    $('.client-order-data').val('')
    $('.goods-weight').html(GoodsItems.findOne({ _id: Session.get 'infoBlock'}).weight)
    $('.delivery').html('0')
    if Meteor.userId()
      $('input[name="client_name"]').val(Meteor.users.findOne({_id: Meteor.userId()}).profile.name)
      $('input[name="client_email"]').val(Meteor.users.findOne({_id: Meteor.userId()}).emails[0].address)
      $('input[name="client_phone"]').val(Meteor.users.findOne({_id: Meteor.userId()}).profile.phone)
    else
      $('input[name="client_name"]').val('')
      $('input[name="client_email"]').val('')
      $('input[name="client_phone"]').val('')
    if Meteor.userId()
      $('.discount').html(Discounts.findOne({value: '10%'}).value)
    else
      $('.discount').html(Discounts.findOne({value: '0%'}).value)
    discountNumber = Discounts.findOne({ value: $('.discount').html() }).number
    $('.fullPrice').html( ->
      (+$('.counter').val() * +GoodsItems.findOne({ _id: Session.get 'infoBlock'}).price) -
      ((+$('.counter').val() * +GoodsItems.findOne({ _id: Session.get 'infoBlock'}).price) * discountNumber) +
      +$('.delivery').html()
    )
  'click .add-to-card': (e) ->
    if ShoppingCard.findOne({userId: Meteor.userId(), goods: Session.get 'infoBlock'})
      sAlert.warning 'Даний товар уже у кошику!'
    else
      Meteor.call('addToShoppingCard', Meteor.userId(), Session.get 'infoBlock')
      sAlert.success 'Товар додано у Ваш кошик!'

Template.InfoPanel.onRendered () ->
  tmp = Template.instance()
  changePosition = 30
  window.onscroll = () ->
    currentScroll = window.pageYOffset
    if currentScroll > changePosition
      tmp.$('.info-width').css('top', '20px')
    else tmp.$('.info-width').css('top', '90px')


Template.ReportTable.helpers
  goodsId: () ->
    if (Session.get 'infoBlock')
      goodsId = GoodsItems.findOne({ _id: Session.get 'infoBlock'})
  userData: () ->
    if Meteor.userId()
      Meteor.users.findOne(_id: Meteor.userId())


Template.ReportTable.events
  'click .counter-plus': (e) ->
    e.preventDefault()
    tmp = Template.instance()
    tmp.$('.counter').val(
      ->
        +tmp.$('.counter').val() + 1
      )
    if +tmp.$('.counter').val() > 50
      tmp.$('.counter').val('50')
    tmp.$('.totalPrice').html(
      ->
        +tmp.$('.counter').val() * + GoodsItems.findOne({ _id: Session.get 'infoBlock'}).price
      )
    tmp.$('.goods-weight').html( ->
      +tmp.$('.counter').val() * + GoodsItems.findOne({ _id: Session.get 'infoBlock'}).weight
    )
    tmp.$('.delivery').html(
      ->
        weight =  +tmp.$('.goods-weight').html()
        Delivery.findOne({min_weight: {$lt: weight},max_weight: {$gte: weight} }).price
      )
    if Meteor.userId()
      $('.discount').html(Discounts.findOne({value: '10%'}).value)
    else
      $('.discount').html(Discounts.findOne({value: '0%'}).value)
    discountNumber = Discounts.findOne({ value: $('.discount').html() }).number
    tmp.$('.fullPrice').html( ->
      (+$('.counter').val() * +GoodsItems.findOne({ _id: Session.get 'infoBlock'}).price) -
      ((+$('.counter').val() * +GoodsItems.findOne({ _id: Session.get 'infoBlock'}).price) * discountNumber) +
      +$('.delivery').html()
      )
  'click .counter-minus': (e) ->
    e.preventDefault()
    tmp = Template.instance()
    tmp.$('.counter').val(
      ->
        +tmp.$('.counter').val() - 1
      )
    if +tmp.$('.counter').val() < 1
      tmp.$('.counter').val('1')
    tmp.$('.totalPrice').html(
      ->
        +tmp.$('.counter').val() * GoodsItems.findOne({ _id: Session.get 'infoBlock'}).price
    )
    tmp.$('.goods-weight').html( ->
      +tmp.$('.counter').val() * + GoodsItems.findOne({ _id: Session.get 'infoBlock'}).weight
    )
    tmp.$('.delivery').html(
      ->
        Delivery.findOne({min_weight: {$lt: +tmp.$('.goods-weight').html()},max_weight: {$gte: +tmp.$('.goods-weight').html()} }).price
    )
    if Meteor.userId()
      $('.discount').html(Discounts.findOne({value: '10%'}).value)
    else
      $('.discount').html(Discounts.findOne({value: '0%'}).value)
    discountNumber = Discounts.findOne({ value: $('.discount').html() }).number
    tmp.$('.fullPrice').html( ->
      (+$('.counter').val() * +GoodsItems.findOne({ _id: Session.get 'infoBlock'}).price) -
      ((+$('.counter').val() * +GoodsItems.findOne({ _id: Session.get 'infoBlock'}).price) * discountNumber) +
      +$('.delivery').html()
      )

Template.BuyItem.events
  'submit form': (e) ->
    tmp = Template.instance()
    console.log 'wow'
  'blur input[name="client_name"]': (e) ->
    regex = /^[a-zA-Z\s]+$/g
    if regex.exec($('input[name="client_name"]').val())
      $('input[name="client_name"]').css('color', 'green')
    else
      $('input[name="client_name"]').css('color', 'red')
  'blur input[name="client_phone"]': (e) ->
    regex = /[0-9]{10}/gm
    if regex.exec($('input[name="client_phone"]').val())
      $('input[name="client_phone"]').css('color', 'green')
    else
      $('input[name="client_phone"]').css('color', 'red')
  'blur input[name="client_email"]': (e) ->
    regex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i
    if regex.exec($('input[name="client_email"]').val())
      $('input[name="client_email"]').css('color', 'green')
    else
      $('input[name="client_email"]').css('color', 'red')
  'click .order-success': (e) ->
    e.preventDefault()
    tmp = Template.instance()
    if !Meteor.userId()
      goods = GoodsItems.findOne({ _id: Session.get 'infoBlock'}).name
      counter = +$('.counter').val()
      if (counter > 50)
        counter = 50
        goodsNumber = counter
      else if(counter < 1)
        counter = 1
        goodsNumber = counter
      else if((counter >= 1) && (counter <= 50))
        counter = 1
        goodsNumber = counter
      else
        counter = 1
        goodsNumber = counter
      goodsWeight = GoodsItems.findOne({ _id: Session.get 'infoBlock'}).weight * goodsNumber
      goodsPrice = GoodsItems.findOne({ _id: Session.get 'infoBlock'}).price * counter
      discount = 0
      delivery = Delivery.findOne({min_weight: {$lt: goodsWeight},max_weight: {$gte: goodsWeight} }).price
      name = tmp.$('input[name="client_name"]').val()
      email  = tmp.$('input[name="client_email"]').val()
      mobile  = tmp.$('input[name="client_phone"]').val()
      address  = tmp.$('input[name="client_address"]').val()
      clientData = [goods, goodsNumber, goodsWeight, goodsPrice, discount, delivery, name, email, mobile, address]
      Meteor.apply 'calculateCost', clientData
      , (error) ->
        if error
          console.log error.reason
