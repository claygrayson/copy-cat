require 'modernizr'
require 'jquery'
require 'angular'
require 'angular-bootstrap-tpls'
require 'angular-ui-router'
require 'angular-route'
require 'angular-cookies'
require 'angular-messages'
require 'angular-animate'
require 'angular-touch'
require 'ngStorage'
require 'angular-ui-mask'
require 'angular-ui-event'
require 'angular-ui-validate'
require 'angular-ui-indeterminate'
require 'angular-ui-scrollpoint'
require 'angular-ui-scroll'
require 'angular-ui-uploader'
require 'angular-ui-utils'
require 'angular-sanitize'
require 'angular-resource'
require 'angular-translate'
require 'angular-translate-loader-url'
require 'angular-translate-loader-static-files'
require 'angular-translate-storage-local'
require 'angular-translate-storage-cookie'
require 'ngTimeago'
require 'oclazyload'
require 'angular-loading-bar'
require 'jquery.browser'
require 'material-colors'

require '../../public/js/templates'

require './components/dashboard/core.coffee'

# Sections
require './components/dashboard/sections/header.coffee'
require './components/dashboard/sections/sidebar.coffee'
require './components/dashboard/sections/menu.coffee'

# Utils
require './components/dashboard/utils/floatbutton.coffee'
require './components/dashboard/utils/bootstrapui.coffee'
require './components/dashboard/utils/colors.coffee'
require './components/dashboard/utils/preloader.coffee'
require './components/dashboard/utils/loadingbar.coffee'
require './components/dashboard/utils/ripple.coffee'
require './components/dashboard/utils/router.coffee'
require './components/dashboard/utils/settings.coffee'
require './components/dashboard/utils/translate.coffee'
require './components/dashboard/utils/utils.coffee'

# Views
require './components/dashboard/views/dashboard.coffee'
require './components/dashboard/views/admin.coffee'
require './components/dashboard/views/repos.coffee'
require './components/dashboard/views/copyrights.coffee'
# require './components/dashboard/views/cards.coffee'
# require './components/dashboard/views/charts.coffee'
# require './components/dashboard/views/elements.coffee'
# require './components/dashboard/views/forms.coffee'
# require './components/dashboard/views/layouts.coffee'
# require './components/dashboard/views/maps.coffee'
# require './components/dashboard/views/pages.coffee'
# require './components/dashboard/views/repos.coffee'
# require './components/dashboard/views/tables.coffee'
# require './components/dashboard/views/user.coffee'

module.exports = angular.module 'copycat.dashboard', [
  'copycat.templates'
  'copycat.dashboard.core'
  'copycat.dashboard.header'
  'copycat.dashboard.sidebar'
  'copycat.dashboard.ripple'
  'copycat.dashboard.floatbutton'
  'copycat.dashboard.menu'
  'copycat.dashboard.preloader'
  'copycat.dashboard.loadingbar'
  'copycat.dashboard.translate'
  'copycat.dashboard.settings'
  'copycat.dashboard.utils'
  'copycat.dashboard.dashboard'
  'copycat.dashboard.admin'
  'copycat.dashboard.repos'
  'copycat.dashboard.copyrights'
  # 'copycat.dashboard.charts'
  # 'copycat.dashboard.cards'
  # 'copycat.dashboard.elements'
  # 'copycat.dashboard.forms'
  # 'copycat.dashboard.tables'
  # 'copycat.dashboard.bootstrapui'
  # 'copycat.dashboard.maps'
  # 'copycat.dashboard.pages'
  # 'copycat.dashboard.user'
  # 'copycat.dashboard.layouts'
]
