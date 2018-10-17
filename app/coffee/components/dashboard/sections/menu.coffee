module.exports = angular.module "copycat.dashboard.menu", [

]

.controller "MenuController", [
  'Menu'
  (Menu) ->
    vm = this

    activate = ->
      vm.items = Menu.getItems()
      return

    activate()
]

.service "Menu", [
  () ->
    ### jshint validthis:true ###

    addItem = (item) ->
      validate item
      @menu.push item
      return

    getItems = ->
      @menu

    # validate items and throw error when can't recover

    validate = (item) ->
      if !angular.isDefined(item)
        throw new Error('Menu item not defined.')
      if !angular.isDefined(item.name)
        throw new Error('Menu item name not defined.')
      if !angular.isDefined(item.order)
        item.order = 0
      # order must exists
      # item ok
      item

    {
      addItem: addItem
      getItems: getItems
      menu: []
    }
]