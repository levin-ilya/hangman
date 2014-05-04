/**
 * Angular JS Controllers.
 */

var hangmanAppControllers = angular.module('hangmanAppControllers',[]);

// TODO: Use a Resource instead of HTTP
hangmanAppControllers.controller('topScore',['$scope','$http',function($scope,$http){
   $http({method: 'GET', url: '/hangman/topscore.json'}).
    success(function(data, status, headers, config) {
        $scope.topScore = data;
    }).
    error(function(data, status, headers, config) {
           $window.alert("Top Score Request Failed.");
    });
}]);

hangmanAppControllers.controller('HangmanController',['$scope','$http','$location',function($scope,$http,$location){
    var urlLocation = '/hangman/hangman.json';
    if($location.path()=='/newgame') {
        urlLocation = '/hangman/newgame.json';
    }
    $http({method: 'GET', url:urlLocation }).
        success(function(data, status, headers, config) {
            $scope.hangman = data;

            $scope.guessLetter = function (clickEvent){
                var url = "/hangman/guessletter/" + clickEvent.target.id;
                clickEvent.target.className = "usedLetter";
                $http({method: 'GET', url: url}).
                    success(function(data, status, headers, config) {
                        $scope.hangman = data;
                        if(data.status=="winner"){
                            $('#winnerDisplay').foundation('reveal', 'open');
                        }else if(data.status=="lost") {
                            $('#lostDisplay').foundation('reveal', 'open');
                        }
                    }).error(function(data, status, headers, config) {
                        $window.alert("Guessing a letter failed.");

                })
            }
        }).
        error(function(data, status, headers, config) {
            $window.alert("Game Request Failed.");
        });

}]);

hangmanAppControllers.controller('MenuController',['$scope','$http','$location',function($scope,$http,$location){
    $scope.newGame = function(){
        $('#winnerDisplay').foundation('reveal', 'close');
        $('#lostDisplay').foundation('reveal', 'close');
        var urlLocation = '/hangman/newgame';
        $http({method: 'GET', url:urlLocation }).
            success(function(data, status, headers, config) {
                $location.path('/hangman');
            }).
            error(function(data, status, headers, config) {
                $window.alert("New Game Request Failed.");
            });
    }



}]);

