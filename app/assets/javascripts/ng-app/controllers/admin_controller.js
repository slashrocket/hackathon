hackathonPanel
  .controller('AdminController', ['$rootScope', '$scope', '$filter', 'users', 'settings', 'Totals', 'Settings',
    function($rootScope, $scope, $filter, users, settings, Totals, Settings) {

      $rootScope.users = users;
      $rootScope.total_users = Totals.users();
      $rootScope.total_entries = Totals.entries();
      $rootScope.total_teams = Totals.teams();

      $scope.parseInt = parseInt;
      sign_up = $filter('filter')(settings, { var: 'sign_up' });
      submit_entry = $filter('filter')(settings, { var: 'submit_entry' });

      $rootScope.sign_up = sign_up[0]
      $rootScope.submit_entry = submit_entry[0]

      $rootScope.$watch('sign_up.value', () => {
        Settings.update($rootScope.sign_up);
      });

      $rootScope.$watch('submit_entry.value', () => {
        Settings.update($rootScope.submit_entry);
      });


      $rootScope.sign_up_value = function(){
        if ($rootScope.sign_up.value) {
          return "Enabled"
        } else {
          return "Disabled"
        };
      };

      $rootScope.submit_entry_value = function(){
        if ($rootScope.submit_entry.value) {
          return "Enabled"
        } else {
          return "Disabled"
        };
      };
  }]);
