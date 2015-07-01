hackathonPanel
  .factory('Team', ['$resource', function($resource){
    function Team(){
      this.service = $resource('/teams/:id.json', {id:'@id'});
    };
    Team.prototype.all = function(id) {
      return this.service.query({ id: id });
    };
    Team.prototype.show = function(id) {
      return this.service.get({ id: id });
    };
    Team.prototype.delete = function(id){
      return this.service.remove({ id: id });
    };
    Team.prototype.update = function (attr) {
      return this.service.update(attr);
    };
    return new Team;
  }]);