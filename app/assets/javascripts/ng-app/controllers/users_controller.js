hackathonPanel
  .controller('UsersController', ['$rootScope', '$scope', 'users',
    function($rootScope, $scope, users) {
      $rootScope.users = users;
  }]);