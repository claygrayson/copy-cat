module.exports = angular.module "copycat.dashboard.floatbutton", [

]

.controller "FloatButtonController", [
  '$window'
  ($window) ->
    vm = this

    activate = ->

      loc = (href) ->
        $window.location.href = href
        return

      mainAction = ->
        console.log 'Firing Main Action!'
        return

      hovered = ->
        # toggle something on hover.
        return

      vm.menuState = 'closed'
      vm.loc = loc
      vm.mainAction = mainAction
      vm.hovered = hovered
      vm.chosen =
        effect: 'zoomin'
        position: 'br'
        method: 'click'
        action: 'fire'
      vm.buttons = [
        {
          label: 'View on Github'
          icon: 'ion-social-github'
          href: '//github.com/nobitagit/ng-material-floating-button/'
        }
        {
          label: 'Follow me on Github'
          icon: 'ion-social-octocat'
          href: '//github.com/nobitagit'
        }
        {
          label: 'Share on Twitter'
          icon: 'ion-social-twitter'
          href: '//twitter.com/share?text=Amazing material floating action button directive'/
                '!&url=http://nobitagit.github.io/ng-material-floating-button/&hashtags=angular,material,design,button'
        }
      ]

      vm.toggle = ->
        @menuState = if @menuState == 'closed' then 'open' else 'closed'
        return

      vm.closeMenu = ->
        @menuState = 'closed'
        return

      return

    activate()
]