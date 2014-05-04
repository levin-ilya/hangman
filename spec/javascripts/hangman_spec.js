describe('HangmanController', function(){

    var $hangmanFixture = {"maskedWord":"______","movesLeft":10,"status":"playing","lettersUsed":[]}
    var $topScoreFixture = [["ilya*****",19,27],["test*****",2,0]];
    var $scope = null;
    var $controller = null;
    var $httpBackend = null;

    beforeEach(module('hangmanApp'));

    beforeEach(inject(function($injector){
        $scope       = $injector.get('$rootScope').$new()
        $controller  = $injector.get('$controller')
        $httpBackend = $injector.get('$httpBackend')
        $httpBackend.when('GET','/hangman/hangman.json').respond($hangmanFixture)
        $httpBackend.when('GET','/hangman/newgame.json').respond($hangmanFixture)
        $httpBackend.when('GET','/hangman/topscore.json').respond($topScoreFixture)
        $httpBackend.when('GET','/hangman/guessletter/c').respond($hangmanFixture)
    }));

    it('should return hangman Properties',function(){
      $controller('HangmanController',{$scope: $scope});
      $httpBackend.flush()
      //console.dir($scope);
      expect($scope.hangman.status).toBeDefined();
      expect($scope.hangman.maskedWord).toBeDefined();
      expect($scope.hangman.movesLeft).toBeDefined();
      expect($scope.hangman.lettersUsed).toBeDefined();
      expect($scope.guessLetter).toBeDefined();
   });

    it('should return topScore', function(){
        $controller('topScore',{$scope: $scope});
        $httpBackend.flush()
        //console.dir($scope);
        expect($scope.topScore).toBeDefined();
    });

    it('should return hangman properties after guessing a letter',function(){
        var clickEvent = {};
        clickEvent.target = {};
        clickEvent.target.className = "letter";
        clickEvent.target.id ='c';
        $controller('HangmanController',{$scope: $scope});
        $httpBackend.flush()
        $scope.guessLetter(clickEvent);
        $httpBackend.flush()
        expect($scope.hangman.status).toBeDefined();
        expect($scope.hangman.maskedWord).toBeDefined();
        expect($scope.hangman.movesLeft).toBeDefined();
        expect($scope.hangman.lettersUsed).toBeDefined();
        expect(clickEvent.target.className).toBe('usedLetter');
    });

    it('should contain a menu controller',function(){
        $controller('MenuController',{$scope: $scope});
        expect($scope.newGame).toBeDefined();
    });



});
