module.exports = angular.module "copycat.dashboard.user", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'User'
      sref: 'user'
      order: 9
      iconclass: 'ion-person-stalker'
      imgpath: 'app/img/icons/person-stalker.svg'
      subitems: [
        {
          name: 'Login'
          sref: 'user.login'
        }
        {
          name: 'Signup'
          sref: 'user.signup'
        }
        {
          name: 'Lock'
          sref: 'user.lock'
        }
        {
          name: 'Recover'
          sref: 'user.recover'
        }
      ]
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state('user',
      url: '/user'
      title: 'User'
      abstract: true
      template: '<div class="page-container bg-blue-grey-900"><div ui-view class="ng-fadeInLeftShort"></div></div>'
      require: [
        'modernizr'
        'icons'
        'ng-mfb'
        'md-colors'
      ])
    .state('user.login',
      url: '/login'
      title: 'Login'
      templateUrl: 'login.html')
    .state('user.signup',
      url: '/signup'
      title: 'Signup'
      templateUrl: 'signup.html')
    .state('user.lock',
      url: '/lock'
      title: 'Lock'
      templateUrl: 'lock.html')
    .state 'user.recover',
      url: '/recover'
      title: 'Recover'
      templateUrl: 'recover.html'
]