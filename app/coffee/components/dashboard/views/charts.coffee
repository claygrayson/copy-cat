module.exports = angular.module "copycat.dashboard.charts", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Charts'
      sref: 'app.charts'
      imgpath: 'app/img/icons/connection-bars.svg'
      order: 3
      subitems: [
        {
          name: 'Flot'
          sref: 'app.charts.flot'
        }
        {
          name: 'Radial'
          sref: 'app.charts.pie'
        }
        {
          name: 'Rickshaw'
          sref: 'app.charts.rickshaw'
        }
      ]
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state('app.charts',
      url: '/charts'
      title: 'Charts'
      abstract: true
      template: '<div ui-view class="ng-fadeInLeftShort"></div>')
    .state('app.charts.flot',
      url: '/flot'
      title: 'Charts Flot'
      templateUrl: 'flot.html'
      require: [ 'angular-flot' ])
    .state('app.charts.pie',
      url: '/radial'
      title: 'Charts Radial'
      templateUrl: 'radial.html'
      require: [
        'ui.knob'
        'easypiechart'
      ])
    .state 'app.charts.rickshaw',
      url: '/rickshaw'
      title: 'Charts Rickshaw'
      templateUrl: 'rickshaw.html'
      require: [ 'angular-rickshaw' ]
]

