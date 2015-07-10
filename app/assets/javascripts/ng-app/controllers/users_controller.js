hackathonPanel
  .controller('UsersController', ['$rootScope', '$scope', '$timeout', 'users', 'query', 'User', 'ngDialog',
    function($rootScope, $scope, $timeout, users, query, User, ngDialog) {
      
      $scope.users = users;
      $scope.roles = [
        {value: 'user', text: 'user'},
        {value: 'admin', text: 'admin'}
      ]; 
      $scope.search = "";
      $timeout(function(){
        if (query.search) {
          var e = document.getElementById('user_search');
          e.value = query.search;
          var $e = angular.element(e);
          $e.triggerHandler('input');
        };
      }, 5)

      $scope.updateUser = function(data, user_id){
        angular.extend(data, {id: user_id})
        User.update(data);
      };

      $scope.removeItem = function(user){
        var index = $scope.users.indexOf(user);
        if (index !== -1){
          User.delete(user.id)
          $scope.users.splice(index, 1);
        }
      };

      $scope.deleteModal = function(user){
        ngDialog.open({
          template: 'delete_modal.html',
          scope: $scope,
          data: {user: user}
        });
      };

  }]);