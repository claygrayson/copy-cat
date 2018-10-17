module.exports = angular.module "copycat.dashboard.router", [
  'ui.router'
  'oc.lazyLoad'
]

.config [
  '$ocLazyLoadProvider', 'APP_REQUIRES'
  ($ocLazyLoadProvider, APP_REQUIRES) ->
    $ocLazyLoadProvider.config
      debug: false
      events: true
      modules: APP_REQUIRES.modules
]

.provider "Router", [
  '$locationProvider', '$stateProvider', '$urlRouterProvider'
  ($locationProvider, $stateProvider, $urlRouterProvider) ->
    config =
      viewsBasePath: 'dashboard/templates/'
      useViewsBasePath: true
      html5Mode: false
      defaultRoute: '/app/dashboard'

    @configure = (cfg) ->
      angular.extend config, cfg
      return

    $locationProvider.html5Mode config.html5Mode
    $urlRouterProvider.otherwise config.defaultRoute

    Router = ($rootScope, $state, $stateParams, APP_REQUIRES) ->
      #/////
      # wrapper for $stateProvider to simply routes creation

      state = (name, options) ->
        if !name
          throw new Error('Route name not defined.')
        if options.require
          require = @resolveFor.apply(this, options.require)
          options.resolve = angular.extend({}, options.resolve, require)
        if options.templateUrl and config.useViewsBasePath
          options.templateUrl = @viewpath(options.templateUrl)
        $stateProvider.state name, options
        # allow chain execution
        this

      # Set here the base of the
      # relative path for all views

      viewpath = (uri) ->
        config.viewsBasePath + uri

      # Generates a resolve object by passing script names
      # previously configured in constant.APP_REQUIRES

      resolveFor = ->
        _args = arguments
        { __deps: [
          '$ocLazyLoad'
          '$q'
          ($ocLL, $q) ->
            # Creates a promise chain for each argument
            promiseChain = $q.when(1)
            # empty promise
            # creates promise to chain dynamically

            andThen = (mod) ->
              # support a function that returns a promise
              if typeof mod == 'function'
                promiseChain.then mod
              else
                promiseChain.then ->
                  # check if module is defined
                  if !APP_REQUIRES[mod]
                    throw new Error('Route resolve: Bad resource name [' + mod + ']')
                  # finally, return the load promise
                  $ocLL.load APP_REQUIRES[mod]

            i = 0
            len = _args.length
            while i < len
              promiseChain = andThen(_args[i])
              i++
            promiseChain
        ] }

      # resolveFor

      getStates = ->
        $state.get()

      init = ->
        # Set reference to access them from any scope
        $rootScope.$state = $state
        $rootScope.$stateParams = $stateParams
        # auto update document title
        $rootScope.$on '$stateChangeSuccess', (event, toState) ->
          # Autoscroll to top
          scrollTopMainView()
          # Update document title
          title = toState.title or ''
          $rootScope.documentTitle = title
          # data bind to <title>
          return
        # on state not found log to console
        $rootScope.$on '$stateNotFound', (event, unfoundState) ->
          console.log 'State not found: ' + unfoundState.to + unfoundState.toParams + unfoundState.options
          return
        # on error log to console
        $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
          console.log error
          return
        return

      scrollTopMainView = ->
        # There must not be more than one <main> element in a document. (http://www.w3schools.com/tags/tag_main.asp)
        main = document.querySelector('main')
        if main
          main.scrollTop = 0
        return

      init()

      service =
        viewpath: viewpath
        resolveFor: resolveFor
        state: state
        getStates: getStates

      service

    @$get = Router

    {
      $get: Router
    }
]

