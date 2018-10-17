module.exports = angular.module "copycat.dashboard.home", [
  'ui.bootstrap'

]


.controller "MainCtrl", [
  '$log', '$scope', '$http'
  ($log, $scope, $http) ->
    $log.log('Main')
]
.controller "DashboardCtrl", [
  '$log', '$scope', '$http', 'md5'
  ($log, $scope, $http, md5) ->
    $log.log('DashboardCtrl')
    $scope.orgs = new Array()
    $scope.repos = new Array()
    $scope.copyrights = new Array()
    $scope.user = {}


    $scope.getRepos = () ->
      $http.get '/api/v1/user/repos', {params:{}}
        .then (resp) ->
          if resp.data.success
            $scope.orgs = resp.data.data.orgs
            console.log(resp.data.user)
            $scope.user = resp.data.user
            console.log($scope.orgs)
            $scope.user.emailHash = md5.createHash($scope.user.email.trim().toLowerCase())
            $scope.repoCount = 0
            i = 0
            while i < $scope.orgs.length
              $scope.repoCount += $scope.orgs[i].repos.length
              i++
        , (resp) ->

    $scope.getCopyrights = () ->
      $http.get '/api/v1/user/copyrights', {params:{}}
        .then (resp) ->
          if resp.data.success
            $scope.copyrights = resp.data.copyrights
            console.log($scope.copyrights)
        , (resp) ->

    $scope.monitor = (owner, name, repo_id) ->
      $http.post '/api/v1/user/monitor', {owner: owner, name: name, repo_id: repo_id}
        .then (resp) ->
          if resp.data.success
            $log.log resp.data
        , (resp) ->


    $scope.getRepos()
    $scope.getCopyrights()
]
.controller "AdminCtrl", [
  '$log', '$scope', '$http', 'md5'
  ($log, $scope, $http, md5) ->
    $log.log('DashboardCtrl')
    $scope.orgs = new Array()
    $scope.copyrights = new Array()

    $scope.getPurchasedCopyrights = () ->
      $http.get '/api/v1/admin/copyrights', {params:{}}
        .then (resp) ->
          if resp.data.success
            $scope.copyrights = resp.data.copyrights
            console.log($scope.copyrights)
        , (resp) ->

    $scope.getPurchasedCopyrights()
]
