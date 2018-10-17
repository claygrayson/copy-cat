module.exports = angular.module "copycat.dashboard.bootstrapui", [

]

.config [
  '$uibTooltipProvider'
  ($uibTooltipProvider) ->
    $uibTooltipProvider.options appendToBody: true
]

.controller "AlertDemoCtrl", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.alerts = [
        {
          type: 'danger'
          msg: 'Oh snap! Change a few things up and try submitting again.'
        }
        {
          type: 'warning'
          msg: 'Well done! You successfully read this important alert message.'
        }
      ]

      vm.addAlert = ->
        vm.alerts.push msg: 'Another alert!'
        return

      vm.closeAlert = (index) ->
        vm.alerts.splice index, 1
        return

      return

    activate()
]

.controller "ButtonsCtrl", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.singleModel = 1
      vm.radioModel = 'Middle'
      vm.checkModel =
        left: false
        middle: true
        right: false
      return

    activate()
]

.controller "CarouselDemoCtrl", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.myInterval = 5000
      vm.noWrapSlides = false
      vm.active = 0
      slides = vm.slides = []
      currIndex = 0

      vm.addSlide = (id) ->
        newWidth = 600 + slides.length + 1
        slides.push
          image: 'app/img/pic' + (id or 5) + '.jpg'
          text: [
            'More'
            'Extra'
            'Lots of'
            'Surplus'
          ][slides.length % 2] + ' ' + [
            'Trees'
            'Mountains'
            'Clouds'
            'Space'
          ][slides.length % 2]
          id: currIndex++
        return

      i = 0
      while i < 4
        vm.addSlide i + 1
        i++
      return

    activate()
]

.controller "DatepickerDemoCtrl", [
  () ->
    vm = this
    #//////////////

    activate = ->

      vm.today = ->
        vm.dt = new Date
        return

      vm.today()

      vm.clear = ->
        vm.dt = null
        return

      # Disable weekend selection

      vm.disabled = (date, mode) ->
        mode == 'day' and (date.getDay() == 0 or date.getDay() == 6)

      vm.toggleMin = ->
        vm.minDate = if vm.minDate then null else new Date
        return

      vm.toggleMin()

      vm.open = ($event) ->
        $event.preventDefault()
        $event.stopPropagation()
        vm.opened = true
        return

      vm.initDate = new Date('2019-10-20')
      vm.formats = [
        'dd-MMMM-yyyy'
        'yyyy/MM/dd'
        'dd.MM.yyyy'
        'shortDate'
      ]
      vm.format = vm.formats[0]
      vm.dateOptions =
        formatYear: 'yy'
        startingDay: 1
        maxDate: '\'2020-06-22\''
        showWeeks: false
        datePickerPopup: vm.format
      return

    activate()
]

.controller "ModalController", [
  '$uibModal'
  ($uibModal) ->
    vm = this
    #//////////////

    activate = ->

      ModalInstanceCtrl = ($scope, $uibModalInstance) ->

        $scope.ok = ->
          $uibModalInstance.close 'closed'
          return

        $scope.cancel = ->
          $uibModalInstance.dismiss 'cancel'
          return

        return

      vm.open = (size) ->
        modalInstance = $uibModal.open(
          templateUrl: '/myModalContent.html'
          controller: ModalInstanceCtrl
          size: size)
        state = $('#modal-state')
        modalInstance.result.then (->
          state.text 'Modal dismissed with OK status'
          return
        ), ->
          state.text 'Modal dismissed with Cancel status'
          return
        return

      # Please note that $uibModalInstance represents a modal window (instance) dependency.
      # It is not the same as the $uibModal service used above.
      ModalInstanceCtrl.$inject = [
        '$scope'
        '$uibModalInstance'
      ]
      return

    activate()
]

.controller "PaginationDemoCtrl", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.totalItems = 64
      vm.currentPage = 4

      vm.setPage = (pageNo) ->
        vm.currentPage = pageNo
        return

      vm.pageChanged = ->
        console.log 'Page changed to: ' + vm.currentPage
        return

      vm.maxSize = 5
      vm.bigTotalItems = 175
      vm.bigCurrentPage = 1
      return

    activate()
]

.controller "PopoverDemoCtrl", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.dynamicPopover = 'Hello, World!'
      vm.dynamicPopoverTitle = 'Title'
      return

    activate()
]

