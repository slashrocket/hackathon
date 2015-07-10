hackathonPanel
  .controller('TeamsController', ['$rootScope', '$scope', '$timeout', 'teams', 'query', 'Team', 'ngDialog',
    function($rootScope, $scope, $timeout, teams, query, Team, ngDialog) {
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

      $scope.updateTeam = function(data, team_id){
        angular.extend(data, {id: team_id})
        Team.update(data);
      };

      $scope.removeItem = function(team){
        var index = $scope.teams.indexOf(team);
        if (index !== -1){
          Team.delete(team.id)
          $scope.teams.splice(index, 1);
        }
      };

      $scope.deleteModal = function(team){
        ngDialog.open({
          template: 'delete_modal.html',
          scope: $scope,
          data: {team: team}
        });
      };

  }]);