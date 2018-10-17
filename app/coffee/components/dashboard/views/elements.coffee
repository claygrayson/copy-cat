module.exports = angular.module "copycat.dashboard.elements", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Elements'
      sref: 'app.elements'
      imgpath: 'app/img/icons/levels.svg'
      order: 6
      subitems: [
        {
          name: 'Colors'
          sref: 'app.elements.colors'
        }
        {
          name: 'Whiteframes'
          sref: 'app.elements.whiteframes'
        }
        {
          name: 'Lists'
          sref: 'app.elements.lists'
        }
        {
          name: 'Bootstrapui'
          sref: 'app.elements.bootstrapui'
        }
        {
          name: 'Buttons'
          sref: 'app.elements.buttons'
        }
        {
          name: 'Sweet-alert'
          sref: 'app.elements.sweet-alert'
        }
        {
          name: 'Spinners'
          sref: 'app.elements.spinners'
        }
        {
          name: 'Navtree'
          sref: 'app.elements.navtree'
        }
        {
          name: 'Nestable'
          sref: 'app.elements.nestable'
        }
        {
          name: 'Grid'
          sref: 'app.elements.grid'
        }
        {
          name: 'Grid Masonry'
          sref: 'app.elements.grid-masonry-deck'
        }
        {
          name: 'Typography'
          sref: 'app.elements.typography'
        }
        {
          name: 'Icons'
          sref: 'app.elements.icons'
        }
        {
          name: 'Utilities'
          sref: 'app.elements.utilities'
        }
      ]
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state('app.elements',
      url: '/ui'
      abstract: true
      template: '<div ui-view class="ng-fadeInLeftShort"></div>')
    .state('app.elements.colors',
      url: '/colors'
      title: 'UI Colors'
      templateUrl: 'colors.html')
    .state('app.elements.whiteframes',
      url: '/whiteframes'
      title: 'Whiteframes'
      templateUrl: 'whiteframes.html')
    .state('app.elements.lists',
      url: '/lists'
      title: 'Lists'
      templateUrl: 'lists.html')
    .state('app.elements.bootstrapui',
      url: '/bootstrapui'
      title: 'Bootstrapui'
      templateUrl: 'bootstrapui.html')
    .state('app.elements.buttons',
      url: '/buttons'
      title: 'Buttons'
      templateUrl: 'buttons.html')
    .state('app.elements.sweet-alert',
      url: '/sweet-alert'
      title: 'Sweet-alert'
      templateUrl: 'sweetalert.html'
      require: [ 'oitozero.ngSweetAlert' ])
    .state('app.elements.spinners',
      url: '/spinners'
      title: 'Spinners'
      templateUrl: 'spinners.html'
      require: [ 'the-cormoran.angular-loaders' ])
    .state('app.elements.navtree',
      url: '/navtree'
      title: 'Navtree'
      templateUrl: 'navtree.html'
      require: [ 'angularBootstrapNavTree' ])
    .state('app.elements.nestable',
      url: '/nestable'
      title: 'Nestable'
      templateUrl: 'nestable.html'
      require: [ 'ng-nestable' ])
    .state('app.elements.grid',
      url: '/grid'
      title: 'Grid'
      templateUrl: 'grid.html')
    .state('app.elements.grid-masonry-deck',
      url: '/grid-masonry-deck'
      title: 'Grid Masonry'
      templateUrl: 'grid-masonry-deck.html'
      require: [ 'akoenig.deckgrid' ])
    .state('app.elements.typography',
      url: '/typography'
      title: 'Typography'
      templateUrl: 'typography.html')
    .state('app.elements.icons',
      url: '/icons'
      title: 'Icons'
      templateUrl: 'icons.html')
    .state 'app.elements.utilities',
      url: '/utilities'
      title: 'Utilities'
      templateUrl: 'utilities.html'
]

.directive "imageloaded", [
  () ->
    link = (scope, element, attrs) ->
      cssClass = attrs.loadedclass
      element.bind 'load', ->
        angular.element(element).addClass cssClass
        return
      return

    link: link,
    restrict: 'A'
]

