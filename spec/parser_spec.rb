require_relative '../lib/parser'
require_relative './mocks/file_reader_mock'

RSpec.describe Parser do
  describe '#txt' do
    it 'parses a text file' do
      hands = Parser.new(FileReaderMock.new).txt("some-file.txt")

      cards_by_player = hands.transform_values do |hands|
        hands.map(&:to_a)
      end

      expect(cards_by_player[:player_1]).to eq([
        %w{8C TS KC 9H 4S},
        %w{5C AD 5D AC 9C}
      ])

      expect(cards_by_player[:player_2]).to eq([
        %w{7D 2S 5D 3S AC},
        %w{7C 5H 8D TD KS}
      ])
    end
  end
end