.controller "FlotChartController", [
  '$scope', 'ChartData', '$timeout', 'Colors'
  ($scope, ChartData, $timeout, Colors) ->
    vm = this
    #//////////////

    activate = ->
      # BAR
      # -----------------------------------

      vm.barData = ChartData.load('server/chart/bar.json')
      vm.barOptions =
        series: bars:
          align: 'center'
          lineWidth: 0
          show: true
          barWidth: 0.6
          fill: true
          fillColor: colors: [
            { opacity: 0.8 }
            { opacity: 0.5 }
          ]
        grid:
          borderColor: 'rgba(162,162,162,.26)'
          borderWidth: 1
          hoverable: true
          backgroundColor: 'transparent'
        tooltip: true
        tooltipOpts: content: (label, x, y) ->
          x + ' : ' + y
        xaxis:
          tickColor: 'rgba(162,162,162,.26)'
          font: color: Colors.byName('blueGrey-200')
          mode: 'categories'
        yaxis:
          position: if $scope.app.layout.rtl then 'right' else 'left'
          tickColor: 'rgba(162,162,162,.26)'
          font: color: Colors.byName('blueGrey-200')
        shadowSize: 0
      # BAR STACKED
      # -----------------------------------
      vm.barStackeData = ChartData.load('server/chart/barstacked.json')
      vm.barStackedOptions =
        series:
          stack: true
          bars:
            align: 'center'
            lineWidth: 0
            show: true
            barWidth: 0.6
            fill: 0.9
        grid:
          borderColor: 'rgba(162,162,162,.26)'
          borderWidth: 1
          hoverable: true
          backgroundColor: 'transparent'
        tooltip: true
        tooltipOpts: content: (label, x, y) ->
          x + ' : ' + y
        xaxis:
          tickColor: 'rgba(162,162,162,.26)'
          font: color: Colors.byName('blueGrey-200')
          mode: 'categories'
        yaxis:
          min: 0
          max: 200
          position: if $scope.app.layout.rtl then 'right' else 'left'
          tickColor: 'rgba(162,162,162,.26)'
          font: color: Colors.byName('blueGrey-200')
        shadowSize: 0
      # SPLINE
      # -----------------------------------
      vm.splineData = ChartData.load('server/chart/spline.json')
      vm.splineOptions =
        series:
          lines: show: false
          points:
            show: true
            radius: 2
          splines:
            show: true
            tension: 0.4
            lineWidth: 1
            fill: 1
        grid:
          borderColor: 'rgba(162,162,162,.26)'
          borderWidth: 1
          hoverable: true
          backgroundColor: 'transparent'
        tooltip: true
        tooltipOpts: content: (label, x, y) ->
          x + ' : ' + y
        xaxis:
          tickColor: 'rgba(162,162,162,.26)'
          font: color: Colors.byName('blueGrey-200')
          mode: 'categories'
        yaxis:
          min: 0
          max: 150
          tickColor: 'rgba(162,162,162,.26)'
          font: color: Colors.byName('blueGrey-200')
          position: if $scope.app.layout.rtl then 'right' else 'left'
          tickFormatter: (v) ->
            v
        shadowSize: 0
      # AREA
      # -----------------------------------
      vm.areaData = ChartData.load('server/chart/area.json')
      vm.areaOptions =
        series:
          lines:
            show: true
            fill: true
            fillColor: colors: [
              { opacity: 0.5 }
              { opacity: 0.9 }
            ]
          points: show: false
        grid:
          borderColor: 'rgba(162,162,162,.26)'
          borderWidth: 1
          hoverable: true
          backgroundColor: 'transparent'
        tooltip: true
        tooltipOpts: content: (label, x, y) ->
          x + ' : ' + y
        xaxis:
          tickColor: 'rgba(162,162,162,.26)'
          font: color: Colors.byName('blueGrey-200')
          mode: 'categories'
        yaxis:
          min: 0
          max: 150
          tickColor: 'rgba(162,162,162,.26)'
          font: color: Colors.byName('blueGrey-200')
          position: if $scope.app.layout.rtl then 'right' else 'left'
        shadowSize: 0
      # LINE
      # -----------------------------------
      vm.lineData = ChartData.load('server/chart/line.json')
      vm.lineOptions =
        series:
          lines:
            show: true
            fill: 0.01
          points:
            show: true
            radius: 4
        grid:
          borderColor: 'rgba(162,162,162,.26)'
          borderWidth: 1
          hoverable: true
          backgroundColor: 'transparent'
        tooltip: true
        tooltipOpts: content: (label, x, y) ->
          x + ' : ' + y
        xaxis:
          tickColor: 'rgba(162,162,162,.26)'
          font: color: Colors.byName('blueGrey-200')
          mode: 'categories'
        yaxis:
          position: if $scope.app.layout.rtl then 'right' else 'left'
          tickColor: 'rgba(162,162,162,.26)'
          font: color: Colors.byName('blueGrey-200')
        shadowSize: 0
      # PIE
      # -----------------------------------
      vm.pieData = [
        {
          'label': 'CSS'
          'color': '#009688'
          'data': 40
        }
        {
          'label': 'LESS'
          'color': '#FFC107'
          'data': 90
        }
        {
          'label': 'SASS'
          'color': '#FF7043'
          'data': 75
        }
      ]
      vm.pieOptions = series: pie:
        show: true
        innerRadius: 0
        label:
          show: true
          radius: 0.8
          formatter: (label, series) ->
            '<div class="flot-pie-label">' + Math.round(series.percent) + '%</div>'
          background:
            opacity: 0.8
            color: '#222'
      # DONUT
      # -----------------------------------
      vm.donutData = [
        {
          'color': '#4CAF50'
          'data': 60
          'label': 'Coffee'
        }
        {
          'color': '#009688'
          'data': 90
          'label': 'CSS'
        }
        {
          'color': '#FFC107'
          'data': 50
          'label': 'LESS'
        }
        {
          'color': '#FF7043'
          'data': 80
          'label': 'Jade'
        }
        {
          'color': '#3949AB'
          'data': 116
          'label': 'AngularJS'
        }
      ]
      vm.donutOptions = series: pie:
        show: true
        innerRadius: 0.5
      # REALTIME
      # -----------------------------------
      vm.realTimeOptions =
        series:
          lines:
            show: true
            fill: true
            fillColor: colors: [
              '#3F51B5'
              '#3F51B5'
            ]
          shadowSize: 0
        grid:
          show: false
          borderWidth: 0
          minBorderMargin: 20
          labelMargin: 10
        xaxis: tickFormatter: ->
          ''
        yaxis:
          min: 0
          max: 110
        legend: show: true
        colors: [ '#3F51B5' ]
      # Generate random data for realtime demo
      data = []
      totalPoints = 300

      getRandomData = ->
        if data.length > 0
          data = data.slice(1)
        # Do a random walk
        while data.length < totalPoints
          prev = if data.length > 0 then data[data.length - 1] else 50
          y = prev + Math.random() * 10 - 5
          if y < 0
            y = 0
          else if y > 100
            y = 100
          data.push y
        # Zip the generated y values with the x values
        res = []
        i = 0
        while i < data.length
          res.push [
            i
            data[i]
          ]
          ++i
        [ res ]

      update = ->
        vm.realTimeData = getRandomData()
        $timeout update, 30
        return

      update()

      # end random data generation
      return

    activate()
]

