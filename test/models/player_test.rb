require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  def setup
    @player = Player.find(1000)
  end


  def test_GetWins
      assert @player.Wins==2
  end

  def test_GetLosses
    assert @player.Losses==2
  end
end
