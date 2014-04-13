class Dictionary
  include Singleton

  private
  attr_accessor :words,:path


  def loadWords
    @words = Array.new
    file = File.new(@path, "rb")
    while (line = file.gets)  do
      @words.push(line.chomp)
    end
    file.close
  end

  public

  def path=(value)
    @path=value
    if !@path.nil?
      loadWords
    end
  end

  def getRandomWord
     if @path.nil?
       raise 'Path to dictionary needs to be set'
     elsif @words.nil?
       loadWords
     end
    @words[rand(@words.size)]
  end

end