.controller "RadialChartsController", [
  'Colors'
  (Colors) ->
    vm = this
    #//////////////

    activate = ->
      # KNOB Charts

      random = ->
        Math.floor Math.random() * 100 + 1

      vm.knobLoaderData1 = 80
      vm.knobLoaderOptions1 =
        width: '50%'
        displayInput: true
        thickness: 0.1
        fgColor: Colors.byName('info')
        bgColor: 'rgba(162,162,162, .09)'
      vm.knobLoaderData2 = 45
      vm.knobLoaderOptions2 =
        width: '50%'
        displayInput: true
        thickness: 1
        inputColor: '#fff'
        fgColor: Colors.byName('deepPurple-500')
        bgColor: Colors.byName('green-500')
        readOnly: true
      vm.knobLoaderData3 = 30
      vm.knobLoaderOptions3 =
        width: '50%'
        displayInput: true
        fgColor: Colors.byName('pink-500')
        bgColor: 'rgba(162,162,162, .09)'
        displayPrevious: true
        thickness: 0.1
        lineCap: 'round'
      vm.knobLoaderData4 = 20
      vm.knobLoaderOptions4 =
        width: '50%'
        displayInput: true
        fgColor: Colors.byName('info')
        bgColor: 'rgba(162,162,162, .09)'
        angleOffset: -125
        angleArc: 250
      # Easy Pie Charts
      vm.piePercent1 = 85
      vm.piePercent2 = 45
      vm.piePercent3 = 25
      vm.piePercent4 = 60
      vm.pieOptions1 =
        animate:
          duration: 800
          enabled: true
        barColor: Colors.byName('success')
        trackColor: false
        scaleColor: false
        lineWidth: 10
        lineCap: 'circle'
      vm.pieOptions2 =
        animate:
          duration: 800
          enabled: true
        barColor: Colors.byName('warning')
        trackColor: false
        scaleColor: false
        lineWidth: 4
        lineCap: 'circle'
      vm.pieOptions3 =
        animate:
          duration: 800
          enabled: true
        barColor: Colors.byName('danger')
        trackColor: false
        scaleColor: Colors.byName('gray')
        lineWidth: 15
        lineCap: 'circle'
      vm.pieOptions4 =
        animate:
          duration: 800
          enabled: true
        barColor: Colors.byName('danger')
        trackColor: 'rgba(162,162,162, .09)'
        scaleColor: Colors.byName('gray-dark')
        lineWidth: 15
        lineCap: 'circle'

      vm.randomize = (type) ->
        if type == 'easy'
          vm.piePercent1 = random()
          vm.piePercent2 = random()
          vm.piePercent3 = random()
          vm.piePercent4 = random()
        if type == 'knob'
          vm.knobLoaderData1 = random()
          vm.knobLoaderData2 = random()
          vm.knobLoaderData3 = random()
          vm.knobLoaderData4 = random()
        return

      return

    activate()
]

