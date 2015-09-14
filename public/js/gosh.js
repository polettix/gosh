(function(){
   var app = angular.module('gosh',
      ['datepicker', 'ngCookies', 'growlNotifications', 'ngAnimate']);


   app.service('goshModel', [
      '$http', '$rootScope',
      function($http, $rootScope) {
         var gm = this;

         this.data = {};
         var endpoint = 'http://localhost:53000';
         var maturity = {
            nothing: 0,
            accounts: 1,
            account_selected: 2,
            catalog: 3
         };

         this.post_events = function(events) {
            events.forEach(function(ev){
               $rootScope.$broadcast('goshModel:' + ev);
            });
         };

         this.reset = function() {
            this.data = {
               accounts: [],
               account_for: {},
               account: null
            };
            this.post_events(['accounts-reset', 'catalog-reset']);
         };

         this.reset_catalog = function() {
            this.data.account.catalog = [];
            this.post_events(['catalog-reset']);
         };

         this.fetch_accounts = function() {
            $http.get(endpoint + '/account').then(
               function(response){
                  var items = gm.data.accounts = response.data.accounts;
                  for (var i = 0; i < items.length; i++) {
                     var account = items[i];
                     account.idx = i;
                     gm.data.account_for[account.username] = account;
                  }
                  gm.post_events(['accounts-ready']);
               },
               function(response) {}
            );
         };

         this.fetch_catalog = function() {
            var a = this.data.account;
            if (a) {
               $http.get(endpoint + '/account/' + a.id + '/catalog').then(
                  function(request){
                     a.catalog = request.data.catalog;
                     gm.post_events(['catalog-ready']);
                  },
                  function(request){}
               );
            }
         };

         this.refresh_accounts = function() {
            this.reset();
            this.fetch_accounts();
         };

         this.refresh_catalog = function() {
            this.reset_catalog();
            this.fetch_catalog();
         };

         this.select_account = function(username) {
            this.data.account = this.data.account_for[username];
            this.refresh_catalog();
            return this.data.account;
         };

         this.select_one_account = function(hint) {
            if (hint && this.has_account_for(hint)) {
               return this.select_account(hint);
            }
            if (this.accounts.length > 0) {
               return this.select_account(this.accounts[0].username);
            }
            this.reset_catalog();
            this.data.account = null;
            return null;
         };

         // this is only valid when status is 'catalog'
         this.get_account = function() {
            return this.data.account;
         };

         this.has_account_for = function(username) {
            return username in this.data.account_for;
         };

         // this is only valid when status is 'accounts'
         this.get_accounts = function() {
            return this.data.accounts;
         };

         this.create_registration = function(request) {
            var userid = this.data.account.id;
            var uri = endpoint + '/account/' + userid + '/register';
            $http.post(uri, request).then(
               function(response) { gm.post_events(['registration-ok']) },
               function(response) { gm.post_events(['registration-ko']) }
            );
         };

         // initialize it all, and we're done
         this.reset();
      }
   ]);

   app.directive('catalog', function(){
      return {
         restrict: 'E',
         templateUrl: 'catalog.html',
         controller: ['goshModel', '$scope', catalog_controller],
         controllerAs: 'catalogCtrl'
      };
   });

   app.directive('account', function(){
      return {
         restrict: 'E',
         templateUrl: 'account.html',
         controller: ['goshModel', '$scope', '$cookies', account_controller],
         controllerAs: 'accountCtrl'
      };
   });

   angular.module('datepicker', []).directive('jqdatepicker',
      function () {
         return {
            restrict: 'A',
            require: 'ngModel',
            link: function (scope, element, attrs, ngModelCtrl) {
               var dp = element.datepicker(
                  {
                     dateFormat: 'dd-mm-yy',
                     showOn: 'both',
                     buttonImage: 'images/calendar.png',
                     onSelect: function (date) {
                        scope.item.date = date;
                        scope.$apply();
                     }
                  }
               );
            }
         };
      }
   );
})();

function account_controller(goshModel, $scope, $cookies) {
   this.choose = function(account) {
      $scope.accountModel.account = goshModel.select_account(account.username);
   };

   $scope.$on('goshModel:accounts-reset', function() {
      $scope.accountModel = {
         accounts: [],
         account: {}
      };
   });

   $scope.$on('goshModel:accounts-ready', function() {
      $scope.accountModel = {
         accounts: goshModel.get_accounts(),
         account: goshModel.select_one_account($cookies.get('username'))
      };
   });

   goshModel.refresh_accounts();
}

function catalog_controller(goshModel, $scope) {
   $scope.notifications = {};

   this.open = function(item) {
      $scope.catalogModel.opened = item;
      item.date = $.datepicker.formatDate('dd-mm-yy', new Date());
      item.selected_amount = item.amount;
   };

   this.is_open = function(item) {
      return $scope.catalogModel.opened === item;
   };

   this.close = function() {
      $scope.catalogModel.opened = null;
   };

   this.record = function(item) {
      var request = {
         activity: item.id,
         amount: item.amount,
         date: item.date
      };
      goshModel.create_registration(request);
   };

   $scope.$on('goshModel:catalog-reset', function() {
      $scope.catalogModel = {
         opened: null,
         catalog: []
      };
   });

   $scope.$on('goshModel:catalog-ready', function() {
      var account = goshModel.get_account();
      $scope.catalogModel = {
         opened: null,  // reset it
         catalog: account.catalog
      };
   });

   var notify = (
      function() {
         var i = 0;
         return function(cls, text) {
            $scope.notifications[i++] = {
               class: cls,
               text: text
            };
         };
      }
   )();

   $scope.$on('goshModel:registration-ok', function() {
      notify('success', 'Registrazione effettuata');
   });
   $scope.$on('goshModel:registration-ko', function() {
      notify('failure', 'Registrazione fallita');
   });
}
