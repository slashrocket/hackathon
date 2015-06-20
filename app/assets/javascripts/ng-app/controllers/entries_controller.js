hackathonPanel
  .controller('EntriesController', ['$rootScope', '$scope', 'entries',
    function($rootScope, $scope, entries) {
      $rootScope.entries = entries;
  }]);