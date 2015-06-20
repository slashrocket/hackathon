hackathonPanel
  .factory('Totals', ['$resource', function($resource){
    function Totals(){
      this.service = $resource('/api/totals/:kind.json', {kind:'@kind'});
    };
    Totals.prototype.users = function() {
      return this.service.get({ kind: 'total_users' });
    };
    Totals.prototype.entries = function () {
      return this.service.get({ kind: 'total_entries'});
    };
    return new Totals;
  }]);