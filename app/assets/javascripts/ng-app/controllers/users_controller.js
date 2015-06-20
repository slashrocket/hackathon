hackathonPanel
  .controller('UsersController', ['$rootScope', '$scope', '$timeout', 'users', 'query', 'User',
    function($rootScope, $scope, $timeout, users, query, User) {
      
      $scope.users = users;
      
      $scope.search = "";
      $timeout(function(){
        if (query.search) {
          var e = document.getElementById('user_search');
          e.value = query.search;
          var $e = angular.element(e);
          $e.triggerHandler('input');
        };
      }, 60)

      $scope.removeItem = function(user){
        var index = $scope.users.indexOf(user);
        if (index !== -1){
          User.delete(user.id)
          $scope.users.splice(index, 1);
        }
      };
  }]);