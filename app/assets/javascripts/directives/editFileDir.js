var module = angular.module("admin");

module.directive("editWindow", function () {
	return {
		restict: "A",
		templateUrl: "assets/edit_file.html",
		controller: function ($scope) {
			$scope.file = {};
			$scope.editWindow = function (item) {
				console.log(item);
				$scope.file = item;
			} 
		}
	}
});
