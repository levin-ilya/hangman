class HangmanController < ApplicationController
  before_action :authenticate_player!

  def index
    @dictionary = Dictionary.instance
    @dictionary.path =  File.expand_path('../../../app/assets/data/bigList.txt', __FILE__)
    @hangman = Hangman.new(@dictionary)
    @hangman.player = current_player
    session[:game] = @hangman
  end

  def guessletter
     @hangman = session[:game]
     @hangman.guessLetter(params[:letter])
     session[:game] =  @hangman
     render :json => @hangman.to_json(:except => [:answer])
  end

  def newgame
     session.delete(:game)
     redirect_to(root_path)
  end

  def topscore
    @topScores = Score.topScores
  end

end
