module.exports = angular.module "copycat.dashboard.forms", [

]

.run [
  'Menu'
  (Menu) ->
    menuItem =
      name: 'Forms'
      sref: 'app.forms'
      imgpath: 'app/img/icons/clipboard.svg'
      order: 4
      subitems: [
        {
          name: 'Classic'
          sref: 'app.forms.classic'
        }
        {
          name: 'Validation'
          sref: 'app.forms.validation'
        }
        {
          name: 'Advanced'
          sref: 'app.forms.advanced'
        }
        {
          name: 'Material'
          sref: 'app.forms.material'
        }
        {
          name: 'Editors'
          sref: 'app.forms.editor'
        }
        {
          name: 'Upload'
          sref: 'app.forms.upload'
        }
        {
          name: 'Dropzone'
          sref: 'app.forms.dropzone'
        }
        {
          name: 'xEditable'
          sref: 'app.forms.xeditable'
        }
      ]
    Menu.addItem menuItem
]

.run [
  'Router'
  (Router) ->
    Router.state('app.forms',
      url: '/forms'
      abstract: true
      template: '<div ui-view class="ng-fadeInLeftShort"></div>')
    .state('app.forms.material',
      url: '/material'
      title: 'Material Inputs'
      templateUrl: 'material.html')
    .state('app.forms.validation',
      url: '/validation'
      title: 'Validation'
      templateUrl: 'validation.html'
      require: [ 'ui.select' ])
    .state('app.forms.classic',
      url: '/classic'
      title: 'Classic Inputs'
      templateUrl: 'forms.classic.html')
    .state('app.forms.advanced',
      url: '/advanced'
      title: 'Advanced'
      templateUrl: 'forms.advanced.html'
      require: [
        'ui.select'
        'vr.directives.slider'
        'colorpicker.module'
      ])
    .state('app.forms.editor',
      url: '/editor'
      title: 'Editors'
      templateUrl: 'editor.html'
      require: [
        'fontawesome'
        'summernote'
      ])
    .state('app.forms.upload',
      url: '/upload'
      title: 'Forms Upload'
      templateUrl: 'upload.html'
      require: [
        'filestyle'
        'angularFileUpload'
      ])
    .state('app.forms.dropzone',
      url: '/dropzone'
      title: 'Dropzone'
      templateUrl: 'dropzone.html'
      require: [ 'ngDropzone' ])
    .state 'app.forms.xeditable',
      url: '/xeditable'
      title: 'Forms Xeditable'
      templateUrl: 'xeditable.form.html'
      require: [ 'xeditable' ]
]

.directive "filestyle", [
  () ->
    link = (scope, element) ->
      element.filestyle angular.extend(scope.options or {}, element.data() or {})
      return

    link: link
    restrict: 'A'
    scope:
      options: '='
]

.controller "ColorPickerController", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.hexPicker = color: ''
      vm.rgbPicker = color: ''
      vm.rgbaPicker = color: ''
      vm.nonInput = color: ''

      vm.resetColor = ->
        vm.hexPicker = color: '#ff0000'
        return

      vm.resetRBGColor = ->
        vm.rgbPicker = color: 'rgb(255,255,255)'
        return

      vm.resetRBGAColor = ->
        vm.rgbaPicker = color: 'rgb(255,255,255, 0.25)'
        return

      vm.resetNonInputColor = ->
        vm.nonInput = color: '#ffffff'
        return

      return

    activate()
]

