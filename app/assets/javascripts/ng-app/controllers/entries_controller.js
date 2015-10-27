hackathonPanel
  .controller('EntriesController', ['$rootScope', '$scope', '$timeout', 'entries', 'query', 'Entry', 'ngDialog',
    function($rootScope, $scope, $timeout, entries, query, Entry, ngDialog) {
      $scope.entries = entries;

      $scope.search = "";
      $timeout(function() {
        if (query.search) {
          var e = document.getElementById('entry_search');
          e.value = query.search;
          var $e = angular.element(e);
          $e.triggerHandler('input');
        };
      }, 60)

      $scope.removeItem = function(entry){
        var index = $scope.entries.indexOf(entry);
        if (index !== -1){
          Entry.delete(entry.id)
          $scope.entries.splice(index, 1);
        }
      };

      $scope.deleteModal = function(entry){
        ngDialog.open({
          template: 'delete_modal.html',
          scope: $scope,
          data: {entry: entry}
        });
      };
  }]);
