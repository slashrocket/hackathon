hackathonPanel
  .factory('Session', ['$resource', function($resource){
    function Session(){
      this.service = $resource('/api/current_user');
    };
    Session.prototype.get = function(){
      return this.service.get();
    };
    return new Session;
  }]);