.controller "MasonryDeckController", [
  'Router'
  (Router) ->
    vm = this

    activate = ->
      vm.viewpath = Router.viewpath
      vm.photos = [
        {
          id: 'photo-1'
          name: 'Awesome photo'
          src: 'app/img/user/01.jpg'
        }
        {
          id: 'photo-2'
          name: 'Great photo'
          src: 'app/img/user/02.jpg'
        }
        {
          id: 'photo-3'
          name: 'Strange photo'
          src: 'app/img/user/06.jpg'
        }
        {
          id: 'photo-4'
          name: 'A photo?'
          src: 'app/img/user/03.jpg'
        }
        {
          id: 'photo-5'
          name: 'What a photo'
          src: 'app/img/user/04.jpg'
        }
        {
          id: 'photo-6'
          name: 'Silly photo'
          src: 'app/img/user/02.jpg'
        }
        {
          id: 'photo-7'
          name: 'Weird photo'
          src: 'app/img/user/01.jpg'
        }
        {
          id: 'photo-8'
          name: 'Modern photo'
          src: 'app/img/user/07.jpg'
        }
        {
          id: 'photo-9'
          name: 'Classical photo'
          src: 'app/img/user/06.jpg'
        }
        {
          id: 'photo-10'
          name: 'Dynamic photo'
          src: 'app/img/user/04.jpg'
        }
        {
          id: 'photo-11'
          name: 'Neat photo'
          src: 'app/img/user/03.jpg'
        }
        {
          id: 'photo-12'
          name: 'Bumpy photo'
          src: 'app/img/user/01.jpg'
        }
        {
          id: 'photo-13'
          name: 'Brilliant photo'
          src: 'app/img/user/05.jpg'
        }
        {
          id: 'photo-14'
          name: 'Excellent photo'
          src: 'app/img/user/04.jpg'
        }
        {
          id: 'photo-15'
          name: 'Gorgeous photo'
          src: 'app/img/user/07.jpg'
        }
      ]
      return

    activate()
]

.controller "AbnTestController", [
  '$timeout', '$resource'
  ($timeout, $resource) ->
    vm = this
    #//////////////

    ###jshint -W106###

    activate = ->

      vm.my_tree_handler = (branch) ->
        vm.output = 'You selected: ' + branch.label
        if branch.data and branch.data.description
          vm.output += '(' + branch.data.description + ')'
          return vm.output
        return

      # onSelect event handlers

      apple_selected = (branch) ->
        vm.output = 'APPLE! : ' + branch.label
        vm.output

      treedata_avm = [
        {
          label: 'Animal'
          children: [
            {
              label: 'Dog'
              data: description: 'man\'s best friend'
            }
            {
              label: 'Cat'
              data: description: 'Felis catus'
            }
            {
              label: 'Hippopotamus'
              data: description: 'hungry, hungry'
            }
            {
              label: 'Chicken'
              children: [
                'White Leghorn'
                'Rhode Island Red'
                'Jersey Giant'
              ]
            }
          ]
        }
        {
          label: 'Vegetable'
          data:
            definition: 'A plant or part of a plant used as food, typically as accompaniment to meat or fish, such as a cabbage, potato, carrot, or bean.'
            data_can_contain_anything: true
          onSelect: (branch) ->
            vm.output = 'Vegetable: ' + branch.data.definition
            vm.output
          children: [
            { label: 'Oranges' }
            {
              label: 'Apples'
              children: [
                {
                  label: 'Granny Smith'
                  onSelect: apple_selected
                }
                {
                  label: 'Red Delicous'
                  onSelect: apple_selected
                }
                {
                  label: 'Fuji'
                  onSelect: apple_selected
                }
              ]
            }
          ]
        }
        {
          label: 'Mineral'
          children: [
            {
              label: 'Rock'
              children: [
                'Igneous'
                'Sedimentary'
                'Metamorphic'
              ]
            }
            {
              label: 'Metal'
              children: [
                'Aluminum'
                'Steel'
                'Copper'
              ]
            }
            {
              label: 'Plastic'
              children: [
                {
                  label: 'Thermoplastic'
                  children: [
                    'polyethylene'
                    'polypropylene'
                    'polystyrene'
                    ' polyvinyl chloride'
                  ]
                }
                {
                  label: 'Thermosetting Polymer'
                  children: [
                    'polyester'
                    'polyurethane'
                    'vulcanized rubber'
                    'bakelite'
                    'urea-formaldehyde'
                  ]
                }
              ]
            }
          ]
        }
      ]
      treedata_geography = [
        {
          label: 'North America'
          children: [
            {
              label: 'Canada'
              children: [
                'Toronto'
                'Vancouver'
              ]
            }
            {
              label: 'USA'
              children: [
                'New York'
                'Los Angeles'
              ]
            }
            {
              label: 'Mexico'
              children: [
                'Mexico City'
                'Guadalajara'
              ]
            }
          ]
        }
        {
          label: 'South America'
          children: [
            {
              label: 'Venezuela'
              children: [
                'Caracas'
                'Maracaibo'
              ]
            }
            {
              label: 'Brazil'
              children: [
                'Sao Paulo'
                'Rio de Janeiro'
              ]
            }
            {
              label: 'Argentina'
              children: [
                'Buenos Aires'
                'Cordoba'
              ]
            }
          ]
        }
      ]
      vm.my_data = treedata_avm

      vm.try_changing_the_tree_data = ->
        if vm.my_data == treedata_avm
          vm.my_data = treedata_geography
        else
          vm.my_data = treedata_avm
        vm.my_data

      tree = undefined
      # This is our API control variable
      vm.my_tree = tree = {}

      vm.try_async_load = ->
        vm.my_data = []
        vm.doing_async = true
        # Request tree data via $resource
        remoteTree = $resource('server/treedata.json')
        remoteTree.get((res) ->
          vm.my_data = res.data
          vm.doing_async = false
          tree.expand_all()
          # we must return a promise so the plugin
          # can watch when it's resolved
        ).$promise

      # Adds a new branch to the tree

      vm.try_adding_a_branch = ->
        b = undefined
        b = tree.get_selected_branch()
        tree.add_branch b,
          label: 'New Branch'
          data:
            something: 42
            'else': 43

      return

    activate()
]

