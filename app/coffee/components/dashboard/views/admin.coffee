module.exports = angular.module "copycat.dashboard.admin", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Admin'
      sref: 'app.admin'
      imgpath: 'app/img/icons/person-stalker.svg'
      order: 2
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state 'app.admin',
      url: '/admin'
      title: 'Admin'
      templateUrl: 'admin.html'
      require: [

      ]
]

.controller "AdminController", [
  '$scope', '$http'
  ($scope, $http) ->
]