.controller "ChartRickshawController", [
  'Colors'
  (Colors) ->
    vm = this
    #//////////////

    activate = ->
      vm.renderers = [
        {
          id: 'area'
          name: 'Area'
        }
        {
          id: 'line'
          name: 'Line'
        }
        {
          id: 'bar'
          name: 'Bar'
        }
        {
          id: 'scatterplot'
          name: 'Scatterplot'
        }
      ]
      vm.palettes = [
        'spectrum14'
        'spectrum2000'
        'spectrum2001'
        'colorwheel'
        'cool'
        'classic9'
        'munin'
      ]

      vm.rendererChanged = (id) ->
        vm['options' + id] = renderer: vm['renderer' + id].id
        return

      vm.paletteChanged = (id) ->
        vm['features' + id] = palette: vm['palette' + id]
        return

      vm.changeSeriesData = (id) ->
        seriesList = []
        i = 0
        while i < 3
          series =
            name: 'Series ' + i + 1
            data: []
          j = 0
          while j < 10
            series.data.push
              x: j
              y: Math.random() * 20
            j++
          seriesList.push series
          vm['series' + id][i] = series
          i++
        #vm['series' + id] = seriesList
        return

      vm.series0 = []
      vm.options0 = renderer: 'area'
      vm.renderer0 = vm.renderers[0]
      vm.palette0 = vm.palettes[0]
      vm.rendererChanged 0
      vm.paletteChanged 0
      vm.changeSeriesData 0
      # Graph 2
      seriesData = [
        []
        []
        []
      ]
      random = new (Rickshaw.Fixtures.RandomData)(150)
      i = 0
      while i < 150
        random.addData seriesData
        i++
      vm.series2 = [
        {
          color: Colors.byName('indigo-700')
          data: seriesData[0]
          name: 'New York'
        }
        {
          color: Colors.byName('primary')
          data: seriesData[1]
          name: 'London'
        }
        {
          color: Colors.byName('info')
          data: seriesData[2]
          name: 'Tokyo'
        }
      ]
      vm.options2 = renderer: 'area'
      vm.series3 = [
        {
          color: Colors.byName('green-700')
          data: seriesData[0]
          name: 'New York'
        }
        {
          color: Colors.byName('green-500')
          data: seriesData[1]
          name: 'London'
        }
        {
          color: Colors.byName('green-200')
          data: seriesData[2]
          name: 'Tokyo'
        }
      ]
      vm.options3 = renderer: 'bar'
      # Scatterplot
      seriesData2 = [
        []
        []
        []
      ]
      random2 = new (Rickshaw.Fixtures.RandomData)(150)
      j = 0
      while j < 200
        random2.addData seriesData2
        j++
      vm.series4 = [
        {
          color: Colors.byName('pink-700')
          data: seriesData2[0]
          name: 'New York'
        }
        {
          color: Colors.byName('pink-500')
          data: seriesData2[1]
          name: 'London'
        }
        {
          color: Colors.byName('pink-200')
          data: seriesData2[2]
          name: 'Tokyo'
        }
      ]
      vm.options4 =
        height: 170
        renderer: 'scatterplot'
      vm.features4 =
        legend:
          toggle: true
          highlight: true
        hover:
          xFormatter: (x) ->
            't=' + x
          yFormatter: (y) ->
            '$' + y
      return

    activate()
]

.service "ChartData", [
  '$resource'
  ($resource) ->
    opts = get:
      method: 'GET'
      isArray: true

    load = (source) ->
      $resource(source, {}, opts).get()

    {
      load
    }
]

.directive "sparkline", [
  '$timeout', '$window'
  ($timeout, $window) ->
    link = (scope, element) ->
      $element = $(element)
      values = scope.values
      options = scope.options
      # timeouts executes after interpolation

      initSparkLine = ->
        options.type = options.type or 'bar'
        # default chart is bar
        options.disableHiddenCheck = true
        $element.sparkline values, options
        if options.resize
          tm = undefined
          $($window).resize ->
            # don't allow multiple timers
            $timeout.cancel tm
            tm = $timeout(->
              $element.sparkline values, options
              return
            )
            return
        return

      $timeout ->
        options = $.extend({}, options, $element.data())
        if !values or !options
          return
        initSparkLine()
        return
      return

    restrict: 'EA'
    scope:
      'values': '=?'
      'options': '=?'
    link: link
]