class HangmanController < ApplicationController
  before_action :authenticate_player!

  def hangman
      @hangman = session[:game]
      respond_to do |format|
        format.html
        format.json {render :json => @hangman.to_json(:except => [:answer]) }
      end
  end

  def guessletter
     @hangman = session[:game]
     @hangman.guessLetter(params[:letter])
     session[:game] =  @hangman
     render :json => @hangman.to_json(:except => [:answer])
  end

  def newgame
    session.delete(:game)
    @dictionary = Dictionary.instance
    @dictionary.path =  File.expand_path('../../../app/assets/data/bigList.txt', __FILE__)
    @hangman = Hangman.new(@dictionary)
    @hangman.player = current_player
    session[:game] = @hangman
    respond_to do |format|
      format.json {render :json => @hangman.to_json(:except => [:answer]) }
    end
  end

  def topscore
    @topScores = Score.topScores
    respond_to do |format|
      format.html
      format.json {render :json => @topScores}
    end
  end

  def templates
    render params[:id], layout: nil
  end

end
