var admin = angular.module("admin", ["ngRoute", "templates"])
.config(function ($routeProvider) {
  $routeProvider
  .when("/", {
    templateUrl : "templates/home.html",
    controller : "mainController"
  })
});
