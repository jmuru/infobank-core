// contoller related to home.html
// used to display files from connected clouds
var module = angular.module("admin");

module.controller('mainController', ["$scope", "$rootScope", "fileService", "directoryService", "$timeout",
	function($scope, $rootScope, fileService, directoryService, $timeout) {

		$scope.dropbox_url = gon.dropbox_url;
		$scope.active_directory = gon.home_folder;
		$scope.folder_items;
		$scope.update_in_progress = false;

	  $rootScope.$on("cloudFiles", function (event, data) {
	  	$scope.selectedCloud = data;
	  });

	  $rootScope.$on("treeData", function (event, data) {
	  	$scope.selectedCloud = data
	  });
	  $scope.selectedCloud = {};

	}]);
