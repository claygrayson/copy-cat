module.exports = angular.module "copycat.dashboard.cards", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Cards'
      sref: 'app.cards'
      order: 2
      imgpath: 'app/img/icons/radio-waves.svg'
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state 'app.cards',
      url: '/cards'
      title: 'Cards'
      templateUrl: 'cards.html'
      require: [
        'angular-flot'
        'easypiechart'
        'sparkline'
      ]
]