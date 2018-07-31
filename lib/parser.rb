require_relative 'file_reader'

class Parser
  def initialize(reader = FileReader.new)
    @reader = reader
  end

  def txt(file:, cards:)
    raw_str = reader.read(file)

    raw_str.split.reduce({}) do |acc, chunk|

    end
  end
end
