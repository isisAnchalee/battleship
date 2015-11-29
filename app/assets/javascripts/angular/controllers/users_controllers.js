var myApp = angular.module('wombattleships', ['ngRoute', 'ngResource']);

myApp.factory('Games', ['$resource',function($resource){
 return $resource('/api/v1/games.json', {},{
 query: { method: 'GET', isArray: true },
 create: { method: 'POST' }
 })
}]);
 
myApp.factory('Game', ['$resource', function($resource){
 return $resource('/api/v1/games/:id.json', {}, {
 show: { method: 'GET' },
 update: { method: 'PUT', params: {id: '@id'} },
 delete: { method: 'DELETE', params: {id: '@id'} }
 });
}]);

myApp.controller("UserListCtr", ['$scope', '$resource', 'Users', 'User', '$location', function($scope, $resource, Users, User, $location) {
  $scope.users = Users.query(); //it's getting user collection
}]);

myApp.config([
 '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
 $routeProvider.when('/games',{
    templateUrl: '/templates/games/index.html',
    controller: 'GameListCtr'
 });
 // $routeProvider.when('/games/new', {
 //   templateUrl: '/templates/users/new.html',
 //   controller: 'UserAddCtr'
 // });
 $routeProvider.when('/games/:id/show', {
   templateUrl: '/templates/games/show.html',
   controller: "UserUpdateCtr"
 });

 $routeProvider.otherwise({
   redirectTo: '/games'
 });
 }
]);