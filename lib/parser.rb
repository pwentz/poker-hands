require_relative 'file_reader'

class Parser
  def initialize(reader = FileReader.new)
    @reader = reader
  end

  def txt(file)
    @reader.read(file).split("\n")
  end
end
