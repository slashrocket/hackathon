hackathonPanel
  .controller('TeamsController', ['$rootScope', '$scope', '$timeout', 'teams', 'query', 'Team',
    function($rootScope, $scope, $timeout, teams, query, Team) {
      $scope.teams = teams;

      $scope.search = "";
      $timeout(function(){
        if (query.search){
          var e = document.getElementById('team_search');
          e.value = query.search;
          var $e = angular.element(e);
          $e.triggerHandler('input');
        };
      }, 5)

      $scope.removeItem = function(entry){
        var index = $scope.entries.indexOf(entry);
        if (index !== -1){
          Entry.delete(entry.id)
          $scope.entries.splice(index, 1);
        }
      };

  }]);