if (Goods.find().count() == 0)
  Goods.insert({name: "Хліб"})
  Goods.insert({name: "Торт"})
  Goods.insert({name: "Печиво"})

if (GoodsItems.find().count() == 0)
  bread = Goods.findOne name: 'Хліб'
  cake = Goods.findOne name: 'Торт'
  cookies = Goods.findOne name: 'Печиво'
  GoodsItems.insert
    name: "Житній хліб",
    price: 7
    unit: "грн"
    numb: "шт"
    weight: "0.5"
    type_id: bread._id
    pic: "/images/goods/bread/Lifely/Lifely.jpg",
    ico:"/images/goods/bread/Lifely/Lifely_sm.jpg"
    description: "Особливість рецепта цього хліба — повна відсутність пшеничного борошна, а в процесі приготування не застосовуються дріжджі, їх роль виконує закваска. Використання закваски дає можливість спекти хліб, який буде довше не черствіти і буде більш корисним для здоров’я на відміну від дріжджового."
  GoodsItems.insert
    name: "Коровай"
    price: 110
    unit: "грн"
    numb: "шт"
    weight: "2"
    type_id: bread._id
    pic: "/images/goods/bread/Korovai/Korovai.jpg"
    ico:"/images/goods/bread/Korovai/Korovai_sm.jpg"
    description: "Кожне урочистий захід має свою історію і свою атрибутику. Наприклад, жодне весілля не обходиться без короваю. Весільний коровай є не просто круглим хлібом, від якого відламують шматок як можна більшого розміру. Він символізує щастя і любов, які даються подружжю на довгі роки."
  GoodsItems.insert
    name: "Київський торт"
    price: 120
    unit: "грн"
    numb: "шт"
    weight: "2"
    type_id: cake._id
    pic: "/images/goods/cake/Kuiv_cake/Kuiv_cake.png"
    ico:"/images/goods/cake/Kuiv_cake/Kuiv_cake_sm.png"
    description: "Одним з найбільш смачних символів України є Київський торт. Він складається з повітряних  безейных коржів, просочених ніжним вершковим кремом. Так як безе примхливий продукт, приготувати цей торт досить складно, але його вишуканий смак обов'язково зачарує ваших рідних. Секрет фабричного торта не розкривається, але існує безліч домашніх рецептів приготування Київського торта, один з них я представляю вашій увазі."
  GoodsItems.insert
    name: "Печиво цукрове"
    price: 35
    unit: "грн"
    numb: "кг"
    weight: "1"
    type_id: cookies._id
    pic: "/images/goods/cookies/Sugar_cookies/Sugar_cookies.png"
    ico:"/images/goods/cookies/Sugar_cookies/Sugar_cookies_sm.png"
    description: "Коли хочеться чогось солоденького, можна побалувати себе дуже смачним і швидким у приготуванні стравою. Серед безлічі рекомендацій до приготування печива одним із самих нескладних є рецепт випікання цукрового печива. Воно відмінно підійде на десерт і стане улюбленим напоєм не тільки для дітей, але і не залишить байдужим будь-якого дорослого, так як виходить надзвичайно ніжним, хрустким і тане в роті за рахунок ванільно-цукрової глазурі. "
  Delivery.insert
    min_weight: 0
    max_weight: 10
    price: 0
  Delivery.insert
    min_weight: 10
    max_weight: 30
    price: 50
  Delivery.insert
    min_weight: 30
    max_weight: 50
    price: 100
  Delivery.insert
    min_weight: 50
    max_weight: 100
    price: 150
  Delivery.insert
    min_weight: 100
    max_weight: 200
    price: 200
  Discounts.insert
    value: '0%'
    number: 0
  Discounts.insert
    value: '5%'
    number: 0.05
  Discounts.insert
    value: '10%'
    number: 0.1
  Discounts.insert
    value: '15%'
    number: 0.15
  Discounts.insert
    value: '20%'
    number: 0.2
