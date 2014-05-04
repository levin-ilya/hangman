class Hangman
  include ActiveModel::Serializers::JSON

  private
  attr_accessor :answer
  attr_writer :maskedWord,:movesLeft,:status,:lettersLeft,:lettersUsed

  def guessedWrong
    @movesLeft -= 1
    if @movesLeft == 0
      @status='lost'
      updatePlayerScore()
    end
  end

  def guessedRight(letter)
     updateMaskedWord(letter)
     if @maskedWord==@answer
       @status='winner'
       updatePlayerScore()
     end
  end

  def updateMaskedWord(letter)
    @answer.each_char.each_with_index { |char,position|
      if char==letter
        @maskedWord[position]=letter
      end
    }
  end

  def checkLetter(letter)
    position = @answer.index(letter)
    if position.nil?
      guessedWrong
    else
      guessedRight(letter)
    end
  end


  public
  attr_reader :maskedWord,:movesLeft,:player,:status,:lettersLeft,:lettersUsed
  attr_writer :player

  def initialize(dictionary)
    @answer = dictionary.getRandomWord
    @maskedWord = '_' * @answer.length
    @movesLeft = 10
    @status = 'playing' # possible values: playing || lost || winner
    @lettersLeft = Set.new('a'..'z')
    @lettersUsed = Set.new();
  end

  # method needed for JSON Serializer
  def attributes
    {'answer' => nil,'maskedWord' => nil,'movesLeft' => nil,'status' => nil,'lettersUsed' => nil}
  end



  def guessLetter(letter)
    # make sure the argument is actually a letter
    if letter.length > 1
      raise 'Input must be a letter'
      # make sure the letter hasn't be used yet
    elsif !@lettersUsed.include?(letter) && @status=='playing'
      #add it from letters used
      @lettersUsed.add(letter)
      # check if letter is in the answer
      checkLetter(letter)
    end
  end

  def updatePlayerScore
    score = Score.new
    score.player = player
    if status=='winner'
       score.win = 1
       score.lost = 0
    elsif status =='lost'
       score.win = 0
       score.lost = 1
    end
    score.save()
  end

end