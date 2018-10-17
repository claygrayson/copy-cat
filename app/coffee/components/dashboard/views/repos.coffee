module.exports = angular.module "copycat.dashboard.repos", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Repos'
      sref: 'app.repos'
      imgpath: 'app/img/icons/ios-browsers.svg'
      order: 2
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state 'app.repos',
      url: '/repos'
      title: 'Repos'
      templateUrl: 'repos.html'
      require: [
        'the-cormoran.angular-loaders'
        'oitozero.ngSweetAlert'
      ]
]

.controller "ReposController", [
  '$log', '$scope', '$http', 'SweetAlert'
  ($log, $scope, $http, SweetAlert) ->
    $scope.reposLoaded = false
    $scope.processing = false
    $scope.processing_repo = -1

    getRepos = () ->
      $http.get '/api/v1/user/repos', {params:{}}
        .then (resp) ->
          if resp.data.success
            $scope.reposLoaded = true
            $scope.personal = resp.data.data.personal
            $scope.orgs = resp.data.data.orgs
            $scope.user = resp.data.user
        , (resp) ->

    $scope.monitor = (repo) ->
      $scope.processing = true
      $scope.processing_repo = repo.id

      endpoint = 'monitor'
      result = 'Monitor'
      if !repo.monitored
        endpoint = 'unmonitor'
        result = 'Unmonitor'

      $http.post '/api/v1/user/' + endpoint, {owner: repo.owner.login, name: repo.name, repo_id: repo.id}
        .then (resp) ->
          $scope.processing_repo = -1
          $scope.processing = false
          if resp.data.success
            SweetAlert.swal 'Success!', 'Repo Successfully ' + result + 'ed!', 'success'
          else
            SweetAlert.swal 'Error', 'Error ' + result + 'ing Repository', 'error'
        , (resp) ->
          $scope.processing_repo = -1
          $scope.processing = false
          SweetAlert.swal 'Error', 'Error ' + result + 'ing Repository', 'error'

    getRepos()
]