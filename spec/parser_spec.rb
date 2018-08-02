require_relative '../lib/parser'
require_relative './mocks/file_reader_mock'

RSpec.describe Parser do
  describe '#txt' do
    it 'parses a text file' do
      hands = Parser.new(FileReaderMock.new).txt("some-file.txt")

      cards_by_player = hands.transform_values do |val|
        val.map { |hand| hand.cards.map(&:value) }
      end

      expect(cards_by_player[:player_1]).to eq([
        %w{8 T K 9 4},
        %w{5 A 5 A 9}
      ])

      expect(cards_by_player[:player_2]).to eq([
        %w{7 2 5 3 A},
        %w{7 5 8 T K}
      ])
    end
  end
end
