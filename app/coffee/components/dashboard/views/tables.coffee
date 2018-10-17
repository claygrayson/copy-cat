module.exports = angular.module "copycat.dashboard.tables", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Tables'
      sref: 'app.tables'
      order: 5
      imgpath: 'app/img/icons/navicon.svg'
      subitems: [
        {
          name: 'Classic'
          sref: 'app.tables.classic'
        }
        {
          name: 'Datatable'
          sref: 'app.tables.datatable'
        }
        {
          name: 'ngTable'
          sref: 'app.tables.ngtable'
        }
        {
          name: 'xEditable'
          sref: 'app.tables.xeditable'
        }
      ]
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state('app.tables',
      url: '/tables'
      title: 'Tables'
      abstract: true
      template: '<div ui-view class="ng-fadeInLeftShort"></div>')
    .state('app.tables.classic',
      url: '/classic'
      title: 'Tables Classic'
      templateUrl: 'tables.classic.html')
    .state('app.tables.datatable',
      url: '/data'
      title: 'Tables Data'
      templateUrl: 'datatable.html'
      require: [ 'datatables' ])
    .state('app.tables.ngtable',
      url: '/ngtable'
      title: 'ngTable'
      templateUrl: 'ngtable.html'
      require: [
        'ngTable'
        'ngTableExport'
      ])
    .state 'app.tables.xeditable',
      url: '/xeditable'
      title: 'Tables Xeditable'
      templateUrl: 'xeditable.table.html'
      require: [ 'xeditable' ]
]

.controller "TablexEditableController", [
  '$filter', '$http', 'editableOptions', 'editableThemes', '$q'
  ($filter, $http, editableOptions, editableThemes, $q) ->
    vm = this
    #//////////////

    activate = ->
      editableOptions.theme = 'bs3'
      # editable row
      # -----------------------------------
      vm.users = [
        {
          id: 1
          name: 'awesome user1'
          status: 2
          group: 4
          groupName: 'admin'
        }
        {
          id: 2
          name: 'awesome user2'
          status: undefined
          group: 3
          groupName: 'vip'
        }
        {
          id: 3
          name: 'awesome user3'
          status: 2
          group: null
        }
      ]
      vm.statuses = [
        {
          value: 1
          text: 'status1'
        }
        {
          value: 2
          text: 'status2'
        }
        {
          value: 3
          text: 'status3'
        }
        {
          value: 4
          text: 'status4'
        }
      ]
      vm.groups = []

      vm.loadGroups = ->
        if vm.groups.length then null else $http.get('server/xeditable-groups.json').success(((data) ->
          vm.groups = data
          return
        ))

      vm.showGroup = (user) ->
        if user.group and vm.groups.length
          selected = $filter('filter')(vm.groups, id: user.group)
          if selected.length then selected[0].text else 'Not set'
        else
          user.groupName or 'Not set'

      vm.showStatus = (user) ->
        selected = []
        if user.status
          selected = $filter('filter')(vm.statuses, value: user.status)
        if selected.length then selected[0].text else 'Not set'

      vm.checkName = (data, id) ->
        if id == 2 and data != 'awesome'
          return 'Username 2 should be `awesome`'
        return

      vm.saveUser = (data, id) ->
        #vm.user not updated yet
        angular.extend data, id: id
        console.log 'Saving user: ' + id
        # return $http.post('/saveUser', data);
        return

      # remove user

      vm.removeUser = (index) ->
        vm.users.splice index, 1
        return

      # add user

      vm.addUser = ->
        vm.inserted =
          id: vm.users.length + 1
          name: ''
          status: null
          group: null
          isNew: true
        vm.users.push vm.inserted
        return

      # editable column
      # -----------------------------------

      vm.saveColumn = (column) ->
        results = []
        angular.forEach vm.users, ->
          # results.push($http.post('/saveColumn', {column: column, value: user[column], id: user.id}));
          console.log 'Saving column: ' + column
          return
        $q.all results

      # editable table
      # -----------------------------------
      # filter users to show

      vm.filterUser = (user) ->
        user.isDeleted != true

      # mark user as deleted

      vm.deleteUser = (id) ->
        filtered = $filter('filter')(vm.users, id: id)
        if filtered.length
          filtered[0].isDeleted = true
        return

      # cancel all changes

      vm.cancel = ->
        i = vm.users.length
        while i--
          user = vm.users[i]
          # undelete
          if user.isDeleted
            delete user.isDeleted
          # remove new
          if user.isNew
            vm.users.splice i, 1
        return

      # save edits

      vm.saveTable = ->
        results = []
        i = vm.users.length
        while i--
          user = vm.users[i]
          # actually delete user
          if user.isDeleted
            vm.users.splice i, 1
          # mark as not new
          if user.isNew
            user.isNew = false
          # send on server
          # results.push($http.post('/saveUser', user))
          console.log 'Saving Table...'
        $q.all results

      return

    activate()
]

