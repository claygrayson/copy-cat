module.exports = angular.module "copycat.dashboard.maps", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Maps'
      sref: 'app.maps'
      imgpath: 'app/img/icons/planet.svg'
      order: 7
      subitems: [
        {
          name: 'Google Maps Full'
          sref: 'app.maps.full'
        }
        {
          name: 'Google Maps'
          sref: 'app.maps.google'
        }
        {
          name: 'Vector Maps'
          sref: 'app.maps.vector'
        }
      ]
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state('app.maps',
      url: '/maps'
      title: 'Maps'
      abstract: true
      template: '<div ui-view class="ng-fadeInLeftShort"></div>')
    .state('app.maps.google',
      url: '/google'
      title: 'Google Maps'
      templateUrl: 'google-map.html'
      require: [
        'lodash'
        'uiGmapgoogle-maps'
      ])
    .state('app.maps.full',
      url: '/google-full'
      title: 'Fullsize Google Map'
      templateUrl: 'google-map-full.html'
      require: [
        'lodash'
        'uiGmapgoogle-maps'
      ])
    .state 'app.maps.vector',
      url: '/vector'
      title: 'Vector Maps'
      templateUrl: 'vector-map.html'
      require: [
        'vector-map'
        'vector-map-maps'
      ]
]

.directive "vectorMap", [
  '$timeout'
  ($timeout) ->
    link = (scope, element, attrs) ->
      # Height attribute

      reload = (el) ->
        $(el).empty().vectorMap scope.mapOptions
        return

      if attrs.height
        element.css 'height', attrs.height
      $timeout ->
        # watch for changes
        scope.$watch 'mapOptions', ->
          reload element, scope.mapOptions
          return
        scope.$watch 'mapMarkers', ->
          scope.mapOptions.markers = scope.mapMarkers
          reload element, scope.mapOptions
          return
        scope.$watch 'mapSeries', ->
          scope.mapOptions.series = scope.mapSeries
          reload element, scope.mapOptions
          return
        return
      return

    link: link
    restrict: 'AE'
    scope: {
        mapOptions: '='
        mapMarkers: '='
        mapSeries: '='
    }
]

.controller "GMapFullController", [
  'uiGmapIsReady'
  (uiGmapIsReady) ->
    vm = this
    #//////////////

    activate = ->
      vm.myMarkers = [
        {
          id: 0
          name: 'Canada'
          coords:
            latitude: 56.130366
            longitude: -106.346771
        }
        {
          id: 1
          name: 'New York'
          coords:
            latitude: 40.712784
            longitude: -74.005941
        }
        {
          id: 2
          name: 'Toronto'
          coords:
            latitude: 43.653226
            longitude: -79.383184
        }
        {
          id: 3
          name: 'San Francisco'
          coords:
            latitude: 37.774929
            longitude: -122.419416
        }
        {
          id: 4
          name: 'Utah'
          coords:
            latitude: 39.320980
            longitude: -111.093731
        }
      ]
      vm.map =
        zoom: 4
        center: vm.myMarkers[4].coords
      vm.mapOptions = scrollwheel: false
      # http://angular-ui.github.io/angular-google-maps/#!/api/IsReady
      uiGmapIsReady.promise(1).then (instances) ->
        instances.forEach (inst) ->
          map = inst.map
          # var uuid = map.uiGmap_id;
          # var mapInstanceNumber = inst.instance; // Starts at 1.
          vm.myMap = map
          angular.forEach vm.myMarkers, (pos, id) ->
            vm.myMarkers[id].position = new (google.maps.Marker)(
              map: vm.myMap
              position: new (google.maps.LatLng)(pos.coords.latitude, pos.coords.longitude))
            return
          return
        return
      return

    activate()
]

.controller "GMapController", [
  '$scope', '$timeout', 'uiGmapGoogleMapApi'
  ($scope, $timeout, uiGmapGoogleMapApi) ->
    vm = this
    #//////////////

    activate = ->
      # Basic map
      vm.map =
        center:
          latitude: 45
          longitude: -73
        zoom: 8
      # Markers
      vm.map1 =
        center:
          latitude: 40.1451
          longitude: -99.6680
        zoom: 4
      vm.options = scrollwheel: false
      vm.coordsUpdates = 0
      vm.dynamicMoveCtr = 0
      vm.marker =
        id: 0
        coords:
          latitude: 40.1451
          longitude: -99.6680
        options: draggable: true
        events: dragend: ->
          # var lat = marker.getPosition().lat();
          # var lon = marker.getPosition().lng();
          vm.marker.options =
            draggable: true
            labelContent: 'lat: ' + vm.marker.coords.latitude + ' ' + 'lon: ' + vm.marker.coords.longitude
            labelAnchor: '100 0'
            labelClass: 'marker-labels'
          return
      $offWatch = $scope.$watchCollection('marker.coords', (newVal, oldVal) ->
        if _.isEqual(newVal, oldVal)
          return
        vm.coordsUpdates++
        return
      )
      $timeout (->
        vm.marker.coords =
          latitude: 42.1451
          longitude: -100.6680
        vm.dynamicMoveCtr++
        $timeout (->
          vm.marker.coords =
            latitude: 43.1451
            longitude: -102.6680
          vm.dynamicMoveCtr++
          return
        ), 2000
        return
      ), 1000
      # uiGmapGoogleMapApi is a promise.
      # The 'then' callback function provides the google.maps object.
      # uiGmapGoogleMapApi.then(function(/*maps*/) {
      # });
      $scope.$on '$destroy', $offWatch
      return

    activate()
]

