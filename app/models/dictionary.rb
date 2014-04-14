class Dictionary
  include Singleton

  private
  attr_accessor :words,:path

  # Loads the words for a text file
  def loadWords
    @words = Array.new
    file = File.new(@path, "rb")
    while (line = file.gets)  do
      @words.push(line.chomp)
    end
    file.close
  end

  public
  # sets the path
  def path=(value)
    @path=value
    if !@path.nil?
      loadWords
    end
  end

  # selects a random word
  def getRandomWord
     if @path.nil?
       raise 'Path to dictionary needs to be set'
     elsif @words.nil?
       loadWords
     end
    @words[rand(@words.size)]
  end

end