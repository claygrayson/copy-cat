module.exports = angular.module "copycat.dashboard.sidebar", [

]

.directive "sidebarNav", [
  () ->
    link = (scope, element) ->
      element.on 'click', (event) ->
        item = getItemElement(event)
        # check click is on a tag
        if !item
          return
        ele = angular.element(item)
        liparent = ele.parent()[0]
        lis = ele.parent().parent().children()
        # markup: ul > li > a
        # remove .active from childs
        lis.find('li').removeClass 'active'
        # remove .active from siblings ()
        angular.forEach lis, (li) ->
          if li != liparent
            angular.element(li).removeClass 'active'
          return
        next = ele.next()
        if next.length and next[0].tagName == 'UL'
          ele.parent().toggleClass 'active'
          event.preventDefault()
        return
      return

    # find the a element in click context
    # doesn't check deeply, asumens two levels only

    getItemElement = (event) ->
      element = event.target
      parent = element.parentNode
      if element.tagName.toLowerCase() == 'a'
        return element
      if parent.tagName.toLowerCase() == 'a'
        return parent
      if parent.parentNode.tagName.toLowerCase() == 'a'
        return parent.parentNode
      return

    {
        restrict: 'EAC'
        link: link
    }
]

.run [
  '$rootScope', '$window', '$document', '$timeout', 'APP_MEDIAQUERY'
  ($rootScope, $window, $document, $timeout, APP_MEDIAQUERY) ->
    # Sidebar API for mobile
    #/////

    toggleSidebarState = (state) ->
      #  state === true -> open
      #  state === false -> close
      #  state === undefined -> toggle
      $rootScope.sidebarVisible = if angular.isDefined(state) then state else !$rootScope.sidebarVisible
      return

    isMobileScreen = ->
      $window.innerWidth < APP_MEDIAQUERY.desktop

    $rootScope.toggleSidebar = toggleSidebarState

    $rootScope.closeSidebar = ->
      toggleSidebarState false
      return

    $rootScope.openSidebar = ->
      toggleSidebarState true
      return

    # Sidebar offcanvas API for desktops

    $rootScope.toggleSidebarOffcanvasVisible = (state) ->
      $rootScope.sidebarOffcanvasVisible = if angular.isDefined(state) then state else !$rootScope.sidebarOffcanvasVisible
      return

    # ESC key close sidebar
    $document.on 'keyup', (e) ->
      if e.keyCode == 27
        $timeout ->
          $rootScope.toggleSidebarOffcanvasVisible false
          return
      return
    # Considerations for different APP states
    # on mobiles, sidebar starts off-screen
    if isMobileScreen()
      $timeout ->
        toggleSidebarState false
        return
    # hide sidebar when open a new view
    $rootScope.$on '$stateChangeStart', ->
      if isMobileScreen()
        toggleSidebarState false
      else
        $rootScope.toggleSidebarOffcanvasVisible false
      return
    # remove desktop offcanvas when app changes to mobile
    # so when it returns, the sidebar is shown again
    $window.addEventListener 'resize', ->
      if isMobileScreen()
        $rootScope.toggleSidebarOffcanvasVisible false
      return
]