.controller "ProgressDemoCtrl", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.max = 200

      vm.random = ->
        value = Math.floor(Math.random() * 100 + 1)
        type = undefined
        if value < 25
          type = 'success'
        else if value < 50
          type = 'info'
        else if value < 75
          type = 'warning'
        else
          type = 'danger'
        vm.showWarning = type == 'danger' or type == 'warning'
        vm.dynamic = value
        vm.type = type
        return

      vm.random()

      vm.randomStacked = ->
        vm.stacked = []
        types = [
          'success'
          'info'
          'warning'
          'danger'
        ]
        i = 0
        n = Math.floor(Math.random() * 4 + 1)
        while i < n
          index = Math.floor(Math.random() * 4)
          vm.stacked.push
            value: Math.floor(Math.random() * 30 + 1)
            type: types[index]
          i++
        return

      vm.randomStacked()
      return

    activate()
]

.controller "RatingDemoCtrl", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.rate = 7
      vm.max = 10
      vm.isReadonly = false

      vm.hoveringOver = (value) ->
        vm.overStar = value
        vm.percent = 100 * value / vm.max
        return

      vm.ratingStates = [
        {
          stateOn: 'icon-2x ion-android-radio-button-on'
          stateOff: 'icon-2x ion-android-radio-button-off'
        }
        {
          stateOn: 'icon-2x ion-android-star'
          stateOff: 'icon-2x ion-android-star-outline'
        }
        {
          stateOn: 'icon-2x ion-android-folder'
          stateOff: 'icon-2x ion-android-folder-open'
        }
      ]
      return

    activate()
]

.controller "TimepickerDemoCtrl", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.mytime = new Date
      vm.hstep = 1
      vm.mstep = 15
      vm.options =
        hstep: [
          1
          2
          3
        ]
        mstep: [
          1
          5
          10
          15
          25
          30
        ]
      vm.ismeridian = true

      vm.toggleMode = ->
        vm.ismeridian = !vm.ismeridian
        return

      vm.update = ->
        d = new Date
        d.setHours 14
        d.setMinutes 0
        vm.mytime = d
        return

      vm.changed = ->
        console.log 'Time changed to: ' + vm.mytime
        return

      vm.clear = ->
        vm.mytime = null
        return

      return

    activate()
]

.controller "TooltipDemoCtrl", [
  () ->
    vm = this
    #//////////////

    activate = ->
      # Predicts tooltip top position
      # based on the trigger element

      predictTooltipTop = (el) ->
        top = el.offsetTop
        height = 40
        # asumes ~40px tooltip height
        while el.offsetParent
          el = el.offsetParent
          top += el.offsetTop
        top - height - (window.pageYOffset)

      # Predicts tooltip top position
      # based on the trigger element

      predictTooltipLeft = (el) ->
        left = el.offsetLeft
        width = el.offsetWidth
        while el.offsetParent
          el = el.offsetParent
          left += el.offsetLeft
        left - width - (window.pageXOffset)

      vm.dynamicTooltip = 'Hello, World!'
      vm.dynamicTooltipText = 'dynamic'
      vm.htmlTooltip = '\'<i>I am so <b>bold</b> !</i>\''

      vm.autoplace = (context, source) ->
        #return (predictTooltipTop(source) < 0) ?  "bottom": "top";
        pos = 'top'
        if predictTooltipTop(source) < 0
          pos = 'bottom'
        if predictTooltipLeft(source) < 0
          pos = 'right'
        pos

      return

    activate()
]

