var module = angular.module('admin');

module.factory('userService', function($http) {
  var service = {
    info: function() {
      var promise = $http.get(gon.user_url + ".json").then(function(response) {
        // console.log(response.data);
        return response.data;
      });
      return promise;
    }
  };
  return service;
});
