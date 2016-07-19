var admin = angular.module("admin", ["ngRoute"])
.config(function ($routeProvider) {
  $routeProvider
  .when("/", {
    templateUrl : "templates/home.html",
    controller : "mainController"
  })
});