.controller "NestableController", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.items = [
        {
          item: text: 'Sherry Spencer'
          children: []
        }
        {
          item: text: 'Nathaniel Herrera'
          children: [
            {
              item: text: 'Violet Graves'
              children: []
            }
            {
              item: text: 'Daniel Crawford'
              children: []
            }
          ]
        }
      ]

      vm.add = ->
        vm.items.push
          item: text: 'Darren Dean'
          children: []
        return

      return

    activate()
]

.controller "SweetAlertController", [
  'SweetAlert'
  (SweetAlert) ->
    vm = this
    #//////////////

    activate = ->

      vm.demo1 = ->
        SweetAlert.swal 'Here\'s a message'
        return

      vm.demo2 = ->
        SweetAlert.swal 'Here\'s a message!', 'It\'s pretty, isn\'t it?'
        return

      vm.demo3 = ->
        SweetAlert.swal 'Good job!', 'You clicked the button!', 'success'
        return

      vm.demo4 = ->
        SweetAlert.swal {
          title: 'Are you sure?'
          text: 'Your will not be able to recover this imaginary file!'
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
          closeOnConfirm: false
        }, ->
          SweetAlert.swal 'Booyah!'
          return
        return

      vm.demo5 = ->
        SweetAlert.swal {
          title: 'Are you sure?'
          text: 'Your will not be able to recover this imaginary file!'
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
          cancelButtonText: 'No, cancel plx!'
          closeOnConfirm: false
          closeOnCancel: false
        }, (isConfirm) ->
          if isConfirm
            SweetAlert.swal 'Deleted!', 'Your imaginary file has been deleted.', 'success'
          else
            SweetAlert.swal 'Cancelled', 'Your imaginary file is safe :)', 'error'
          return
        return

      vm.demo6 = ->
        SweetAlert.swal
          title: 'Sweet!'
          text: 'Here\'s a custom image.'
          imageUrl: '//oitozero.com/img/avatar.jpg'
        return

      return

    activate()
]