module.exports = angular.module "copycat.dashboard.dashboard", [
  'copycat.dashboard.colors'
]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Dashboard'
      sref: 'app.dashboard'
      imgpath: 'app/img/icons/aperture.svg'
      order: 1
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state 'app.dashboard',
      url: '/dashboard'
      title: 'Dashboard'
      templateUrl: 'dashboard.html'
      require: [
        'angular-flot'
        'sparkline'
        'ngTable'
      ]
]

.controller "DashboardController", [
  '$scope', '$http', 'ngTableParams', 'Colors'
  ($scope, $http, ngTableParams, Colors) ->
    $scope.donutData = [
      {
        'color': '#4CAF50'
        'data': 60
        'label': 'Triggered'
      }
      {
        'color': '#009688'
        'data': 90
        'label': 'Purchased'
      }
      {
        'color': '#FFC107'
        'data': 50
        'label': 'Submitted'
      }
      {
        'color': '#FF7043'
        'data': 80
        'label': 'Awarded'
      }
      {
        'color': '#3949AB'
        'data': 116
        'label': 'Cancelled'
      }
    ]
    $scope.sparkValues = [
      4
      4
      3
      5
      3
      4
      6
      5
      3
      2
      3
      4
      6
    ]
    $scope.sparkOpts =
      type: 'line'
      height: 20
      width: '70'
      lineWidth: 2
      valueSpots: '0:': Colors.byName('blue-700')
      lineColor: Colors.byName('blue-700')
      spotColor: Colors.byName('blue-700')
      fillColor: 'transparent'
      highlightLineColor: Colors.byName('blue-700')
      spotRadius: 0

    $scope.stacked = []
    types = [
      'success'
      'info'
      'warning'
      'danger'
    ]

    $scope.stacked.push
      value: 5
      type: 'success'
    $scope.stacked.push
      value: 10
      type: 'info'
    $scope.stacked.push
      value: 85
      type: 'danger'

    # i = 0
    # n = 3
    # while i < n
    #   index = Math.floor(Math.random() * 4)
    #   $scope.stacked.push
    #     value: Math.floor(Math.random() * 30 + 1)
    #     type: types[index]
    #   i++

    $scope.orgs = new Array()
    $scope.personal = {}
    $scope.totalRepos = 0
    $scope.totalCopyrights = 0

    $scope.date = new Date("2016-08-12T18:50:31.555Z")

    getOrganizations = () ->
      $http.get '/api/v1/user/dashboard'
        .then (resp) ->
          if resp.data.success
            $scope.orgs = resp.data.data
            for org in $scope.orgs
              $scope.totalRepos += org.num_repos
        , (resp) ->

    getOrganizations()
]