.controller "DropzoneController", [
  () ->
    vm = this
    #//////////////

    activate = ->
      vm.dropzoneConfig =
        autoProcessQueue: false
        uploadMultiple: true
        parallelUploads: 100
        maxFiles: 100
        dictDefaultMessage: '<em class="ion-upload text-info icon-2x"></em><br>Drop files here to upload'
        paramName: 'file'
        maxFilesize: 2
        addRemoveLinks: true
        accept: (file, done) ->
          if file.name == 'justinbieber.jpg'
            done 'Naha, you dont. :)'
          else
            done()
          return
        init: ->
          dzHandler = this
          @element.querySelector('button[type=submit]').addEventListener 'click', (e) ->
            e.preventDefault()
            e.stopPropagation()
            dzHandler.processQueue()
            return
          @on 'addedfile', (file) ->
            console.log 'Added file: ' + file.name
            return
          @on 'removedfile', (file) ->
            console.log 'Removed file: ' + file.name
            return
          @on 'sendingmultiple', ->
          @on 'successmultiple', ->
          @on 'errormultiple', ->
          return
      return

    activate()
]

.controller "FormEditorController", [
  () ->
    vm = this
    #//////////////

    activate = ->
      # Summernote
      # -----------------------------------
      vm.summernoteText = 'Pellentesque sollicitudin sollicitudin erat, in imperdiet tortor fringilla ut...'
      vm.airmodeText = '<h3>Vivamus elit lectus</h3>' + '<p><i>Duis cursus consectetur elementum.</i></p>'/
                      '<p>Suscipit a venenatis id, varius sit amet nunc. Mauris eu lacus massa, vel condimentum'/
                      ' lectus. Quisque sollicitudin massa vel erat tincidunt blandit. Nulla mauris sem, hendrerit'/
                      ' sed fringilla a, facilisis vitae eros. Donec ullamcorper scelerisque mollis. Donec ac'/
                      ' lectus vel nulla pretium porta tempus eget tortor. Pellentesque sed purus libero. Praesent'/
                      ' nec eros ac urna dictum ultrices. Donec at feugiat risus.</p>' + '<p>Fusce dolor lacus,'/
                      ' interdum eu tincidunt sed, aliquet vel turpis. Nunc luctus, quam non condimentum ornare, orci'/
                      ' ligula malesuada lacus, nec sagittis neque augue vel nunc. Quisque congue egestas cursus.'/
                      ' Integer lorem metus, rutrum non rhoncus sed, fringilla interdum urna. Curabitur gravida,'/
                      ' ante ac imperdiet accumsan, quam nibh porttitor mauris, non luctus sem lectus porta augue.'/
                      ' Nunc eget augue mi.</p><br>' + '<p>Aliquam eget dui tellus.</p>'
      return

    activate()
]

.controller "RangeSliderController", [
  () ->
    vm = this
    #//////////////

    activate = ->
      # Set initial values
      vm.value = 50
      vm.range =
        min: 20
        max: 80
      vm.formatted = 30
      vm.range2 =
        min: 20
        max: 80
      # return the value converted

      vm.priceFormat = (value) ->
        '$' + value.toString()

      return

    activate()
]

