Template.ShoppingCard.helpers
  getCardItems: () ->
    if Meteor.userId()
      userId = Meteor.userId()
      cardItems = ShoppingCard.find(userId: userId).fetch()
      _.map(cardItems, (num) ->
        GoodsItems.findOne({_id: num.goods }))

Template.ShoppingCard.events
  'click .btn-add-counter': (e) ->
    e.preventDefault()
    tmp = Template.instance()
    parent = $(e.target).parent().parent().parent().parent().parent().parent()
    id = parent.attr('id').substring(5)
    doc = GoodsItems.findOne _id: id
    parent.find('input[type="text"]').val(
      +parent.find('input[type="text"]').val() + 1
    )
    if parent.find('input[type="text"]').val() > 50
      +parent.find('input[type="text"]').val('50')
    parent.find('.card-weight').html(
      +doc.weight * +parent.find('input[type="text"]').val()
    )
  'click .btn-remove-counter': (e) ->
    e.preventDefault()
    tmp = Template.instance()
    parent = $(e.target).parent().parent().parent().parent().parent().parent()
    id = parent.attr('id').substring(5)
    doc = GoodsItems.findOne _id: id
    parent.find('input[type="text"]').val(
      +parent.find('input[type="text"]').val() - 1
    )
    if +parent.find('input[type="text"]').val() < 1
      parent.find('input[type="text"]').val('1')
    parent.find('.card-weight').html(
      +doc.weight * +parent.find('input[type="text"]').val()
    )
  'click .del-item-card': (e) ->
    tmp = Template.instance()
    parent = $(e.target).parent().parent().parent().parent().parent().parent()
    id = parent.attr('id').substring(5)
    currentBlockInfo = Session.get 'infoBlock'
    Meteor.call('deleteFromItemCard', Meteor.userId(), id, (error) ->
      if error
        sAlert.error 'Помилка при видаленні товару!'
      else
        sAlert.success 'Товар було видалено успішно!')
