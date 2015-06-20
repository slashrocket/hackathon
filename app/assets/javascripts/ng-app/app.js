hackathonPanel = angular
  .module('hackathonPanel', [
    'ngResource',
    'ui.router',
    'templates',
    'ngCookies',
    'smart-table',
    'frapontillo.bootstrap-switch'
  ])
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
          url: '/admin/users',
          templateUrl: 'panel_users.html',
          controller: 'UsersController',
          resolve: {
            users: ['User', function(User){
              return User.all().$promise;
            }]
          },
          onEnter: ['Session', '$rootScope', function(Session, $rootScope){
              Session.get().$promise.then(function(data){
                if (data.user.role == "admin"){$rootScope.user = data.user}
              });
          }]
        })
        .state('entries', {
          url: '/admin/entries',
          templateUrl: 'panel_entries.html',
          controller: 'EntriesController',
          resolve: {
            entries: ['Entry', function(Entry){
              return Entry.all().$promise;
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

  