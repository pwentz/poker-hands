require_relative 'file_reader'

class Parser
  HAND_SIZE = 5

  def initialize(reader = FileReader.new)
    @reader = reader
  end

  def txt(file)
    raw_str = @reader.read(file)

    raw_str.split("\n").reduce({player_1: [], player_2: []}) do |acc, row|
      hands = {player_1: row.split.take(HAND_SIZE), player_2: row.split.drop(HAND_SIZE)}
      acc.merge(hands) { |_, old, new| old.push(Hand.new(new)) }
    end
  end
end
