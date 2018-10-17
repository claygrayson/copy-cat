module.exports = angular.module "copycat.dashboard.translate", [

]

.config [
  '$translateProvider'
  ($translateProvider) ->
    $translateProvider.useStaticFilesLoader
      prefix: 'server/i18n/'
      suffix: '.json'
    $translateProvider.preferredLanguage 'en'
    $translateProvider.useLocalStorage()
    $translateProvider.usePostCompiling true
    $translateProvider.useSanitizeValueStrategy 'sanitizeParameters'
]

.run [
  '$rootScope', '$translate'
  ($rootScope, $translate) ->
    # Internationalization
    # ----------------------
    $rootScope.language =
      listIsOpen: false
      available:
        'en': 'English'
        'es_AR': 'Español'
      init: ->
        proposedLanguage = $translate.proposedLanguage() or $translate.use()
        preferredLanguage = $translate.preferredLanguage()
        # we know we have set a preferred one in app.config
        $rootScope.language.selected = $rootScope.language.available[proposedLanguage or preferredLanguage]
        return
      set: (localeId) ->
        # Set the new idiom
        $translate.use localeId
        # save a reference for the current language
        $rootScope.language.selected = $rootScope.language.available[localeId]
        # finally toggle dropdown
        $rootScope.language.listIsOpen = !$rootScope.language.listIsOpen
        return
    $rootScope.language.init()
]