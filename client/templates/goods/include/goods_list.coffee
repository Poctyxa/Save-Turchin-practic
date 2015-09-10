Template.GoodsDropdown.helpers
  goodsType: () ->
    Goods.find({}, {sort: {name: 1}})

Template.GoodsDropdown.events
  'change .form-control': ->
    Session.set 'goodsType', $('.form-control :selected').val()


  'mouseover .form-control': ->
    $('.type-delete').css('display', 'none')

Template.GoodsList.helpers
  itemList: () ->
    if(Session.get 'goodsType')
      getId = Goods.findOne({name: Session.get('goodsType')})._id
      GoodsItems.find({type_id: getId}, {sort: {name: 1}})
  itemNumber: () ->

Template.GoodsItem.events
  'click .item-block': (e) ->
    tmp = Template.instance()
    blockId = tmp.$('.item-block').attr('id')
    Session.set 'infoBlock', blockId
