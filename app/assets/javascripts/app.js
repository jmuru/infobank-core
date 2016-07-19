var module = angular.module("admin", ["ngRoute"]);

module.config(function ($routeProvider) {
  $routeProvider
  .when("/", {
    templateUrl : "assets/home.html",
    controller : "mainController"
  })
});
