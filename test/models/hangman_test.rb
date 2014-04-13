require 'test_helper'


class Hangman_test < ActiveSupport::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @dictionary = Dictionary.instance
    @dictionary.path =  File.expand_path('../../../test/data/3LetterWord.txt', __FILE__)
    @hangman = Hangman.new(@dictionary)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
    Score.delete_all
  end


  def test_CantChangeStatus
     assert_raise NoMethodError do
          @hangman.status="winner"
     end
  end

  def test_CantChangeMaskedWord
    assert_raise NoMethodError do
      @hangman.maskedWord ="doggie"
    end
  end

  def test_CantChangeMovesLeft
    assert_raise NoMethodError do
      @hangman.maskedWord =1000
    end
  end

  def test_InitializeState
    assert @hangman.maskedWord == "***"
    assert @hangman.movesLeft == 10
    assert @hangman.status == 'playing'
  end

  def test_GuessWrongLetter
    @hangman.guessLetter('z')
    assert @hangman.maskedWord == "***"
    assert @hangman.movesLeft == 9
    assert @hangman.status == 'playing'
  end

  def test_GuessWrongLetterTwice
    @hangman.guessLetter('z')
    @hangman.guessLetter('z')
    assert @hangman.maskedWord == "***"
    assert @hangman.movesLeft == 9
    assert @hangman.status == 'playing'
  end

  def test_GuessWrongLetterTillLost
    @hangman.guessLetter('z')
    @hangman.guessLetter('y')
    @hangman.guessLetter('x')
    @hangman.guessLetter('w')
    @hangman.guessLetter('v')
    @hangman.guessLetter('u')
    @hangman.guessLetter('t')
    @hangman.guessLetter('s')
    @hangman.guessLetter('r')
    @hangman.guessLetter('q')
    assert @hangman.maskedWord == "***"
    assert @hangman.movesLeft == 0
    assert @hangman.status == 'lost'
  end

  def test_GuessWrongLetterTillLostPlusOneMoreGuess
    @hangman.guessLetter('z')
    @hangman.guessLetter('y')
    @hangman.guessLetter('x')
    @hangman.guessLetter('w')
    @hangman.guessLetter('v')
    @hangman.guessLetter('u')
    @hangman.guessLetter('t')
    @hangman.guessLetter('s')
    @hangman.guessLetter('r')
    @hangman.guessLetter('q')
    @hangman.guessLetter('p')
    assert @hangman.maskedWord == "***"
    assert @hangman.movesLeft == 0
    assert @hangman.status == 'lost'
  end

  def test_GuessRightLetter1
    @hangman.guessLetter('d')
    assert @hangman.maskedWord == "d**"
    assert @hangman.movesLeft == 10
    assert @hangman.status == 'playing'
  end

  def test_GuessRightLetter2
    @hangman.guessLetter('d')
    @hangman.guessLetter('g')
    assert @hangman.maskedWord == "d*g"
    assert @hangman.movesLeft == 10
    assert @hangman.status == 'playing'
  end

  def test_GuessRightLetterTillWon
    @hangman.guessLetter('d')
    @hangman.guessLetter('g')
    @hangman.guessLetter('o')
    assert @hangman.maskedWord == "dog"
    assert @hangman.movesLeft == 10
    assert @hangman.status == 'winner'
  end

  def test_GuessRightLetterTillWonPlusOneMoreGuess
    @hangman.guessLetter('d')
    @hangman.guessLetter('g')
    @hangman.guessLetter('o')
    # already won so nothing should change
    @hangman.guessLetter('f')
    assert @hangman.maskedWord == "dog"
    assert @hangman.movesLeft == 10
    assert @hangman.status == 'winner'
  end

  def test_GuessLetterWithBadInput
    assert_raise RuntimeError do
      @hangman.guessLetter('ff')
    end
  end

  def test_WordWith2ofTheSameLetter
    ## custom setup for this one
    @dictionary = Dictionary.instance
    @dictionary.path =  File.expand_path('../../../test/data/WordWith2SameLetters.txt', __FILE__)
    @hangman = Hangman.new(@dictionary)
    @hangman.guessLetter('i')
    assert @hangman.maskedWord=='**i*i**'
  end

  def test_PlayerScoreWin
    @hangman.player = Player.first
    @hangman.guessLetter('d')
    @hangman.guessLetter('g')
    @hangman.guessLetter('o')
    assert @hangman.player.scores[0].win==1
    assert @hangman.player.scores[0].lost==0
  end

  def test_PlayerScoreLost
    @hangman.player = Player.first
    @hangman.guessLetter('z')
    @hangman.guessLetter('y')
    @hangman.guessLetter('x')
    @hangman.guessLetter('w')
    @hangman.guessLetter('v')
    @hangman.guessLetter('u')
    @hangman.guessLetter('t')
    @hangman.guessLetter('s')
    @hangman.guessLetter('r')
    @hangman.guessLetter('q')
    @hangman.guessLetter('p')
    assert @hangman.player.scores[0].win==0
    assert @hangman.player.scores[0].lost==1
  end

end