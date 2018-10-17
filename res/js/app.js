/*!
 *
 * Centric - Bootstrap Admin Template
 *
 * Version: 1.3
 * Author: @themicon_co
 * Website: http://themicon.co
 * License: https://wrapbootstrap.com/help/licenses
 *
 */

// APP START
// -----------------------------------

(function() {
    'use strict';

    angular
        .module('centric', [
            'app.core',
            'app.header',
            'app.sidebar',
            'app.ripple',
            'app.floatbutton',
            'app.layouts',
            'app.menu',
            'app.preloader',
            'app.loadingbar',
            'app.translate',
            'app.settings',
            'app.utils',
            'app.dashboard',
            'app.charts',
            'app.cards',
            'app.elements',
            'app.forms',
            'app.tables',
            'app.bootstrapui',
            'app.maps',
            'app.pages',
            'app.user'
        ]);
})();

(function() {
    'use strict';

    angular
        .module('app.utils', [
            'app.colors'
        ]);
})();


(function() {
    'use strict';

    // This component is only used to provide a link in the menu
    // to the jQuery demo. It shows the menu support for direct
    // links using 'href' property.
    angular
        .module('centric')
        .run(jQueryDemoRun);
    jQueryDemoRun.$inject = ['Menu'];

    function jQueryDemoRun(Menu) {

        var menuItem = {
            name: 'HTML5/jQuery',
            href: '../html5jquery/',
            iconclass: 'ion-android-open',
            order: 99
        };

        Menu.addItem(menuItem);

    }
})();


