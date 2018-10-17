module.exports = angular.module "copycat.dashboard.utils", [

]

.service "Browser", [
  '$window'
  ($window) ->
    $window.jQBrowser
]

.directive "toggleFullscreen", [
  'Browser'
  (Browser) ->
    link = (scope, element) ->
      # Not supported under IE
      if Browser.msie
        element.addClass 'hide'
      else
        element.on 'click', (e) ->
          e.preventDefault()
          if screenfull.enabled
            screenfull.toggle()
          else
            # Fullscreen not enabled ;
          return
      return
    link: link,
    restrict: 'A'
]

.directive "svgReplace", [
  '$compile', '$http', '$templateCache', '$timeout'
  ($compile, $http, $templateCache, $timeout) ->
    link = (scope, element, attrs) ->
      $timeout ->
        src = attrs.src
        if !src or src.indexOf('.svg') < 0
          throw 'only support for SVG images'
        # return /*only support for SVG images*/
        $http.get(src, cache: $templateCache).success (res) ->
          element.replaceWith $compile(res)(scope)
          return
        return
      return
    link: link,
    restrict: 'A'
]

.directive "triggerResize", [
  '$window', '$timeout'
  ($window, $timeout) ->
    link = (scope, element) ->
      element.on 'click', ->
        $timeout ->
          $window.dispatchEvent new Event('resize')
          return
        return
      return
    link: link,
    restrict: 'A'
]