module.exports = angular.module "copycat.dashboard.ripple", [

]

.run [
  '$window'
  ($window) ->
    # public interface
    ###*
    # Ripple effect for common components
    # @param [element] jQuery or jqLite element
    ###

    RippleEffect = (element) ->
      TRANSITION_END = 'transitionend webkitTransitionEnd'
      jq = angular.element
      @element = element
      @rippleElement = @getElement()
      @$rippleElement = jq(@rippleElement)
      clickEv = @detectClickEvent()
      self = this
      element.on clickEv, ->
        # remove animation on click
        self.$rippleElement.removeClass 'md-ripple-animate'
        # Set ripple size and position
        self.calcSizeAndPos()
        # start to animate
        self.$rippleElement.addClass 'md-ripple-animate'
        return
      @$rippleElement.on TRANSITION_END, ->
        self.$rippleElement.removeClass 'md-ripple-animate'
        # avoid weird affect when ripple is not active
        self.rippleElement.style.width = 0
        self.rippleElement.style.height = 0
        return
      return

    $window.Ripple = RippleEffect

    ###*
    # Returns the elements used to generate the effect
    # If not exists, it is created by appending a new
    # dom element
    ###

    RippleEffect::getElement = ->
      dom = @element[0]
      rippleElement = dom.querySelector('.md-ripple')
      if rippleElement == null
        # Create ripple
        rippleElement = document.createElement('span')
        rippleElement.className = 'md-ripple'
        # Add ripple to element
        @element.append rippleElement
      rippleElement

    ###*
    # Determines the better size for the ripple element
    # based on the element attached and calculates the
    # position be fully centered
    ###

    RippleEffect::calcSizeAndPos = ->
      size = Math.max(@element.width(), @element.height())
      @rippleElement.style.width = size + 'px'
      @rippleElement.style.height = size + 'px'
      # autocenter (requires css)
      @rippleElement.style.marginTop = -(size / 2) + 'px'
      @rippleElement.style.marginLeft = -(size / 2) + 'px'
      return

    RippleEffect::detectClickEvent = ->
      isIOS = /iphone|ipad/gi.test(navigator.appVersion)
      if isIOS then 'touchstart' else 'click'
]

.directive "ripple", [
  () ->
    link = (scope, element) ->
      new Ripple(element)
      return

    restrict: 'C',
    link: link
]