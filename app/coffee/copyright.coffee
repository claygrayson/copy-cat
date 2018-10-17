require 'jquery'
require 'angular'
require 'angular-ui-router'
require 'bootstrap'

require 'angular-bootstrap'

require '../../public/js/templates'
require './components/copyright/index.coffee'

module.exports = angular.module 'copycat.copyright', [
  'ui.router'
  'ui.bootstrap'
  'copycat.templates'
  'copycat.copyright.home'
]

.run([
  '$log'
  ($log) ->
])

.config([
  '$stateProvider', '$urlRouterProvider'
  ($stateProvider,   $urlRouterProvider) ->
    $stateProvider.state("home",
      url: "/"
      controller: "CopyrightCtrl"
      templateUrl: "copyright/templates/copyright.html"
    )

    # if none of the above states are matched, use this as the fallback
    $urlRouterProvider.otherwise "/"
])
