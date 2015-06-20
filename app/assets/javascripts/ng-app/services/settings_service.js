hackathonPanel
  .factory('Settings', ['$resource', function($resource){
    function Settings(){
      this.service = $resource('/api/settings/:id.json', {id:'@id'});
    };
    Settings.prototype.all = function(id) {
      return this.service.query({ id: id });
    };
    Settings.prototype.update = function (attr) {
      return this.service.update(attr);
    };
    return new Settings;
  }]);