.controller "DataTableController", [
  '$resource', 'DTOptionsBuilder', 'DTColumnDefBuilder', 'DTDefaultOptions'
  ($resource, DTOptionsBuilder, DTColumnDefBuilder, DTDefaultOptions) ->
    vm = this
    #//////////////

    activate = ->
      # Override the Bootstrap default options

      _buildPerson2Add = (id) ->
        {
          id: id
          firstName: 'Foo' + id
          lastName: 'Bar' + id
        }

      addPerson = ->
        vm.heroes.push angular.copy(vm.person2Add)
        vm.person2Add = _buildPerson2Add(vm.person2Add.id + 1)
        return

      modifyPerson = (index) ->
        vm.heroes.splice index, 1, angular.copy(vm.person2Add)
        vm.person2Add = _buildPerson2Add(vm.person2Add.id + 1)
        return

      removePerson = (index) ->
        vm.heroes.splice index, 1
        return

      DTDefaultOptions.setBootstrapOptions pagination: classes: ul: 'pagination pagination-rounded'
      vm.dtOptionsBs = DTOptionsBuilder.newOptions().withPaginationType('full_numbers').withDisplayLength(2).withBootstrap().withLanguage(
        sSearch: '<em class="ion-search"></em>'
        oPaginate:
          sFirst: '<em class="ion-arrow-left-b"></em>'
          sLast: '<em class="ion-arrow-right-b"></em>'
          sNext: '<em class="ion-ios-arrow-right"></em>'
          sPrevious: '<em class="ion-ios-arrow-left"></em>')
      # Dynamic
      vm.dtOptions = DTOptionsBuilder.newOptions().withPaginationType('numbers').withDisplayLength(5).withBootstrap().withLanguage(
        sSearch: '<em class="ion-search"></em>'
        oPaginate:
          sFirst: '<em class="ion-arrow-left-b"></em>'
          sLast: '<em class="ion-arrow-right-b"></em>'
          sNext: '<em class="ion-ios-arrow-right"></em>'
          sPrevious: '<em class="ion-ios-arrow-left"></em>')
      vm.dtColumnDefs = [
        DTColumnDefBuilder.newColumnDef(0)
        DTColumnDefBuilder.newColumnDef(1)
        DTColumnDefBuilder.newColumnDef(2)
        DTColumnDefBuilder.newColumnDef(3).notSortable()
      ]
      $resource('server/datatable.json').query().$promise.then (persons) ->
        vm.persons = persons
        return
      # Change data
      vm.heroes = [
        {
          'id': 860
          'firstName': 'Superman'
          'lastName': 'Yoda'
        }
        {
          'id': 870
          'firstName': 'Ace'
          'lastName': 'Ventura'
        }
        {
          'id': 590
          'firstName': 'Flash'
          'lastName': 'Gordon'
        }
        {
          'id': 870
          'firstName': 'Ace'
          'lastName': 'Ventura'
        }
        {
          'id': 590
          'firstName': 'Flash'
          'lastName': 'Gordon'
        }
        {
          'id': 803
          'firstName': 'Luke'
          'lastName': 'Skywalker'
        }
      ]
      vm.person2Add = _buildPerson2Add(1)
      vm.addPerson = addPerson
      vm.modifyPerson = modifyPerson
      vm.removePerson = removePerson
      return

    activate()
]

