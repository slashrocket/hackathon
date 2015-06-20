hackathonPanel
  .controller('AdminController', ['$rootScope', 'users',
    function($rootScope, users) {
      $rootScope.users = users;
  }]);