.constant 'APP_REQUIRES',
  'modernizr': files: [ 'vendor/modernizr/modernizr.custom.js' ]
  'icons': files: [ 'vendor/ionicons/css/ionicons.min.css' ]
  'fontawesome': files: [ 'vendor/font-awesome/css/font-awesome.min.css' ]
  'screenfull': files: [ 'vendor/screenfull/dist/screenfull.js' ]
  'lodash': files: [ 'vendor/lodash/dist/lodash.min.js' ]
  'md-colors': files: [ 'vendor/material-colors/dist/colors.css' ]
  'sparkline': files: [ 'vendor/sparkline/index.js' ]
  'ng-mfb': files: [
    'vendor/ng-mfb/mfb/dist/mfb.min.css'
    'vendor/ng-mfb/src/mfb-directive.js'
  ]
  'easypiechart': files: [ 'vendor/jquery.easy-pie-chart/dist/angular.easypiechart.min.js' ]
  'angular-flot':
    'serie': true
    files: [
      'vendor/flot/jquery.flot.js'
      'vendor/flot/jquery.flot.categories.js'
      'vendor/flot.tooltip/js/jquery.flot.tooltip.min.js'
      'vendor/flot/jquery.flot.resize.js'
      'vendor/flot/jquery.flot.pie.js'
      'vendor/flot/jquery.flot.time.js'
      'vendor/sidebysideimproved/jquery.flot.orderBars.js'
      'vendor/flot-spline/js/jquery.flot.spline.min.js'
      'vendor/angular-flot/angular-flot.js'
    ]
  'ui.select': files: [
    'vendor/angular-ui-select/dist/select.js'
    'vendor/angular-ui-select/dist/select.css'
  ]
  'uiGmapgoogle-maps': files: [
    'vendor/angular-simple-logger/dist/angular-simple-logger.min.js'
    'vendor/angular-google-maps/dist/angular-google-maps.min.js'
  ]
  'angular-rickshaw':
    serie: true
    files: [
      'vendor/d3/d3.min.js'
      'vendor/rickshaw/rickshaw.js'
      'vendor/rickshaw/rickshaw.min.css'
      'vendor/angular-rickshaw/rickshaw.js'
    ]
  'ui.knob': files: [
    'vendor/angular-knob/src/angular-knob.js'
    'vendor/jquery-knob/dist/jquery.knob.min.js'
  ]
  'oitozero.ngSweetAlert': files: [
    'vendor/sweetalert/dist/sweetalert.css'
    'vendor/sweetalert/dist/sweetalert.min.js'
    'vendor/angular-sweetalert/SweetAlert.js'
  ]
  'the-cormoran.angular-loaders': files: [
    'vendor/loaders.css/loaders.css'
    'vendor/angular-loaders/angular-loaders.js'
  ]
  'angularBootstrapNavTree': files: [
    'vendor/angular-bootstrap-nav-tree/dist/abn_tree_directive.js'
    'vendor/angular-bootstrap-nav-tree/dist/abn_tree.css'
  ]
  'ng-nestable': files: [
    'vendor/ng-nestable/src/angular-nestable.js'
    'vendor/nestable/jquery.nestable.js'
  ]
  'akoenig.deckgrid': files: [ 'vendor/angular-deckgrid/angular-deckgrid.js' ]
  'vr.directives.slider': files: [ 'vendor/venturocket-angular-slider/build/angular-slider.min.js' ]
  'xeditable': files: [
    'vendor/angular-xeditable/dist/js/xeditable.js'
    'vendor/angular-xeditable/dist/css/xeditable.css'
  ]
  'colorpicker.module': files: [
    'vendor/angular-bootstrap-colorpicker/css/colorpicker.css'
    'vendor/angular-bootstrap-colorpicker/js/bootstrap-colorpicker-module.js'
  ]
  'summernote':
    serie: true
    insertBefore: '#appcss'
    files: [
      'vendor/bootstrap/js/modal.js'
      'vendor/bootstrap/js/dropdown.js'
      'vendor/bootstrap/js/tooltip.js'
      'vendor/summernote/dist/summernote.css'
      'vendor/summernote/dist/summernote.js'
      'vendor/angular-summernote/dist/angular-summernote.js'
    ]
  'angularFileUpload': files: [ 'vendor/angular-file-upload/dist/angular-file-upload.min.js' ]
  'filestyle': files: [ 'vendor/bootstrap-filestyle/src/bootstrap-filestyle.js' ]
  'ngDropzone':
    serie: true
    insertBefore: '#appcss'
    files: [
      'vendor/dropzone/dist/basic.css'
      'vendor/dropzone/dist/dropzone.css'
      'vendor/dropzone/dist/dropzone.js'
      'vendor/angular-dropzone/lib/angular-dropzone.js'
    ]
  'vector-map': files: [
    'vendor/ika.jvectormap/jquery-jvectormap-1.2.2.min.js'
    'vendor/ika.jvectormap/jquery-jvectormap-1.2.2.css'
  ]
  'vector-map-maps': files: [
    'vendor/ika.jvectormap/jquery-jvectormap-world-mill-en.js'
    'vendor/ika.jvectormap/jquery-jvectormap-us-mill-en.js'
  ]
  'datatables':
    serie: true
    files: [
      'vendor/datatables/media/css/jquery.dataTables.css'
      'vendor/datatables/media/js/jquery.dataTables.js'
      'vendor/angular-datatables/dist/angular-datatables.js'
      'vendor/angular-datatables/dist/plugins/bootstrap/datatables.bootstrap.css'
      'vendor/angular-datatables/dist/plugins/bootstrap/angular-datatables.bootstrap.js'
    ]
  'ngTable': files: [
    'vendor/ng-table/dist/ng-table.min.js'
    'vendor/ng-table/dist/ng-table.min.css'
  ]
  'ngTableExport': files: [ 'vendor/ng-table-export/ng-table-export.js' ]
  'blueimp-gallery': files: [
    'vendor/blueimp-gallery/js/jquery.blueimp-gallery.min.js'
    'vendor/blueimp-gallery/css/blueimp-gallery.min.css'
  ]