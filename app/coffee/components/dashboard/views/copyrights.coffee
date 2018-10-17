module.exports = angular.module "copycat.dashboard.copyrights", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Copyrights'
      sref: 'app.copyrights'
      imgpath: 'app/img/icons/clipboard.svg'
      order: 3
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state 'app.copyrights',
      url: '/copyrights'
      title: 'Copyrights'
      templateUrl: 'copyrights.html'
      require: [
        
      ]
]

.controller "CopyrightsController", [
  '$scope', '$http'
  ($scope, $http) ->
    $scope.totalItems = 0
    $scope.currentPage = 0
    $scope.pageLimit = 4

    $scope.pageChanged = () ->
      console.log 'currentPage: ' + $scope.currentPage
      return

    getCopyrights = (page) ->
      $http.get '/api/v1/user/copyrights', {params:{}}
        .then (resp) ->
          if resp.data.success
            $scope.copyrights = resp.data.copyrights
            $scope.totalItems = $scope.copyrights.length
            console.log($scope.copyrights)
        , (resp) ->

    getCopyrights()
]