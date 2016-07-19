var module = angular.module("admin");

module.controller("fileNavController", ["$scope", "$rootScope", "$timeout", "fileService", "directoryService",
    function($scope, $rootScope, $timeout, fileService, directoryService) {

        $scope.file = true;

        var poller = function() {
          var time = 1000;
          directoryService.listing($scope.active_directory).then(
      			function(data) {
      				$scope.directory = data;
              $scope.update_in_progress = data["update_in_progress"];
      			}
      		);
          if ($scope.update_in_progress == false) {
            time = 30000;
          }
          $timeout(poller, time);
        }
        poller();

        $scope.toggleFile = function() {
            $scope.file = $scope.file === false ? true : false;
        }

        $scope.loadDirectory = function(id) {
          $scope.active_directory = id;
          directoryService.listing(id).then(
      			function(data) {
      				$scope.directory = data;
              $scope.update_in_progress = data["update_in_progress"];
      			}
      		);
        }

        $scope.getData = function() {
            fileService.asyncSubsequent().then(function(d) {
                console.log(d);
                $rootScope.$broadcast("treeData", d);
            })
        }

        $scope.hoverIn = function() {
            this.hoverEdit = true;
        };

        $scope.hoverOut = function() {
            this.hoverEdit = false;
        };

        $scope.assembleDownloadUrl = function(id) {
          return gon.download_url + "/" + id + "/content";
        }
    }
]);
