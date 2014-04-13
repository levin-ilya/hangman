require 'test_helper'

class ScoreTest < ActiveSupport::TestCase

  #smoke test
  def test_topScoresSmokeTest
    assert Score.topScores
  end
end