.controller "TypeaheadCtrl", [
  '$http'
  ($http) ->
    vm = this
    #//////////////

    activate = ->
      vm.selected = undefined
      vm.states = [
        'Alabama'
        'Alaska'
        'Arizona'
        'Arkansas'
        'California'
        'Colorado'
        'Connecticut'
        'Delaware'
        'Florida'
        'Georgia'
        'Hawaii'
        'Idaho'
        'Illinois'
        'Indiana'
        'Iowa'
        'Kansas'
        'Kentucky'
        'Louisiana'
        'Maine'
        'Maryland'
        'Massachusetts'
        'Michigan'
        'Minnesota'
        'Mississippi'
        'Missouri'
        'Montana'
        'Nebraska'
        'Nevada'
        'New Hampshire'
        'New Jersey'
        'New Mexico'
        'New York'
        'North Dakota'
        'North Carolina'
        'Ohio'
        'Oklahoma'
        'Oregon'
        'Pennsylvania'
        'Rhode Island'
        'South Carolina'
        'South Dakota'
        'Tennessee'
        'Texas'
        'Utah'
        'Vermont'
        'Virginia'
        'Washington'
        'West Virginia'
        'Wisconsin'
        'Wyoming'
      ]
      # Any function returning a promise object can be used to load values asynchronously

      vm.getLocation = (val) ->
        $http.get('//maps.googleapis.com/maps/api/geocode/json', params: address: val).then (res) ->
          addresses = []
          angular.forEach res.data.results, (item) ->

            ###jshint -W106###

            addresses.push item.formatted_address
            return
          addresses

      vm.statesWithFlags = [
        {
          'name': 'Alabama'
          'flag': '5/5c/Flag_of_Alabama.svg/45px-Flag_of_Alabama.svg.png'
        }
        {
          'name': 'Alaska'
          'flag': 'e/e6/Flag_of_Alaska.svg/43px-Flag_of_Alaska.svg.png'
        }
        {
          'name': 'Arizona'
          'flag': '9/9d/Flag_of_Arizona.svg/45px-Flag_of_Arizona.svg.png'
        }
        {
          'name': 'Arkansas'
          'flag': '9/9d/Flag_of_Arkansas.svg/45px-Flag_of_Arkansas.svg.png'
        }
        {
          'name': 'California'
          'flag': '0/01/Flag_of_California.svg/45px-Flag_of_California.svg.png'
        }
        {
          'name': 'Colorado'
          'flag': '4/46/Flag_of_Colorado.svg/45px-Flag_of_Colorado.svg.png'
        }
        {
          'name': 'Connecticut'
          'flag': '9/96/Flag_of_Connecticut.svg/39px-Flag_of_Connecticut.svg.png'
        }
        {
          'name': 'Delaware'
          'flag': 'c/c6/Flag_of_Delaware.svg/45px-Flag_of_Delaware.svg.png'
        }
        {
          'name': 'Florida'
          'flag': 'f/f7/Flag_of_Florida.svg/45px-Flag_of_Florida.svg.png'
        }
        {
          'name': 'Georgia'
          'flag': '5/54/Flag_of_Georgia_%28U.S._state%29.svg/46px-Flag_of_Georgia_%28U.S._state%29.svg.png'
        }
        {
          'name': 'Hawaii'
          'flag': 'e/ef/Flag_of_Hawaii.svg/46px-Flag_of_Hawaii.svg.png'
        }
        {
          'name': 'Idaho'
          'flag': 'a/a4/Flag_of_Idaho.svg/38px-Flag_of_Idaho.svg.png'
        }
        {
          'name': 'Illinois'
          'flag': '0/01/Flag_of_Illinois.svg/46px-Flag_of_Illinois.svg.png'
        }
        {
          'name': 'Indiana'
          'flag': 'a/ac/Flag_of_Indiana.svg/45px-Flag_of_Indiana.svg.png'
        }
        {
          'name': 'Iowa'
          'flag': 'a/aa/Flag_of_Iowa.svg/44px-Flag_of_Iowa.svg.png'
        }
        {
          'name': 'Kansas'
          'flag': 'd/da/Flag_of_Kansas.svg/46px-Flag_of_Kansas.svg.png'
        }
        {
          'name': 'Kentucky'
          'flag': '8/8d/Flag_of_Kentucky.svg/46px-Flag_of_Kentucky.svg.png'
        }
        {
          'name': 'Louisiana'
          'flag': 'e/e0/Flag_of_Louisiana.svg/46px-Flag_of_Louisiana.svg.png'
        }
        {
          'name': 'Maine'
          'flag': '3/35/Flag_of_Maine.svg/45px-Flag_of_Maine.svg.png'
        }
        {
          'name': 'Maryland'
          'flag': 'a/a0/Flag_of_Maryland.svg/45px-Flag_of_Maryland.svg.png'
        }
        {
          'name': 'Massachusetts'
          'flag': 'f/f2/Flag_of_Massachusetts.svg/46px-Flag_of_Massachusetts.svg.png'
        }
        {
          'name': 'Michigan'
          'flag': 'b/b5/Flag_of_Michigan.svg/45px-Flag_of_Michigan.svg.png'
        }
        {
          'name': 'Minnesota'
          'flag': 'b/b9/Flag_of_Minnesota.svg/46px-Flag_of_Minnesota.svg.png'
        }
        {
          'name': 'Mississippi'
          'flag': '4/42/Flag_of_Mississippi.svg/45px-Flag_of_Mississippi.svg.png'
        }
        {
          'name': 'Missouri'
          'flag': '5/5a/Flag_of_Missouri.svg/46px-Flag_of_Missouri.svg.png'
        }
        {
          'name': 'Montana'
          'flag': 'c/cb/Flag_of_Montana.svg/45px-Flag_of_Montana.svg.png'
        }
        {
          'name': 'Nebraska'
          'flag': '4/4d/Flag_of_Nebraska.svg/46px-Flag_of_Nebraska.svg.png'
        }
        {
          'name': 'Nevada'
          'flag': 'f/f1/Flag_of_Nevada.svg/45px-Flag_of_Nevada.svg.png'
        }
        {
          'name': 'New Hampshire'
          'flag': '2/28/Flag_of_New_Hampshire.svg/45px-Flag_of_New_Hampshire.svg.png'
        }
        {
          'name': 'New Jersey'
          'flag': '9/92/Flag_of_New_Jersey.svg/45px-Flag_of_New_Jersey.svg.png'
        }
        {
          'name': 'New Mexico'
          'flag': 'c/c3/Flag_of_New_Mexico.svg/45px-Flag_of_New_Mexico.svg.png'
        }
        {
          'name': 'New York'
          'flag': '1/1a/Flag_of_New_York.svg/46px-Flag_of_New_York.svg.png'
        }
        {
          'name': 'North Carolina'
          'flag': 'b/bb/Flag_of_North_Carolina.svg/45px-Flag_of_North_Carolina.svg.png'
        }
        {
          'name': 'North Dakota'
          'flag': 'e/ee/Flag_of_North_Dakota.svg/38px-Flag_of_North_Dakota.svg.png'
        }
        {
          'name': 'Ohio'
          'flag': '4/4c/Flag_of_Ohio.svg/46px-Flag_of_Ohio.svg.png'
        }
        {
          'name': 'Oklahoma'
          'flag': '6/6e/Flag_of_Oklahoma.svg/45px-Flag_of_Oklahoma.svg.png'
        }
        {
          'name': 'Oregon'
          'flag': 'b/b9/Flag_of_Oregon.svg/46px-Flag_of_Oregon.svg.png'
        }
        {
          'name': 'Pennsylvania'
          'flag': 'f/f7/Flag_of_Pennsylvania.svg/45px-Flag_of_Pennsylvania.svg.png'
        }
        {
          'name': 'Rhode Island'
          'flag': 'f/f3/Flag_of_Rhode_Island.svg/32px-Flag_of_Rhode_Island.svg.png'
        }
        {
          'name': 'South Carolina'
          'flag': '6/69/Flag_of_South_Carolina.svg/45px-Flag_of_South_Carolina.svg.png'
        }
        {
          'name': 'South Dakota'
          'flag': '1/1a/Flag_of_South_Dakota.svg/46px-Flag_of_South_Dakota.svg.png'
        }
        {
          'name': 'Tennessee'
          'flag': '9/9e/Flag_of_Tennessee.svg/46px-Flag_of_Tennessee.svg.png'
        }
        {
          'name': 'Texas'
          'flag': 'f/f7/Flag_of_Texas.svg/45px-Flag_of_Texas.svg.png'
        }
        {
          'name': 'Utah'
          'flag': 'f/f6/Flag_of_Utah.svg/45px-Flag_of_Utah.svg.png'
        }
        {
          'name': 'Vermont'
          'flag': '4/49/Flag_of_Vermont.svg/46px-Flag_of_Vermont.svg.png'
        }
        {
          'name': 'Virginia'
          'flag': '4/47/Flag_of_Virginia.svg/44px-Flag_of_Virginia.svg.png'
        }
        {
          'name': 'Washington'
          'flag': '5/54/Flag_of_Washington.svg/46px-Flag_of_Washington.svg.png'
        }
        {
          'name': 'West Virginia'
          'flag': '2/22/Flag_of_West_Virginia.svg/46px-Flag_of_West_Virginia.svg.png'
        }
        {
          'name': 'Wisconsin'
          'flag': '2/22/Flag_of_Wisconsin.svg/45px-Flag_of_Wisconsin.svg.png'
        }
        {
          'name': 'Wyoming'
          'flag': 'b/bc/Flag_of_Wyoming.svg/43px-Flag_of_Wyoming.svg.png'
        }
      ]
      return

    activate()
]