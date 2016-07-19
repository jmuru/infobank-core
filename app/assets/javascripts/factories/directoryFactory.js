var module = angular.module('admin');

module.factory('directoryService', function($http) {
  var service = {
    listing: function(folder_id) {
      var promise = $http.get(gon.folder_url + "/" + folder_id + "/items.json").then(function(response) {
        // console.log(response.data);
        return response.data;
      });
      return promise;
    }
  };
  return service;
});
