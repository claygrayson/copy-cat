module.exports = angular.module "copycat.dashboard.core", [
  'copycat.dashboard.router'
  'ngRoute'
  'ngAnimate'
  'ngStorage'
  'ngCookies'
  'ngMessages'
  'ngtimeago'
  'pascalprecht.translate'
  'ui.bootstrap'
  'cfp.loadingBar'
  'ngSanitize'
  'ngResource'
  'ui.utils'
]

.config [
  '$controllerProvider', '$compileProvider', '$filterProvider', '$provide'
  ($controllerProvider, $compileProvider, $filterProvider, $provide) ->
    core = angular.module('copycat.dashboard.core')
    # registering components after bootstrap
    core.controller = $controllerProvider.register
    core.directive = $compileProvider.directive
    core.filter = $filterProvider.register
    core.factory = $provide.factory
    core.service = $provide.service
    core.constant = $provide.constant
    core.value = $provide.value
]

.constant 'APP_MEDIAQUERY',
  'desktopLG': 1200
  'desktop': 992
  'tablet': 767
  'mobile': 480

.run [
  '$rootScope', 'Colors'
  ($rootScope, Colors) ->
    $rootScope.colorByName = Colors.byName
]

.run [
  'Router'
  (Router) ->
    Router.state 'app',
      url: '/app'
      abstract: true
      templateUrl: 'core.layout.html'
      require: [
        'icons'
        'ng-mfb'
        'md-colors'
        'screenfull'
      ]
]

.run [
  '$rootScope'
  ($rootScope) ->
    $rootScope.theme = ->
      $rootScope.app.theme

    $rootScope.layout = ->
      [
        if $rootScope.sidebarVisible then 'sidebar-visible' else ''
        if $rootScope.app.sidebar.offcanvas then 'sidebar-offcanvas' else ''
        if $rootScope.sidebarOffcanvasVisible then 'offcanvas-visible' else ''
      ].join ' '
]