.controller "uiSelectController", [
  '$scope', '$http'
  ($scope, $http) ->
    vm = this
    #//////////////

    activate = ->
      vm.disabled = undefined

      vm.enable = ->
        vm.disabled = false
        return

      vm.disable = ->
        vm.disabled = true
        return

      vm.clear = ->
        vm.person.selected = undefined
        vm.address.selected = undefined
        vm.country.selected = undefined
        return

      vm.person = {}
      vm.people = [
        {
          name: 'Adam'
          email: 'adam@email.com'
          age: 10
        }
        {
          name: 'Amalie'
          email: 'amalie@email.com'
          age: 12
        }
        {
          name: 'Wladimir'
          email: 'wladimir@email.com'
          age: 30
        }
        {
          name: 'Samantha'
          email: 'samantha@email.com'
          age: 31
        }
        {
          name: 'Estefanía'
          email: 'estefanía@email.com'
          age: 16
        }
        {
          name: 'Natasha'
          email: 'natasha@email.com'
          age: 54
        }
        {
          name: 'Nicole'
          email: 'nicole@email.com'
          age: 43
        }
        {
          name: 'Adrian'
          email: 'adrian@email.com'
          age: 21
        }
      ]
      vm.address = {}

      vm.refreshAddresses = (address) ->
        if !address
          return
        params = address: address
        $http.get('//maps.googleapis.com/maps/api/geocode/json', params: params).then (response) ->
          vm.addresses = response.data.results
          return

      vm.country = {}
      vm.countries = [
        {
          name: 'Afghanistan'
          code: 'AF'
        }
        {
          name: 'Åland Islands'
          code: 'AX'
        }
        {
          name: 'Albania'
          code: 'AL'
        }
        {
          name: 'Algeria'
          code: 'DZ'
        }
        {
          name: 'American Samoa'
          code: 'AS'
        }
        {
          name: 'Andorra'
          code: 'AD'
        }
        {
          name: 'Angola'
          code: 'AO'
        }
        {
          name: 'Anguilla'
          code: 'AI'
        }
        {
          name: 'Antarctica'
          code: 'AQ'
        }
        {
          name: 'Antigua and Barbuda'
          code: 'AG'
        }
        {
          name: 'Argentina'
          code: 'AR'
        }
        {
          name: 'Armenia'
          code: 'AM'
        }
        {
          name: 'Aruba'
          code: 'AW'
        }
        {
          name: 'Australia'
          code: 'AU'
        }
        {
          name: 'Austria'
          code: 'AT'
        }
        {
          name: 'Azerbaijan'
          code: 'AZ'
        }
        {
          name: 'Bahamas'
          code: 'BS'
        }
        {
          name: 'Bahrain'
          code: 'BH'
        }
        {
          name: 'Bangladesh'
          code: 'BD'
        }
        {
          name: 'Barbados'
          code: 'BB'
        }
        {
          name: 'Belarus'
          code: 'BY'
        }
        {
          name: 'Belgium'
          code: 'BE'
        }
        {
          name: 'Belize'
          code: 'BZ'
        }
        {
          name: 'Benin'
          code: 'BJ'
        }
        {
          name: 'Bermuda'
          code: 'BM'
        }
        {
          name: 'Bhutan'
          code: 'BT'
        }
        {
          name: 'Bolivia'
          code: 'BO'
        }
        {
          name: 'Bosnia and Herzegovina'
          code: 'BA'
        }
        {
          name: 'Botswana'
          code: 'BW'
        }
        {
          name: 'Bouvet Island'
          code: 'BV'
        }
        {
          name: 'Brazil'
          code: 'BR'
        }
        {
          name: 'British Indian Ocean Territory'
          code: 'IO'
        }
        {
          name: 'Brunei Darussalam'
          code: 'BN'
        }
        {
          name: 'Bulgaria'
          code: 'BG'
        }
        {
          name: 'Burkina Faso'
          code: 'BF'
        }
        {
          name: 'Burundi'
          code: 'BI'
        }
        {
          name: 'Cambodia'
          code: 'KH'
        }
        {
          name: 'Cameroon'
          code: 'CM'
        }
        {
          name: 'Canada'
          code: 'CA'
        }
        {
          name: 'Cape Verde'
          code: 'CV'
        }
        {
          name: 'Cayman Islands'
          code: 'KY'
        }
        {
          name: 'Central African Republic'
          code: 'CF'
        }
        {
          name: 'Chad'
          code: 'TD'
        }
        {
          name: 'Chile'
          code: 'CL'
        }
        {
          name: 'China'
          code: 'CN'
        }
        {
          name: 'Christmas Island'
          code: 'CX'
        }
        {
          name: 'Cocos (Keeling) Islands'
          code: 'CC'
        }
        {
          name: 'Colombia'
          code: 'CO'
        }
        {
          name: 'Comoros'
          code: 'KM'
        }
        {
          name: 'Congo'
          code: 'CG'
        }
        {
          name: 'Congo, The Democratic Republic of the'
          code: 'CD'
        }
        {
          name: 'Cook Islands'
          code: 'CK'
        }
        {
          name: 'Costa Rica'
          code: 'CR'
        }
        {
          name: 'Cote D\'Ivoire'
          code: 'CI'
        }
        {
          name: 'Croatia'
          code: 'HR'
        }
        {
          name: 'Cuba'
          code: 'CU'
        }
        {
          name: 'Cyprus'
          code: 'CY'
        }
        {
          name: 'Czech Republic'
          code: 'CZ'
        }
        {
          name: 'Denmark'
          code: 'DK'
        }
        {
          name: 'Djibouti'
          code: 'DJ'
        }
        {
          name: 'Dominica'
          code: 'DM'
        }
        {
          name: 'Dominican Republic'
          code: 'DO'
        }
        {
          name: 'Ecuador'
          code: 'EC'
        }
        {
          name: 'Egypt'
          code: 'EG'
        }
        {
          name: 'El Salvador'
          code: 'SV'
        }
        {
          name: 'Equatorial Guinea'
          code: 'GQ'
        }
        {
          name: 'Eritrea'
          code: 'ER'
        }
        {
          name: 'Estonia'
          code: 'EE'
        }
        {
          name: 'Ethiopia'
          code: 'ET'
        }
        {
          name: 'Falkland Islands (Malvinas)'
          code: 'FK'
        }
        {
          name: 'Faroe Islands'
          code: 'FO'
        }
        {
          name: 'Fiji'
          code: 'FJ'
        }
        {
          name: 'Finland'
          code: 'FI'
        }
        {
          name: 'France'
          code: 'FR'
        }
        {
          name: 'French Guiana'
          code: 'GF'
        }
        {
          name: 'French Polynesia'
          code: 'PF'
        }
        {
          name: 'French Southern Territories'
          code: 'TF'
        }
        {
          name: 'Gabon'
          code: 'GA'
        }
        {
          name: 'Gambia'
          code: 'GM'
        }
        {
          name: 'Georgia'
          code: 'GE'
        }
        {
          name: 'Germany'
          code: 'DE'
        }
        {
          name: 'Ghana'
          code: 'GH'
        }
        {
          name: 'Gibraltar'
          code: 'GI'
        }
        {
          name: 'Greece'
          code: 'GR'
        }
        {
          name: 'Greenland'
          code: 'GL'
        }
        {
          name: 'Grenada'
          code: 'GD'
        }
        {
          name: 'Guadeloupe'
          code: 'GP'
        }
        {
          name: 'Guam'
          code: 'GU'
        }
        {
          name: 'Guatemala'
          code: 'GT'
        }
        {
          name: 'Guernsey'
          code: 'GG'
        }
        {
          name: 'Guinea'
          code: 'GN'
        }
        {
          name: 'Guinea-Bissau'
          code: 'GW'
        }
        {
          name: 'Guyana'
          code: 'GY'
        }
        {
          name: 'Haiti'
          code: 'HT'
        }
        {
          name: 'Heard Island and Mcdonald Islands'
          code: 'HM'
        }
        {
          name: 'Holy See (Vatican City State)'
          code: 'VA'
        }
        {
          name: 'Honduras'
          code: 'HN'
        }
        {
          name: 'Hong Kong'
          code: 'HK'
        }
        {
          name: 'Hungary'
          code: 'HU'
        }
        {
          name: 'Iceland'
          code: 'IS'
        }
        {
          name: 'India'
          code: 'IN'
        }
        {
          name: 'Indonesia'
          code: 'ID'
        }
        {
          name: 'Iran, Islamic Republic Of'
          code: 'IR'
        }
        {
          name: 'Iraq'
          code: 'IQ'
        }
        {
          name: 'Ireland'
          code: 'IE'
        }
        {
          name: 'Isle of Man'
          code: 'IM'
        }
        {
          name: 'Israel'
          code: 'IL'
        }
        {
          name: 'Italy'
          code: 'IT'
        }
        {
          name: 'Jamaica'
          code: 'JM'
        }
        {
          name: 'Japan'
          code: 'JP'
        }
        {
          name: 'Jersey'
          code: 'JE'
        }
        {
          name: 'Jordan'
          code: 'JO'
        }
        {
          name: 'Kazakhstan'
          code: 'KZ'
        }
        {
          name: 'Kenya'
          code: 'KE'
        }
        {
          name: 'Kiribati'
          code: 'KI'
        }
        {
          name: 'Korea, Democratic People\'s Republic of'
          code: 'KP'
        }
        {
          name: 'Korea, Republic of'
          code: 'KR'
        }
        {
          name: 'Kuwait'
          code: 'KW'
        }
        {
          name: 'Kyrgyzstan'
          code: 'KG'
        }
        {
          name: 'Lao People\'s Democratic Republic'
          code: 'LA'
        }
        {
          name: 'Latvia'
          code: 'LV'
        }
        {
          name: 'Lebanon'
          code: 'LB'
        }
        {
          name: 'Lesotho'
          code: 'LS'
        }
        {
          name: 'Liberia'
          code: 'LR'
        }
        {
          name: 'Libyan Arab Jamahiriya'
          code: 'LY'
        }
        {
          name: 'Liechtenstein'
          code: 'LI'
        }
        {
          name: 'Lithuania'
          code: 'LT'
        }
        {
          name: 'Luxembourg'
          code: 'LU'
        }
        {
          name: 'Macao'
          code: 'MO'
        }
        {
          name: 'Macedonia, The Former Yugoslav Republic of'
          code: 'MK'
        }
        {
          name: 'Madagascar'
          code: 'MG'
        }
        {
          name: 'Malawi'
          code: 'MW'
        }
        {
          name: 'Malaysia'
          code: 'MY'
        }
        {
          name: 'Maldives'
          code: 'MV'
        }
        {
          name: 'Mali'
          code: 'ML'
        }
        {
          name: 'Malta'
          code: 'MT'
        }
        {
          name: 'Marshall Islands'
          code: 'MH'
        }
        {
          name: 'Martinique'
          code: 'MQ'
        }
        {
          name: 'Mauritania'
          code: 'MR'
        }
        {
          name: 'Mauritius'
          code: 'MU'
        }
        {
          name: 'Mayotte'
          code: 'YT'
        }
        {
          name: 'Mexico'
          code: 'MX'
        }
        {
          name: 'Micronesia, Federated States of'
          code: 'FM'
        }
        {
          name: 'Moldova, Republic of'
          code: 'MD'
        }
        {
          name: 'Monaco'
          code: 'MC'
        }
        {
          name: 'Mongolia'
          code: 'MN'
        }
        {
          name: 'Montserrat'
          code: 'MS'
        }
        {
          name: 'Morocco'
          code: 'MA'
        }
        {
          name: 'Mozambique'
          code: 'MZ'
        }
        {
          name: 'Myanmar'
          code: 'MM'
        }
        {
          name: 'Namibia'
          code: 'NA'
        }
        {
          name: 'Nauru'
          code: 'NR'
        }
        {
          name: 'Nepal'
          code: 'NP'
        }
        {
          name: 'Netherlands'
          code: 'NL'
        }
        {
          name: 'Netherlands Antilles'
          code: 'AN'
        }
        {
          name: 'New Caledonia'
          code: 'NC'
        }
        {
          name: 'New Zealand'
          code: 'NZ'
        }
        {
          name: 'Nicaragua'
          code: 'NI'
        }
        {
          name: 'Niger'
          code: 'NE'
        }
        {
          name: 'Nigeria'
          code: 'NG'
        }
        {
          name: 'Niue'
          code: 'NU'
        }
        {
          name: 'Norfolk Island'
          code: 'NF'
        }
        {
          name: 'Northern Mariana Islands'
          code: 'MP'
        }
        {
          name: 'Norway'
          code: 'NO'
        }
        {
          name: 'Oman'
          code: 'OM'
        }
        {
          name: 'Pakistan'
          code: 'PK'
        }
        {
          name: 'Palau'
          code: 'PW'
        }
        {
          name: 'Palestinian Territory, Occupied'
          code: 'PS'
        }
        {
          name: 'Panama'
          code: 'PA'
        }
        {
          name: 'Papua New Guinea'
          code: 'PG'
        }
        {
          name: 'Paraguay'
          code: 'PY'
        }
        {
          name: 'Peru'
          code: 'PE'
        }
        {
          name: 'Philippines'
          code: 'PH'
        }
        {
          name: 'Pitcairn'
          code: 'PN'
        }
        {
          name: 'Poland'
          code: 'PL'
        }
        {
          name: 'Portugal'
          code: 'PT'
        }
        {
          name: 'Puerto Rico'
          code: 'PR'
        }
        {
          name: 'Qatar'
          code: 'QA'
        }
        {
          name: 'Reunion'
          code: 'RE'
        }
        {
          name: 'Romania'
          code: 'RO'
        }
        {
          name: 'Russian Federation'
          code: 'RU'
        }
        {
          name: 'Rwanda'
          code: 'RW'
        }
        {
          name: 'Saint Helena'
          code: 'SH'
        }
        {
          name: 'Saint Kitts and Nevis'
          code: 'KN'
        }
        {
          name: 'Saint Lucia'
          code: 'LC'
        }
        {
          name: 'Saint Pierre and Miquelon'
          code: 'PM'
        }
        {
          name: 'Saint Vincent and the Grenadines'
          code: 'VC'
        }
        {
          name: 'Samoa'
          code: 'WS'
        }
        {
          name: 'San Marino'
          code: 'SM'
        }
        {
          name: 'Sao Tome and Principe'
          code: 'ST'
        }
        {
          name: 'Saudi Arabia'
          code: 'SA'
        }
        {
          name: 'Senegal'
          code: 'SN'
        }
        {
          name: 'Serbia and Montenegro'
          code: 'CS'
        }
        {
          name: 'Seychelles'
          code: 'SC'
        }
        {
          name: 'Sierra Leone'
          code: 'SL'
        }
        {
          name: 'Singapore'
          code: 'SG'
        }
        {
          name: 'Slovakia'
          code: 'SK'
        }
        {
          name: 'Slovenia'
          code: 'SI'
        }
        {
          name: 'Solomon Islands'
          code: 'SB'
        }
        {
          name: 'Somalia'
          code: 'SO'
        }
        {
          name: 'South Africa'
          code: 'ZA'
        }
        {
          name: 'South Georgia and the South Sandwich Islands'
          code: 'GS'
        }
        {
          name: 'Spain'
          code: 'ES'
        }
        {
          name: 'Sri Lanka'
          code: 'LK'
        }
        {
          name: 'Sudan'
          code: 'SD'
        }
        {
          name: 'Suriname'
          code: 'SR'
        }
        {
          name: 'Svalbard and Jan Mayen'
          code: 'SJ'
        }
        {
          name: 'Swaziland'
          code: 'SZ'
        }
        {
          name: 'Sweden'
          code: 'SE'
        }
        {
          name: 'Switzerland'
          code: 'CH'
        }
        {
          name: 'Syrian Arab Republic'
          code: 'SY'
        }
        {
          name: 'Taiwan, Province of China'
          code: 'TW'
        }
        {
          name: 'Tajikistan'
          code: 'TJ'
        }
        {
          name: 'Tanzania, United Republic of'
          code: 'TZ'
        }
        {
          name: 'Thailand'
          code: 'TH'
        }
        {
          name: 'Timor-Leste'
          code: 'TL'
        }
        {
          name: 'Togo'
          code: 'TG'
        }
        {
          name: 'Tokelau'
          code: 'TK'
        }
        {
          name: 'Tonga'
          code: 'TO'
        }
        {
          name: 'Trinidad and Tobago'
          code: 'TT'
        }
        {
          name: 'Tunisia'
          code: 'TN'
        }
        {
          name: 'Turkey'
          code: 'TR'
        }
        {
          name: 'Turkmenistan'
          code: 'TM'
        }
        {
          name: 'Turks and Caicos Islands'
          code: 'TC'
        }
        {
          name: 'Tuvalu'
          code: 'TV'
        }
        {
          name: 'Uganda'
          code: 'UG'
        }
        {
          name: 'Ukraine'
          code: 'UA'
        }
        {
          name: 'United Arab Emirates'
          code: 'AE'
        }
        {
          name: 'United Kingdom'
          code: 'GB'
        }
        {
          name: 'United States'
          code: 'US'
        }
        {
          name: 'United States Minor Outlying Islands'
          code: 'UM'
        }
        {
          name: 'Uruguay'
          code: 'UY'
        }
        {
          name: 'Uzbekistan'
          code: 'UZ'
        }
        {
          name: 'Vanuatu'
          code: 'VU'
        }
        {
          name: 'Venezuela'
          code: 'VE'
        }
        {
          name: 'Vietnam'
          code: 'VN'
        }
        {
          name: 'Virgin Islands, British'
          code: 'VG'
        }
        {
          name: 'Virgin Islands, U.S.'
          code: 'VI'
        }
        {
          name: 'Wallis and Futuna'
          code: 'WF'
        }
        {
          name: 'Western Sahara'
          code: 'EH'
        }
        {
          name: 'Yemen'
          code: 'YE'
        }
        {
          name: 'Zambia'
          code: 'ZM'
        }
        {
          name: 'Zimbabwe'
          code: 'ZW'
        }
      ]
      # Multiple

      vm.someGroupFn = (item) ->
        if item.name[0] >= 'A' and item.name[0] <= 'M'
          return 'From A - M'
        if item.name[0] >= 'N' and item.name[0] <= 'Z'
          return 'From N - Z'
        return

      vm.counter = 0

      vm.someFunction = (item, model) ->
        vm.counter++
        vm.eventResult =
          item: item
          model: model
        return

      vm.availableColors = [
        'Red'
        'Green'
        'Blue'
        'Yellow'
        'Magenta'
        'Maroon'
        'Umbra'
        'Turquoise'
      ]
      vm.multipleDemo = {}
      vm.multipleDemo.colors = [
        'Blue'
        'Red'
      ]
      vm.multipleDemo.selectedPeople = [
        vm.people[5]
        vm.people[4]
      ]
      vm.multipleDemo.selectedPeopleWithGroupBy = [
        vm.people[8]
        vm.people[6]
      ]
      vm.multipleDemo.selectedPeopleSimple = [
        'samantha@email.com'
        'wladimir@email.com'
      ]
      return

    activate()
]

