hackathonPanel
  .controller('ChatController', ['$scope', 'Message',
    function($scope, Message) {
      $scope.messages= Message.all;
      $scope.inserisci = function(message){
        Message.create(message);
      };
  }]);