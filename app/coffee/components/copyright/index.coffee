module.exports = angular.module "copycat.copyright.home", [

]

.controller "CopyrightCtrl", [
  '$log', '$scope', '$http', '$location'
  ($log, $scope, $http, $location) ->
    $log.log('CopyrightCtrl')

    $scope.copyright = {}
    $scope.active = 3

    disabled = (data) ->
      date = data.date
      mode = data.mode
      mode == 'day' and (date.getDay() == 0 or date.getDay() == 6)

    getDayClass = (data) ->
      date = data.date
      mode = data.mode
      if mode == 'day'
        dayToCheck = new Date(date).setHours(0, 0, 0, 0)
        i = 0
        while i < $scope.events.length
          currentDay = new Date($scope.events[i].date).setHours(0, 0, 0, 0)
          if dayToCheck == currentDay
            return $scope.events[i].status
          i++
      ''

    $scope.today = ->
      $scope.dt = new Date
      return

    $scope.today()

    $scope.clear = ->
      $scope.dt = null
      return

    $scope.options =
      customClass: getDayClass
      minDate: new Date
      showWeeks: true

    $scope.toggleMin = ->
      $scope.options.minDate = if $scope.options.minDate then null else new Date
      return

    $scope.toggleMin()

    $scope.setDate = (year, month, day) ->
      $scope.dt = new Date(year, month, day)
      return

    tomorrow = new Date
    tomorrow.setDate tomorrow.getDate() + 1
    afterTomorrow = new Date(tomorrow)
    afterTomorrow.setDate tomorrow.getDate() + 1
    $scope.events = [
      {
        date: tomorrow
        status: 'full'
      }
      {
        date: afterTomorrow
        status: 'partially'
      }
    ]

    # Steps Circles
    i = 1
    $('#progress-container > ul > li').each ->
      if i < $scope.active
        $(this).toggleClass 'done'
      else if i == $scope.active
        $(this).toggleClass 'active'
        texto = $(this).text()
        $(this).children('::after').css 'content', i
        $(this).append i
      else
        $(this).append i
      i++
      return

    $scope.getCopyright = ->
      $http.get '/api/v1/copyright/' + $location.absUrl().split("/")[4] || '', {params:{}}
        .then (resp) ->
          if resp.data.success
            $scope.copyright = resp.data.copyright
        , (resp) ->

    $scope.getCopyright()
]
