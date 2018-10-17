module.exports = angular.module "copycat.dashboard.preloader", [

]

.directive "preloader", [
  '$animate', '$timeout', '$q'
  ($animate, $timeout, $q) ->
    link = (scope, el) ->
      startCounter = ->
        remaining = 100 - counter
        counter = counter + 0.0175 * (1 - Math.sqrt(remaining)) ** 2
        scope.loadCounter = parseInt(counter, 10)
        timeout = $timeout(startCounter, 20)
        return

      endCounter = ->
        $timeout.cancel timeout
        scope.loadCounter = 100
        $timeout (->
          # animate preloader hiding
          $animate.addClass el, 'preloader-hidden'
          # retore scrollbar
          angular.element('body').css 'overflow', ''
          return
        ), 300
        return

      appReady = ->
        deferred = $q.defer()
        fired = 0
        # if this doesn't sync with the real app ready
        # a custom event must be used instead
        _off = scope.$on('$viewContentLoaded', ->
          fired++
          # Wait for two events since we have two main ui-view
          if fired > 1
            deferred.resolve()
            _off()
          return
        )
        deferred.promise

      scope.loadCounter = 0
      counter = 0
      timeout = undefined
      # disables scrollbar
      angular.element('body').css 'overflow', 'hidden'
      # ensure class is present for styling
      el.addClass 'preloader'
      appReady().then ->
        $timeout endCounter, 500
        return
      timeout = $timeout(startCounter)

    restrict: 'EAC'
    template: '<div class="preloader-progress">' + '<div class="preloader-progress-bar" ' + 'ng-style="{width: loadCounter + \'%\'}"></div>' + '</div>'
    link: link
]