.controller "NgTableController", [
  '$scope', '$filter', 'ngTableParams'
  ($scope, $filter, ngTableParams) ->
    vm = this
    # SORTING
    data = [
      {
        name: 'Moroni'
        age: 50
        money: -10
      }
      {
        name: 'Tiancum'
        age: 43
        money: 120
      }
      {
        name: 'Jacob'
        age: 27
        money: 5.5
      }
      {
        name: 'Nephi'
        age: 29
        money: -54
      }
      {
        name: 'Enos'
        age: 34
        money: 110
      }
      {
        name: 'Tiancum'
        age: 43
        money: 1000
      }
      {
        name: 'Jacob'
        age: 27
        money: -201
      }
      {
        name: 'Nephi'
        age: 29
        money: 100
      }
      {
        name: 'Enos'
        age: 34
        money: -52.5
      }
      {
        name: 'Tiancum'
        age: 43
        money: 52.1
      }
      {
        name: 'Jacob'
        age: 27
        money: 110
      }
      {
        name: 'Nephi'
        age: 29
        money: -55
      }
      {
        name: 'Enos'
        age: 34
        money: 551
      }
      {
        name: 'Tiancum'
        age: 43
        money: -1410
      }
      {
        name: 'Jacob'
        age: 27
        money: 410
      }
      {
        name: 'Nephi'
        age: 29
        money: 100
      }
      {
        name: 'Enos'
        age: 34
        money: -100
      }
    ]
    vm.tableParams = new ngTableParams({
      page: 1
      count: 10
      sorting: name: 'asc'
    },
      total: data.length
      getData: ($defer, params) ->
        # use build-in angular filter
        orderedData = if params.sorting() then $filter('orderBy')(data, params.orderBy()) else data
        $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
        return
    )
    # FILTERS
    vm.tableParams2 = new ngTableParams({
      page: 1
      count: 10
      filter:
        name: ''
        age: ''
    },
      total: data.length
      getData: ($defer, params) ->
        # use build-in angular filter
        orderedData = if params.filter() then $filter('filter')(data, params.filter()) else data
        vm.users = orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
        params.total orderedData.length
        # set total for recalc pagination
        $defer.resolve vm.users
        return
    )
    # SELECT ROWS
    vm.data = data
    vm.tableParams3 = new ngTableParams({
      page: 1
      count: 10
    },
      total: data.length
      getData: ($defer, params) ->
        # use build-in angular filter
        filteredData = if params.filter() then $filter('filter')(data, params.filter()) else data
        orderedData = if params.sorting() then $filter('orderBy')(filteredData, params.orderBy()) else data
        params.total orderedData.length
        # set total for recalc pagination
        $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
        return
    )

    vm.changeSelection = ->
      # console.info(user);
      return

    # Editable
    $scope.tableParams4 = new ngTableParams({
      page: 1
      count: 10
    },
      total: data.length
      getData: ($defer, params) ->
        $defer.resolve data.slice((params.page() - 1) * params.count(), params.page() * params.count())
        return
    )
    # EXPORT CSV
    data5 = [
      {
        name: 'Moroni'
        age: 50
      }
      {
        name: 'Tiancum'
        age: 43
      }
      {
        name: 'Jacob'
        age: 27
      }
      {
        name: 'Nephi'
        age: 29
      }
      {
        name: 'Enos'
        age: 34
      }
      {
        name: 'Tiancum'
        age: 43
      }
      {
        name: 'Jacob'
        age: 27
      }
      {
        name: 'Nephi'
        age: 29
      }
      {
        name: 'Enos'
        age: 34
      }
      {
        name: 'Tiancum'
        age: 43
      }
      {
        name: 'Jacob'
        age: 27
      }
      {
        name: 'Nephi'
        age: 29
      }
      {
        name: 'Enos'
        age: 34
      }
      {
        name: 'Tiancum'
        age: 43
      }
      {
        name: 'Jacob'
        age: 27
      }
      {
        name: 'Nephi'
        age: 29
      }
      {
        name: 'Enos'
        age: 34
      }
    ]
    vm.tableParams5 = new ngTableParams({
      page: 1
      count: 10
    },
      total: data5.length
      getData: ($defer, params) ->
        $defer.resolve data5.slice((params.page() - 1) * params.count(), params.page() * params.count())
        return
    )
]