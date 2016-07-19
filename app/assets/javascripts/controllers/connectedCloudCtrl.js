var module = angular.module("admin");

module.controller("connectedCloudCtrl", ["$scope", "$rootScope", "userService",
    function($scope, $rootScope, userService) {

      userService.info().then(
  			function(data) {
  				$scope.user = data;
  				console.log($scope.user.stores);
  			}
  		);

        $scope.allClouds = [];

        $rootScope.$on("newCloud", function(event, data) {
            $scope.allClouds.push(data);
        });

        $scope.select = function(cloud) {
            $rootScope.$broadcast("cloudFiles", cloud);
        }

        $scope.hoverIn = function() {
            this.hoverEdit = true;
        };

        $scope.hoverOut = function() {
            this.hoverEdit = false;
        };

    }
])
