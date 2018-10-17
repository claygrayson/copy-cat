module.exports = angular.module "copycat.dashboard.layouts", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Layouts'
      sref: 'app.layouts'
      order: 5.1
      imgpath: 'app/img/icons/grid.svg'
      subitems: [
        {
          name: 'Columns'
          sref: 'app.layouts.columns'
        }
        {
          name: 'Overlap'
          sref: 'app.layouts.overlap'
        }
        {
          name: 'Boxed'
          sref: 'app.layouts.boxed'
        }
        {
          name: 'Tabs Deep Link'
          sref: 'app.layouts.tabs.home'
          srefParent: 'app.layouts.tabs'
        }
        {
          name: 'Containers'
          sref: 'app.layouts.containers'
        }
      ]
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state('app.layouts',
      url: '/layouts'
      title: 'Layouts'
      abstract: true
      template: '<div ui-view class="ng-fadeInLeftShort"></div>')
    .state('app.layouts.columns',
      url: '/columns'
      title: 'Columns'
      templateUrl: 'layouts.columns.html')
    .state('app.layouts.boxed',
      url: '/boxed'
      title: 'Boxed'
      templateUrl: 'layouts.boxed.html')
    .state('app.layouts.overlap',
      url: '/overlap'
      title: 'Overlap'
      templateUrl: 'layouts.overlap.html')
    .state('app.layouts.tabs',
      url: '/tabs'
      title: 'Tabs'
      abstract: true
      templateUrl: 'layouts.tabs.html')
    .state('app.layouts.tabs.home',
      url: '/home'
      title: 'Tabs Home'
      template: '<h4>Home view</h4>')
    .state('app.layouts.tabs.profile',
      url: '/profile'
      title: 'Tabs Profile'
      template: '<h4>Profile view</h4>')
    .state('app.layouts.tabs.messages',
      url: '/messages'
      title: 'Tabs Messages'
      template: '<h4>Messages view</h4>')
    .state 'app.layouts.containers',
      url: '/containers'
      title: 'Containers'
      templateUrl: 'layouts.containers.html'
]

.controller "TabsDeepController", [
  '$rootScope', '$state'
  ($rootScope, $state) ->
    vm = this

    activate = ->

      tabActive = ->
        vm.tabs.forEach (tab, id) ->
          vm.tabs[id].active = $state.is(tab.route)
          return
        return

      vm.tabs = [
        {
          heading: 'Home'
          route: 'app.layouts.tabs.home'
          active: false
        }
        {
          heading: 'Profile'
          route: 'app.layouts.tabs.profile'
          active: false
        }
        {
          heading: 'Messages'
          route: 'app.layouts.tabs.messages'
          active: false
        }
      ]

      vm.go = (route) ->
        $state.go route
        return

      $rootScope.$on '$stateChangeSuccess', tabActive
      tabActive()
      return

    activate()
]