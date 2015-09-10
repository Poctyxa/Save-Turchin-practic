if Meteor.isClient
  Template.Menu.events
    'click .signin-signup': () ->
      $('.signin-signup-block').toggle()
      $('.hide-form').toggle()
      $('.signin-form').toggle()
      Session.set 'signinError', null
      Session.set 'regError', null
      Session.set 'sendMessage', null
    'click .logout-btn': (e) ->
      e.preventDefault()
      Meteor.logout (error) ->
        if (error)
          console.log error.reason
    'click .shopping-card': (e) ->
      allElem = $('.cardList').find('div.shop-card').length
      i = 0
      Session.set 'shoppingCard',
        totalItemPrice: 0
        totalWeight: 0
        totaldiscount: '0'
      while i < allElem
        id = $('.cardList').find('div.shop-card').eq(i).attr('id').substring(5)
        db = GoodsItems.find _id: id
        Session.set 'shoppingCard',
          totalItemPrice: Session.get('shoppingCard').totalItemPrice + +GoodsItems.findOne({_id: id }).price
          totalWeight: Session.get('shoppingCard').totalWeight + +GoodsItems.findOne({_id: id }).weight
          totaldiscount: '10%'
        i++
      $('.total-items-price').html(Session.get('shoppingCard').totalItemPrice)
      $('.total-items-weight').html(Session.get('shoppingCard').totalWeight)
      $('.total-discount').html(Session.get('shoppingCard').totaldiscount)
      $('.total-delivery').html( () ->
        Delivery.findOne({min_weight: {$lt: +Session.get('shoppingCard').totalWeight},max_weight: {$gte: +Session.get('shoppingCard').totalWeight} }).price
        )
      $('.total-price').html( () ->
        (+Session.get('shoppingCard').totalItemPrice -
        (+Session.get('shoppingCard').totalItemPrice * +Discounts.findOne({value: Session.get('shoppingCard').totaldiscount}).number)) +
        +Delivery.findOne({min_weight: {$lt: +Session.get('shoppingCard').totalWeight},max_weight: {$gte: +Session.get('shoppingCard').totalWeight} }).price
        )

  Template.Signin.helpers
    signinError: () ->
      if Session.get 'signinError'
        $('.errors').css('display', 'table-cell')
        Session.get 'signinError'
    regError: () ->
      if Session.get 'regError'
        $('.errors').css('display', 'table-cell')
        Session.get 'regError'
    sendMessage: () ->
      if Session.get 'sendMessage'
        $('.sendMessage').css('display', 'table-cell')
        if Session.get('sendMessage') == 'В базі відсутня вказана адреса!'
          $('.sendMessage').css('color', 'red')
        else
          $('.sendMessage').css('color', 'green')
        Session.get 'sendMessage'

  Template.Signin.events
    'click input[type="button"]': (e) ->
      tmp = Template.instance()
      tmp.$('.hide-form').css('display', 'none')
      tmp.$('.' + e.target.id).find('input[type="email"], input[type="password"]').val('')
      tmp.$('.' + e.target.id).css('display', 'block')
    'submit .registration-form': (e) ->
      e.preventDefault()
      name = $('input[name="reg-name"]').val()
      email = $('input[name="reg-email"]').val()
      phone = $('input[name="phone-numb"]').val()
      password = $('input[name="reg-password"]').val()
      confirm_password = $('input[name="confirm_password"]').val()
      if ((password == confirm_password) && (password.length >= 6))
        Accounts.createUser
          profile: { name: name , phone: phone}
          email: email
          password: password
        , (error) ->
            if (error)
              console.log error.reason
        Session.set 'regError', null
      else if password != confirm_password
          console.log 'Passwords are not equal!'
          Session.set 'regError', 'Помилка при заповненні полів!'
      else if password.length < 6
          console.log 'Passwords are not equal!'
          Session.set 'regError', 'Код надто короткий ( мін. 6 символів)!'
    'submit .signin-form': (e) ->
      e.preventDefault()
      email = $('input[name="signin-email"]').val()
      password = $('input[name="signin-password"]').val()
      Meteor.loginWithPassword email, password , (error) ->
        if (error)
          Session.set 'signinError', 'Невірна комбінація адреси та коду!'
          console.log 'Failed authorization'
        else
          Session.set 'signinError', null
    'submit .forgot-form': (e) ->
      e.preventDefault()
      email = $('input[name="forgot-email"]').val()
      console.log email
      Accounts.forgotPassword email: email, (error) ->
        if (error)
          console.log 'recovery failed '
          Session.set 'sendMessage', 'В базі відсутня вказана адреса!'
        else
          console.log 'Check ur sendbox'
          Session.set 'sendMessage', 'Лист відправлено на вказану адресу!'