.filter "propsFilter", [
  () ->
    filterFilter = (items, props) ->
      out = []
      if angular.isArray(items)
        items.forEach (item) ->
          itemMatches = false
          keys = Object.keys(props)
          i = 0
          while i < keys.length
            prop = keys[i]
            text = props[prop].toLowerCase()
            if item[prop].toString().toLowerCase().indexOf(text) != -1
              itemMatches = true
              break
            i++
          if itemMatches
            out.push item
          return
      else
        # Let the output be the input untouched
        out = items
      out

    filterFilter
]

.controller "FileUploadController", [
  'FileUploader'
  (FileUploader) ->
    vm = this
    #//////////////

    activate = ->
      uploader = vm.uploader = new FileUploader(url: 'server/upload.php')
      # FILTERS
      uploader.filters.push
        name: 'customFilter'
        fn: ->
          @queue.length < 10
      # CALLBACKS

      uploader.onWhenAddingFileFailed = (item, filter, options) ->
        console.info 'onWhenAddingFileFailed', item, filter, options
        return

      uploader.onAfterAddingFile = (fileItem) ->
        console.info 'onAfterAddingFile', fileItem
        return

      uploader.onAfterAddingAll = (addedFileItems) ->
        console.info 'onAfterAddingAll', addedFileItems
        return

      uploader.onBeforeUploadItem = (item) ->
        console.info 'onBeforeUploadItem', item
        return

      uploader.onProgressItem = (fileItem, progress) ->
        console.info 'onProgressItem', fileItem, progress
        return

      uploader.onProgressAll = (progress) ->
        console.info 'onProgressAll', progress
        return

      uploader.onSuccessItem = (fileItem, response, status, headers) ->
        console.info 'onSuccessItem', fileItem, response, status, headers
        return

      uploader.onErrorItem = (fileItem, response, status, headers) ->
        console.info 'onErrorItem', fileItem, response, status, headers
        return

      uploader.onCancelItem = (fileItem, response, status, headers) ->
        console.info 'onCancelItem', fileItem, response, status, headers
        return

      uploader.onCompleteItem = (fileItem, response, status, headers) ->
        console.info 'onCompleteItem', fileItem, response, status, headers
        return

      uploader.onCompleteAll = ->
        console.info 'onCompleteAll'
        return

      console.info 'uploader', uploader
      return

    activate()
]