.controller "VectorMapController", [
  'Colors'
  (Colors) ->
    vm = this
    #//////////////

    activate = ->

      displayAllMarkers = (show) ->
        if show
          vm.markers = vm.world_markers.concat(vm.other_markers)
        else
          vm.markers = vm.world_markers
        return

      vm.options =
        map: 'world_mill_en'
        normalizeFunction: 'polynomial'
        backgroundColor: '#fff'
        regionsSelectable: true
        markersSelectable: true
        regionStyle:
          initial: fill: Colors.byName('gray-lighter')
          hover:
            fill: Colors.byName('indigo-500')
            stroke: '#fff'
        markerStyle:
          initial:
            fill: Colors.byName('pink-500')
            stroke: '#fff'
            r: 10
          hover:
            fill: Colors.byName('amber-500')
            stroke: '#fff'
      vm.series = {}
      vm.world_markers = [
        {
          'latLng': [
            47.14
            9.52
          ]
          'name': 'Liechtenstein'
        }
        {
          'latLng': [
            7.11
            171.06
          ]
          'name': 'Marshall Islands'
        }
        {
          'latLng': [
            17.3
            -62.73
          ]
          'name': 'Saint Kitts and Nevis'
        }
        {
          'latLng': [
            3.2
            73.22
          ]
          'name': 'Maldives'
        }
        {
          'latLng': [
            35.88
            14.5
          ]
          'name': 'Malta'
        }
        {
          'latLng': [
            12.05
            -61.75
          ]
          'name': 'Grenada'
        }
        {
          'latLng': [
            13.16
            -61.23
          ]
          'name': 'Saint Vincent and the Grenadines'
        }
        {
          'latLng': [
            13.16
            -59.55
          ]
          'name': 'Barbados'
        }
        {
          'latLng': [
            17.11
            -61.85
          ]
          'name': 'Antigua and Barbuda'
        }
        {
          'latLng': [
            -4.61
            55.45
          ]
          'name': 'Seychelles'
        }
        {
          'latLng': [
            7.35
            134.46
          ]
          'name': 'Palau'
        }
        {
          'latLng': [
            42.5
            1.51
          ]
          'name': 'Andorra'
        }
      ]
      vm.other_markers = [
        {
          'latLng': [
            56.13
            -106.34
          ]
          'name': 'Canada'
          style: fill: Colors.byName('info')
        }
        {
          'latLng': [
            40.71
            -74.00
          ]
          'name': 'New York'
          style: fill: Colors.byName('info')
        }
        {
          'latLng': [
            43.65
            -79.38
          ]
          'name': 'Toronto'
          style: fill: Colors.byName('info')
        }
        {
          'latLng': [
            37.77
            -122.41
          ]
          'name': 'San Francisco'
          style: fill: Colors.byName('info')
        }
        {
          'latLng': [
            39.32
            -111.09
          ]
          'name': 'Utah'
          style: fill: Colors.byName('info')
        }
        {
          'latLng': [
            41.9
            12.45
          ]
          'name': 'Vatican City'
          style: fill: Colors.byName('info')
        }
        {
          'latLng': [
            43.93
            12.46
          ]
          'name': 'San Marino'
          style: fill: Colors.byName('info')
        }
      ]
      vm.showAllMarkers = false
      vm.markers = vm.world_markers
      vm.displayAllMarkers = displayAllMarkers
      # USA Map
      vm.usa_markers = [
        {
          latLng: [
            40.71
            -74.00
          ]
          name: 'New York'
        }
        {
          latLng: [
            34.05
            -118.24
          ]
          name: 'Los Angeles'
        }
        {
          latLng: [
            41.87
            -87.62
          ]
          name: 'Chicago'
        }
        {
          latLng: [
            29.76
            -95.36
          ]
          name: 'Houston'
        }
        {
          latLng: [
            39.95
            -75.16
          ]
          name: 'Philadelphia'
        }
        {
          latLng: [
            38.90
            -77.03
          ]
          name: 'Washington'
        }
        {
          latLng: [
            37.36
            -122.03
          ]
          name: 'Silicon Valley'
          style:
            fill: Colors.byName('green-500')
            r: 20
        }
      ]
      vm.usa_options =
        map: 'us_mill_en'
        normalizeFunction: 'polynomial'
        backgroundColor: '#fff'
        regionsSelectable: true
        markersSelectable: true
        regionStyle:
          initial: fill: Colors.byName('deepPurple-400')
          hover:
            fill: Colors.byName('deepPurple-100')
            stroke: '#fff'
        markerStyle:
          initial:
            fill: Colors.byName('amber-500')
            stroke: '#fff'
            r: 10
          hover:
            fill: Colors.byName('orange-500')
            stroke: '#fff'
      return

    activate()
]