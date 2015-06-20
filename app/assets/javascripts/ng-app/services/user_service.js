hackathonPanel
  .factory('User', ['$resource', function($resource){
    function User(){
      this.service = $resource('/api/users/:id.json', {id:'@id'});
    };
    User.prototype.all = function(id) {
      return this.service.query({ id: id });
    };
    User.prototype.show = function(id) {
      return this.service.get({ id: id });
    };
    User.prototype.delete = function(id){
      return this.service.remove({ id: id });
    };
    User.prototype.update = function (attr) {
      return this.service.update(attr);
    };
    return new User;
  }]);