require 'jquery'
require 'angular'
require 'angular-ui-router'
require 'bootstrap'

require 'angular-bootstrap'

require '../../public/js/templates'
require './components/landing/index.coffee'

# module.exports = angular.module 'copycat.landing', [
#   'ui.router'
#   'ui.bootstrap'
#   'copycat.templates'
#   'copycat.landing.home'
# ]
#
# .run([
#   '$log'
#   ($log) ->
# ])
#
# .config([
#   '$stateProvider', '$urlRouterProvider'
#   ($stateProvider,   $urlRouterProvider) ->
#     $stateProvider.state("home",
#       url: "/"
#       controller: "LandingCtrl"
#       templateUrl: "landing/templates/landing.html"
#     )
#
#     # if none of the above states are matched, use this as the fallback
#     $urlRouterProvider.otherwise "/"
# ])
