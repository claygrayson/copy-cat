module.exports = angular.module "copycat.dashboard.loadingbar", [

]

.config [
  'cfpLoadingBarProvider'
  (cfpLoadingBarProvider) ->
    cfpLoadingBarProvider.includeBar = true
    cfpLoadingBarProvider.includeSpinner = true
    cfpLoadingBarProvider.latencyThreshold = 500
    #cfpLoadingBarProvider.parentSelector = ''
]

.run [
  '$rootScope', '$timeout', 'cfpLoadingBar'
  ($rootScope, $timeout, cfpLoadingBar) ->
    # Loading bar transition
    # -----------------------------------
    thBar = undefined
    $rootScope.$on '$stateChangeStart', ->
      thBar = $timeout((->
        cfpLoadingBar.start()
        return
      ), 0)
      # sets a latency Threshold
      return
    $rootScope.$on '$stateChangeSuccess', (event) ->
      event.targetScope.$watch '$viewContentLoaded', ->
        $timeout.cancel thBar
        cfpLoadingBar.complete()
        return
      return
]