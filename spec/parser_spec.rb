require_relative '../lib/parser'
require_relative './mocks/file_reader_mock'

RSpec.describe Parser do
  describe '#txt' do
    it 'parses a text file' do
      hands = Parser.new(FileReaderMock.new).txt("some-file.txt")

      expect(hands[:player_1].map(&:to_a)).to eq([
        %w{8C TS KC 9H 4S},
        %w{5C AD 5D AC 9C}
      ])

      expect(hands[:player_2].map(&:to_a)).to eq([
        %w{7D 2S 5D 3S AC},
        %w{7C 5H 8D TD KS}
      ])
    end
  end
end
