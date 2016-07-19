// contoller related to home.html
// used to display files from connected clouds
var module = angular.module("admin");



module.controller("modalController", ["$scope", "$rootScope", "fileService", function($scope, $rootScope, fileService) {

  var credentials = document.getElementsByClassName("credentials");

  function clearInput(inputList) {
    for (var i = 0; i < inputList.length; i++) {
      inputList[i].value = '';
    }
  }

  $scope.addCloud = function(name, type) {
    var cloudInput = document.getElementById("cloud-input");
    var passwordInput = document.getElementById("password-input");
    if (cloudInput.value == "" || passwordInput.value == "") {
      alert("please fill in both credentials");
    }
    else {
      fileService.async().then(function (d) {
        console.log(d);
        $rootScope.$broadcast("newCloud", d);
      })
      clearInput(credentials)
    }
    console.log($scope.allClouds);
  }

}]);
