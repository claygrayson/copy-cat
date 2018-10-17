module.exports = angular.module "copycat.dashboard.pages", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Pages'
      sref: 'app.pages'
      order: 8
      imgpath: 'app/img/icons/ios-browsers.svg'
      subitems: [
        {
          name: 'Blog'
          sref: 'app.pages.blog'
        }
        {
          name: 'Article'
          sref: 'app.pages.article'
        }
        {
          name: 'Profile'
          sref: 'app.pages.profile'
        }
        {
          name: 'Gallery'
          sref: 'app.pages.gallery'
        }
        {
          name: 'Wall'
          sref: 'app.pages.wall'
        }
        {
          name: 'Search'
          sref: 'app.pages.search'
        }
        {
          name: 'Messages Board'
          sref: 'app.pages.messages'
        }
      ]
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state('app.pages',
      url: '/pages'
      abstract: true
      template: '<div ui-view class="ng-fadeInLeftShort"></div>')
    .state('app.pages.blog',
      url: '/Blog'
      title: 'Blog'
      templateUrl: 'blog.html')
    .state('app.pages.article',
      url: '/Article'
      title: 'Article'
      templateUrl: 'blog.article.html')
    .state('app.pages.profile',
      url: '/Profile'
      title: 'Profile'
      templateUrl: 'profile.html'
      require: [ 'xeditable' ])
    .state('app.pages.gallery',
      url: '/Gallery'
      title: 'Gallery'
      templateUrl: 'gallery.html'
      require: [ 'blueimp-gallery' ])
    .state('app.pages.wall',
      url: '/wall'
      title: 'Wall'
      templateUrl: 'wall.html')
    .state('app.pages.search',
      url: '/Search'
      title: 'Search'
      templateUrl: 'search.html')
    .state 'app.pages.messages',
      url: '/messages'
      title: 'Messages Board'
      templateUrl: 'messages.html'
]

.controller "MessagesController", [
  '$uibModal'
  ($uibModal) ->
    vm = this
    #//////////////

    activate = ->

      vm.display = ->
        modalBarInstance = $uibModal.open(
          animation: true
          templateUrl: 'app/views/messages.view.tpl.html'
          controller: 'MessageViewModalController as mod'
          windowClass: 'modal-right modal-auto-size'
          backdropClass: ''
          resolve: data: ->
            { title: 'Settings' }
        )
        modalBarInstance.result.then (->
          # use data from modal here
          return
        ), ->
          # Modal dismissed
          return
        return

      vm.compose = ->
        modalBarInstance = $uibModal.open(
          animation: true
          templateUrl: 'app/views/messages.new.tpl.html'
          controller: 'MessageNewModalController as mod'
          resolve: data: ->
            { title: 'Settings' }
        )
        modalBarInstance.result.then (->
          # use data from modal here
          return
        ), ->
          # Modal dismissed
          return
        return

      return

    activate()
]

.controller "MessageViewModalController", [
  '$uibModalInstance', 'data'
  ($uibModalInstance, data) ->
    vm = this
    #//////////////

    activate = ->
      vm.modalTitle = data.title

      vm.close = ->
        $uibModalInstance.close()
        return

      vm.cancel = ->
        $uibModalInstance.dismiss 'cancel'
        return

      return

    activate()
]

.controller "MessageNewModalController", [
  '$uibModalInstance', 'data'
  ($uibModalInstance, data) ->
    vm = this
    #//////////////

    activate = ->
      vm.modalTitle = data.title

      vm.close = ->
        $uibModalInstance.close()
        return

      vm.cancel = ->
        $uibModalInstance.dismiss 'cancel'
        return

      return

    activate()
]

.controller "ProfileController", [
  'editableOptions'
  (editableOptions) ->
    vm = this

    activate = ->
      editableOptions.theme = 'bs3'
      vm.genders = [
        {
          value: 0
          text: 'Female'
        }
        {
          value: 1
          text: 'Male'
        }
      ]
      vm.data =
        area: 'Research & development'
        birthday: new Date(2000, 10, 10)
        membersince: new Date(2015, 10, 5)
        gender: 0
        address: 'Some street, 123'
        email: 'user@mail.com'
        phone: '13-123-46578'
        about: 'Pellentesque porta tincidunt justo, non fringilla erat iaculis in. Sed nisi erat, ornare'/
        ' eu pellentesque quis, pellentesque non nulla. Proin rutrum, est pellentesque commodo mattis, sem'/
        ' justo porttitor odio, id aliquet lacus augue nec nisl.'

      vm.showGender = ->
        vm.genders[vm.data.gender].text

      return

    activate()
]