.controller "FormValidationController", [
  () ->
    vm = this
    #//////////////

    activate = ->

      vm.notBlackListed = (value) ->
        blacklist = [
          'bad@mail.com'
          'another@email.com'
        ]
        blacklist.indexOf(value) == -1

      vm.words = (value) ->
        value and value.split(' ').length

      # Submit form

      vm.submitForm = (formName) ->
        if vm[formName].$valid
          alert 'Submitted!!'
        else
          console.log 'Form name:' + formName + ': Not valid!!'
          return false
        return

      return

    activate()
]

.controller "FormxEditableController", [
  '$scope', 'editableOptions', 'editableThemes', '$filter', '$http'
  ($scope, editableOptions, editableThemes, $filter, $http) ->
    vm = this
    #//////////////

    activate = ->
      editableOptions.theme = 'bs3'
      editableThemes.bs3.inputClass = 'input-sm'
      editableThemes.bs3.buttonsClass = 'btn-sm'
      editableThemes.bs3.submitTpl = '<button type="submit" class="btn btn-success"><span class="fa fa-check"></span></button>'
      editableThemes.bs3.cancelTpl = '<button type="button" class="btn btn-default" ng-click="$form.$cancel()">'/
                                      '<span class="fa fa-times text-muted"></span>' + '</button>'
      vm.user =
        email: 'email@example.com'
        tel: '123-45-67'
        number: 29
        range: 10
        url: '//example.com'
        search: 'blabla'
        color: '#6a4415'
        date: null
        time: new Date
        datetime: null
        month: null
        week: null
        desc: 'Sed pharetra euismod dolor, id feugiat ante volutpat eget. '
      # Local select
      # -----------------------------------
      vm.user2 = status: 2
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

      vm.showStatus = ->
        selected = $filter('filter')(vm.statuses, value: vm.user2.status)
        if vm.user2.status and selected.length then selected[0].text else 'Not set'

      # select remote
      # -----------------------------------
      vm.user3 =
        id: 4
        text: 'admin'
      vm.groups = []

      vm.loadGroups = ->
        if vm.groups.length then null else $http.get('server/xeditable-groups.json').success(((data) ->
          vm.groups = data
          return
        ))

      $scope.$watch 'user3.id', (newVal, oldVal) ->
        if newVal != oldVal
          selected = $filter('filter')(vm.groups, id: vm.user3.id)
          vm.user3.text = if selected.length then selected[0].text else null
        return
      # Typeahead
      # -----------------------------------
      vm.user4 = state: 'Arizona'
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
      return

    vm.title = 'Controller'
    activate()
]