hackathonPanel = angular
  .module('hackathonPanel', [
    'ngResource',
    'ui.router',
    'templates',
    'ngCookies',
    'smart-table',
    'frapontillo.bootstrap-switch',
    'angular-svg-round-progress',
    'xeditable',
    'ngDialog'
  ])
  .run(['editableOptions', function(editableOptions){
    editableOptions.theme = 'bs3';
  }])
  .config(['$stateProvider', '$urlRouterProvider', '$locationProvider',
    function($stateProvider, $urlRouterProvider, $locationProvider) {
      $stateProvider
        .state('dashboard', {
          url: '/admin/dashboard',
          templateUrl: 'panel_dashboard.html',
          controller: 'AdminController',
          resolve: {
            users: ['User', function(User){
              return User.all().$promise;
            }],
            settings: ['Settings', function(Settings){
              return Settings.all().$promise;
            }]
          },
          onEnter: ['Session', '$rootScope', function(Session, $rootScope){
              Session.get().$promise.then(function(data){
                if (data.user.role == "admin"){$rootScope.user = data.user}
              });
          }]
        })
        .state('users', {
          url: '/admin/users?search',
          templateUrl: 'panel_users.html',
          controller: 'UsersController',
          resolve: {
            users: ['User', function(User){
              return User.all().$promise;
            }],
            query: ['$stateParams', function($stateParams){
              return $stateParams;
            }]
          },
          onEnter: ['Session', '$rootScope', function(Session, $rootScope){
              Session.get().$promise.then(function(data){
                if (data.user.role == "admin"){$rootScope.user = data.user}
              });
          }]
        })
        .state('teams', {
          url: '/admin/teams?search',
          templateUrl: 'panel_teams.html',
          controller: 'TeamsController',
          resolve: {
            teams: ['Team', function(Team){
              return Team.all().$promise;
            }],
            query: ['$stateParams', function($stateParams){
              return $stateParams;
            }]
          },
          onEnter: ['Session', '$rootScope', function(Session, $rootScope){
              Session.get().$promise.then(function(data){
                if (data.user.role == "admin"){$rootScope.user = data.user}
              });
          }]
        })
        .state('entries', {
          url: '/admin/entries?search',
          templateUrl: 'panel_entries.html',
          controller: 'EntriesController',
          resolve: {
            entries: ['Entry', function(Entry){
              return Entry.all().$promise;
            }],
            query: ['$stateParams', function($stateParams){
              return $stateParams;
            }]
          },
          onEnter: ['Session', '$rootScope', function(Session, $rootScope){
              Session.get().$promise.then(function(data){
                if (data.user.role == "admin"){$rootScope.user = data.user}
              });
          }]
        });
      $urlRouterProvider.otherwise('/admin/dashboard');
      $locationProvider.html5Mode({enabled: true, requireBase: false, rewriteLinks: true});
    }]
  );
