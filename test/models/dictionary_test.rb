require 'test_helper'

class Dictionary_test < ActiveSupport::TestCase

   def setup
     @dictionary = Dictionary.instance
     @dictionary.path =  File.expand_path('../../../app/assets/data/bigList.txt', __FILE__)
   end

  def testSingleton
    assert @dictionary===Dictionary.instance
  end

  def testGetRandomWord
    assert @dictionary.getRandomWord()
  end

  def testMissingPath
    @dictionary.path = nil
    assert_raise RuntimeError do
      @dictionary.getRandomWord()
    end
  end
end