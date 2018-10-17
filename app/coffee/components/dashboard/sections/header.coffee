module.exports = angular.module "copycat.dashboard.header", [

]

.controller "HeaderController", [
  '$uibModal'
  ($uibModal) ->
    vm = this

    activate = ->
      # Header Search

      vm.openModalSearch = ->
        modalSearchInstance = $uibModal.open(
          animation: true
          templateUrl: 'app/views/header-search.tpl.html'
          controller: 'HeaderModalSearchController as mod'
          windowClass: 'modal-top'
          backdropClass: 'modal-backdrop-soft'
          resolve: data: ->
            { title: 'Search' }
        )
        modalSearchInstance.result.then (->
          # use data from modal here
          return
        ), ->
          # Modal dismissed
          return
        return

      # Settings panel (right sidebar)

      vm.openModalBar = ->
        modalBarInstance = $uibModal.open(
          animation: true
          templateUrl: 'app/views/settings.tpl.html'
          controller: 'HeaderModalController as mod'
          windowClass: 'modal-right'
          backdropClass: 'modal-backdrop-soft'
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

.controller "HeaderModalController", [
  '$uibModalInstance', 'data'
  ($uibModalInstance, data) ->
    vm = this

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

.controller "HeaderModalSearchController", [
  '$uibModalInstance', '$timeout', 'data'
  ($uibModalInstance, $timeout, data) ->
    vm = this

    activate = ->
      vm.modalTitle = data.title
      # input autofocus
      $timeout (->
        document.querySelector('.header-input-search').focus()
        return
      ), 300

      vm.close = ->
        $uibModalInstance.close()
        return

      vm.cancel = ->
        $uibModalInstance.dismiss 'cancel'
        return

      return

    activate()
]