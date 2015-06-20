hackathonPanel
  .factory('Entry', ['$resource', function($resource){
    function Entry(){
      this.service = $resource('/entries/:id.json', {id:'@id'});
    };
    Entry.prototype.all = function(id) {
      return this.service.query({ id: id });
    };
    Entry.prototype.show = function(id) {
      return this.service.get({ id: id });
    };
    Entry.prototype.delete = function(id){
      return this.service.remove({ id: id });
    };
    Entry.prototype.update = function (attr) {
      return this.service.update(attr);
    };
    return new Entry;
  }]);