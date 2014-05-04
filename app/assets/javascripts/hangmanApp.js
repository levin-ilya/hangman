/**
 * Created by Ilya on 4/12/14.
 */

var hangmanApp = angular.module('hangmanApp',['ngRoute','hangmanAppControllers']);

hangmanApp.config(['$routeProvider',function($routeProvider) {
    $routeProvider.when('/topScore', {
            templateUrl: '/hangman/templates/topscore.html',
            controller: 'topScore'
        }).when('/hangman', {
        templateUrl: '/hangman/templates/hangman.html',
        controller: 'HangmanController'
    }).when('/newgame', {
        templateUrl: '/hangman/templates/hangman.html',
        controller: 'HangmanController'
    }).otherwise({
        redirectTo: '/newgame'
    });

}]);